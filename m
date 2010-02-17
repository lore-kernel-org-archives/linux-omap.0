From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting framework
Date: Wed, 17 Feb 2010 11:50:09 +0200
Message-ID: <94a0d4531002170150s67ed6f5ara019fb1c06f6a241@mail.gmail.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
	 <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
	 <21ed5f939111b381f877fd335b3adc2e779ce8ac.1266326009.git.ameya.palande@nokia.com>
	 <94a0d4531002161042r73c89d1crbc892e7f7de6771f@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CA2B962A@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57740 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067Ab0BQJuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 04:50:11 -0500
Received: by bwz19 with SMTP id 19so5299841bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 01:50:09 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B962A@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

On Wed, Feb 17, 2010 at 4:05 AM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
>>> =C2=A0struct DSPHEAP_RES_OBJECT {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0heapAllocated; /* DMM status */
>>> @@ -141,6 +150,10 @@ struct PROCESS_CONTEXT{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DMM mapped memory resources */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DMM_MAP_OBJECT *dmm_map_list;
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 /* DMM reserved memory resources */
>>> + =C2=A0 =C2=A0 =C2=A0 struct list_head dmm_rsv_list;
>>> + =C2=A0 =C2=A0 =C2=A0 spinlock_t dmm_rsv_list_lock;
>>> +
>>
>>Why rsv requires a spinlock, but not map?
>>
>>I guess it would be needed if somehow PROC_UnReserveMemory() was
>>called by user-space at the same time than bridge_close, but is that
>>really possible? If it is, then the same danger is present with
>>PROC_UnMap() unless I'm missing something.
>
> No, that's not possible. However protection is still needed for PROC_=
 ReserveMemory/UnReserveMemory and also for PROC_Map/UnMap.

Ok, then I guess it would make sense to have a patch for
DMM_RSV_OBJECT, and another one to add the protection to both
PROC_Map/UnMap/Reserve/UnReserve().

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
