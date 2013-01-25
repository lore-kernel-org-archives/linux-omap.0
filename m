From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Fri, 25 Jan 2013 13:21:12 +0100
Message-ID: <510278B8.40809@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch> <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch> <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com> <5101A43D.7080108@epfl.ch> <51024254.40208@ti.com> <5102756A.9040901@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:42925 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755890Ab3AYMVR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jan 2013 07:21:17 -0500
In-Reply-To: <5102756A.9040901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

>>
>> We have two drivers at the moment: pwm-twl and pwm-twl-led. However new out of
>> SoC PWM drivers might come (for example for palmas). So it worth take a look
>> at some generic implementation.
>
> OK. So I have the series. I need to add few more things but pwm-leds on
> BeagleBoard works fine when I put the default_trigger for the pmustat LED to
> be mmc0. It is blinking happily ;)
> I'll CC you with the patches when I send them.
>

I sent a patchset 2 hours ago with you in CC, you haven't received them?

Cheers,

Florian
