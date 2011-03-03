From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/19] omap3+: voltage: remove initial voltage
Date: Wed, 02 Mar 2011 16:53:27 -0800
Message-ID: <87r5apt46w.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-4-git-send-email-nm@ti.com>
	<bd6822eaf1535de0f30aa64a31c15f6c@mail.gmail.com>
	<4D60A2AC.1030704@ti.com>
	<1000eadc0be6e053b04840566bb7c98a@mail.gmail.com>
	<AANLkTinW+ekEy6uSQcFYYFiUkSYi2h9Mp5q_ct3p5nat@mail.gmail.com>
	<fee6fa5d6bc637b4f2cd778235fbb01b@mail.gmail.com>
	<AANLkTi=ofKtTZjSjEaPyeK52isPZhaVK8_cb1-LZ1qUT@mail.gmail.com>
	<8762s1xep6.fsf@ti.com> <4D6EE248.3010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34810 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1CCAxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:53:31 -0500
Received: by gxk21 with SMTP id 21so209111gxk.36
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:53:30 -0800 (PST)
In-Reply-To: <4D6EE248.3010205@ti.com> (Nishanth Menon's message of "Thu, 03
	Mar 2011 06:05:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

[...]

>
> Does the following sound any better?:

Yes, thanks.

> Blindly setting a 1.2v setting in the initial structure may not even
> match the default voltages stored in the voltage table which are
> supported for the domain. For example, OMAP3430 core domain does not
> use 1.2v and ends up generating a warning on the first transition.
>
> Further, since omap2_set_init_voltage is called as part of the pm
> framework's initialization sequence to configure the voltage required
> for the current OPP, the call does(and has to) setup the system
> voltage(curr_volt as a result) using the right mechanisms appropriate
> for the system at that point of time. This also overrides
> initialization we are currently doing in voltage.c  making it
> redundant. So remove the wrong and useless initialization.
