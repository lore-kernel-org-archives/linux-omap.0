From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/5] omap: control: add functions for DSP boot
Date: Thu, 11 Nov 2010 13:12:56 +0200
Message-ID: <AANLkTi=eF+UkXFzMfTi5m-xp9UByzmX+7Yg6C9Vx3E5k@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<1289166209-32251-3-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.2.00.1011101658010.28301@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63051 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab0KKLM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 06:12:58 -0500
Received: by bwz15 with SMTP id 15so1794475bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 03:12:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011101658010.28301@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Thu, Nov 11, 2010 at 2:00 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Felipe,
>
> On Sun, 7 Nov 2010, Felipe Contreras wrote:
>
>> From: Paul Walmsley <paul@pwsan.com>
>>
>> Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control. =C2=A0Th=
ese
>> registers wound up in the System Control Module. =C2=A0Other kernel =
code that
>> wishes to control the DSP's boot process should now use these functi=
ons
>> to do so; subsequent patches implement this in the two in-tree users=
 of
>> these functions.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I see that you modified my original patch, but it seems that you also
> dropped my Signed-off-by:.

Yes, because you didn't s-o-b my changes. I got that complaint from Cat=
alin.

> This is a tricky situation, to be sure.
> Probably the best thing to do in these cases if you don't wish to ask=
 me
> to review the modified patch, =C2=A0is to keep my original Signed-off=
-by: --
> since I wrote the patch, originally -- and then, immediately before y=
our
> Signed-off-by:, to add a bracketed note saying what you changed, e.g.=
,
>
> [felipe.contreras@gmail.com: dropped some changes, etc.]
>
> That way the provenance of the patch is clear.

Ok. I was hoping you would review the patch and put your s-o-b.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
