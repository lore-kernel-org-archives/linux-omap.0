From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] gpio: twl4030: Use only TWL4030_MODULE_LED for LED configuration
Date: Mon, 19 Nov 2012 09:52:05 +0100
Message-ID: <50A9F335.80107@ti.com>
References: <1352799313-21019-1-git-send-email-peter.ujfalusi@ti.com> <CACRpkdayZK2sPXJW=COFi7C=P5=fbi-q7UukWbQ8dheaJ=bjAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab2KSIwJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 03:52:09 -0500
In-Reply-To: <CACRpkdayZK2sPXJW=COFi7C=P5=fbi-q7UukWbQ8dheaJ=bjAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Linus,

On 11/17/2012 09:16 PM, Linus Walleij wrote:
> On Tue, Nov 13, 2012 at 10:35 AM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>=20
>> Avoid using the TWL4030_MODULE_PWMA/B as module ID. The LEDEN, PWMA =
ON/OFF
>> and PWMB ON/OFF registers are in a continuous range starting from LE=
D base.
>> This is going to be helpful for further cleanup in the twl stack.
>>
>> No functional changes.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> OK if you say so.
>=20
> Patch applied!

Thanks,

I was actually tempted to remove the whole LED (PWM) thing from the
gpio-twl4030 driver. It was a big surprise to me to see something like =
this in
there.
It turns out that on BeagleBoard the USB host enable signal is connecte=
d to
LEDA (PWMA) of twl4030... It is an enable signal. Seriously. So what we=
 do
here is either configure the PWMs as full on, or turn it off.
I'm not sure how common is this practice (PWM to drive enable signal) b=
ut if
we have more than one board out there with this type of connection we m=
ight be
better to add a 'gpio-pwm.c' driver to handle them.
Either way this is wrong IMHO to handle the LEDA/B via the gpio-twl4030=
 driver.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
