From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Wed, 1 Feb 2012 09:27:53 +0200
Message-ID: <CAMP44s23vhhFi19hZ03dXJaKKQPP2J=5uSvOUNAcWUqVN6OE4w@mail.gmail.com>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
	<1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
	<20120131082136.GC3294@mwanda>
	<CAB-zwWg9iudV7o5opYHOMHo8HN9EGB+n0f=mAHQCNWZovHrdvQ@mail.gmail.com>
	<20120131184338.GO3356@mwanda>
	<CAMP44s2yssE0_4NnZ=+hhU3_LoV+Uay7Rjmn8m_8RQZefH7knQ@mail.gmail.com>
	<20120201065846.GP3356@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63475 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753770Ab2BAH1z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 02:27:55 -0500
Received: by lagu2 with SMTP id u2so489462lag.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 23:27:53 -0800 (PST)
In-Reply-To: <20120201065846.GP3356@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Wed, Feb 1, 2012 at 8:58 AM, Dan Carpenter <dan.carpenter@oracle.com=
> wrote:
> On Tue, Jan 31, 2012 at 09:39:00PM +0200, Felipe Contreras wrote:
>> On Tue, Jan 31, 2012 at 8:43 PM, Dan Carpenter <dan.carpenter@oracle=
=2Ecom> wrote:
>> > How often do people rmmod things on a production system? =C2=A0Hop=
efully,
>> > never right?
>>
>> That's right... At least in recent versions of the tidspbrdige, that
>> have recovery support. Before, we needed a script to detect MMU
>> faults, and reload the module =3D/ IIRC this is still the case on th=
e
>> Nokia N900.
>
> If you have a script that's doing rmmods then that's different. =C2=A0=
I
> didn't know about that.

*Had*, there's no need any more.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
