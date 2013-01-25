From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Fri, 25 Jan 2013 09:29:08 +0100
Message-ID: <51024254.40208@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch> <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch> <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com> <5101A43D.7080108@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab3AYI3T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jan 2013 03:29:19 -0500
In-Reply-To: <5101A43D.7080108@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/24/2013 10:14 PM, Florian Vaussard wrote:
> You are right. But then the pwm core must provide a way to know if th=
e pwm
> access function are callable
> from atomic context or not (the gpio framework provides gpio_cansleep=
()).
> This implies a good amount of changes to the pwm framework, and curre=
ntly we
> are the only driver using non-atomic access.

We have two drivers at the moment: pwm-twl and pwm-twl-led. However new=
 out of
SoC PWM drivers might come (for example for palmas). So it worth take a=
 look
at some generic implementation.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
