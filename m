From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Fri, 25 Jan 2013 13:30:09 +0100
Message-ID: <51027AD1.60107@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch> <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch> <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com> <5101A43D.7080108@epfl.ch> <51024254.40208@ti.com> <5102756A.9040901@ti.com> <510278B8.40809@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36830 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3AYMaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 07:30:20 -0500
In-Reply-To: <510278B8.40809@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On 01/25/2013 01:21 PM, Florian Vaussard wrote:
>>>
>>> We have two drivers at the moment: pwm-twl and pwm-twl-led. However=
 new out of
>>> SoC PWM drivers might come (for example for palmas). So it worth ta=
ke a look
>>> at some generic implementation.
>>
>> OK. So I have the series. I need to add few more things but pwm-leds=
 on
>> BeagleBoard works fine when I put the default_trigger for the pmusta=
t LED to
>> be mmc0. It is blinking happily ;)
>> I'll CC you with the patches when I send them.
>>
>=20
> I sent a patchset 2 hours ago with you in CC, you haven't received th=
em?

I have not noticed them. Going through them right now.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
