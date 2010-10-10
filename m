From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] omap: dsp: fix ioremap() usage
Date: Sun, 10 Oct 2010 23:39:33 +0300
Message-ID: <AANLkTim8HHT3BQSVSZx_2yBo6SZFj+XR-XYrjNZg+ntW@mail.gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302342AE533@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47489 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0JJUjf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 16:39:35 -0400
Received: by bwz15 with SMTP id 15so1324822bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 13:39:34 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302342AE533@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

Hi,

Please remove the chunks you are not replying to.

On Sun, Oct 10, 2010 at 11:17 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -void __init omap_reserve(void)
>> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODUL=
E)
>
> [sp] I do understand that dspbridge is the only driver accessing dsp =
in
> =C2=A0 =C2=A0 the linux-omap; but there are other known drivers - whi=
ch would need
> =C2=A0 =C2=A0 this feature.

Are you talking about linux-omap the tree? If so, no, the tidspbridge
is part of staging, not linux-omap.

If you are trying to say there are other DSP drivers intended for
OMAP, then I guess you are referring to dsp-link, which uses it's own
tricks for contiguous memory allocation (CMEM).

So, who and how would benefit from this?

> =C2=A0 =C2=A0 Can we use a more generic config option viz. CONFIG_RES=
ERVE_DSPMEM
> =C2=A0 =C2=A0 (or something similar) so that code is easily (re)usabl=
e.

How about CONFIG_OMAP_DSP, and CONFIG_OMAP_DSP_RESERVE_SIZE?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
