From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
Date: Tue, 4 May 2010 11:42:15 +0300
Message-ID: <x2w94a0d4531005040142y719ceae9i362341a638ebc976@mail.gmail.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
	 <r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
	 <20100504.090417.242149613.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f217.google.com ([209.85.218.217]:40340 "EHLO
	mail-bw0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0EDImR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 04:42:17 -0400
Received: by bwz9 with SMTP id 9so1955112bwz.29
        for <linux-omap@vger.kernel.org>; Tue, 04 May 2010 01:42:16 -0700 (PDT)
In-Reply-To: <20100504.090417.242149613.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, ohad@wizery.com

On Tue, May 4, 2010 at 9:04 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_=
mbox_init
> Date: Mon, 3 May 2010 20:50:39 +0200
>> =C2=A0 =C2=A0 =C2=A0 2. Compare iommu_get with mailbox_get. iommu_ge=
t uses
>> driver_find_device to get the iommu structure. I guess we can apply
>> the same logic to get mailbox structure. This way we can get rid of
>> omap_mbox_register, omap_mbox_unregister, and find_mboxes functions.
>
> Right. The same logic could be applied.

How? In omap2 there are two mailboxes, but the memory is the same. In
omap4 there are two mailboxes, but the memory region _and_ irqs are
the same.

Platform devices cannot share resources... so all the mailboxes are
part of a single platform device.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
