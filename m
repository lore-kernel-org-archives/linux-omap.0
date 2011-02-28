From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: omap: pm: assumptions on TWL and SmartReflex.
Date: Mon, 28 Feb 2011 12:47:29 +0530
Message-ID: <cdc0bd5bb38c217d5b66511422b42f04@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B6@dbde02.ent.ti.com> <AANLkTimxp74FpmNaCsS9V3L8jMdC5_f28Gnd9YxqNMnJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57953 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752586Ab1B1HRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 02:17:32 -0500
Received: by ewy6 with SMTP id 6so1193119ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 23:17:30 -0800 (PST)
In-Reply-To: <AANLkTimxp74FpmNaCsS9V3L8jMdC5_f28Gnd9YxqNMnJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, February 24, 2011 12:02 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omap: pm: assumptions on TWL and SmartReflex.
>
> On Wed, Feb 23, 2011 at 19:57, Premi, Sanjeev <premi@ti.com> wrote:
> > Hi all,
> >
> > While trying to suport TPS65023 with AM3517 processor, i realize
> > that much of the code has implicit assumption on usage of TWLx0y0
> > PMIC and Smartreflex.
> Looking at the data sheet, single SCLK, SDAT makes me think that you
> are potentially attempting SR Class2 here. am I right?
>
> The other potential usage is configure the chip over vcbypass and then
> use class3 with reg address 0x6, 0x8 for DCDC1 and LDO1/2-> though i
> am not sure how you'd use SR for LDO1/2 with 200mA and non linear
> value2voltage.. the other possibility is you have two independent
> TPS65023 chips on each rail..
> may be you could briefly explain how you are integrating it all up to
> understand the weakness of the datastructures involved..
>
> > Check the definition of omap_volt_pmic_info and omap_volt_data.
Most of these parameters are required by OMAP for VP/VC configuration. I
agree that these parameters need to be segregated better to have PM IC
specific, OMAP specific and Board specific parameters. But I do not
understand why you are saying that these are TWL specific.

Can TPS65023 be controlled via VC/VP over i2c4? If so then these
parameters will be needed by VC/VP to control the PM IC.
If not, then there is no need to hook up your PMIC with OMAP voltage
layer. You can perhaps use regulator framework for setting the voltage.

Regards
Vishwa
> >
> > Just to "hack" support we can fill *don't care* values for the
> > fields not supported and wrap processing under if (cpu_is_....())
> > checks; but this doesn't appear to be a good solution.
> yes, there are improvements possible. we probably need to see your
> usage to comeup with something that works for all of us
> >
> > Also, the PMIC specific code doesn't really belong to mach-omap2.
> > OR was there a specific reason to keep it here??
> potentially - but there are PMIC specific parameters that need to be
> configured for the SR driver to function as well..
>
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
