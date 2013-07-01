From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] N900: fix operation on emulator
Date: Tue, 02 Jul 2013 00:00:02 +0400
Message-ID: <51D1DFC2.4080209@cogentembedded.com>
References: <20130613142809.GA3775@amd.pavel.ucw.cz> <20130613145724.GH8164@atomide.com> <20130613155240.GB3775@amd.pavel.ucw.cz> <20130613161418.GJ8164@atomide.com> <20130613230808.GA14876@amd.pavel.ucw.cz> <20130614055629.GM8164@atomide.com> <20130614212816.GA31768@atrey.karlin.mff.cuni.cz> <20130617111031.GQ20992@atomide.com> <20130701140315.GA15318@amd.pavel.ucw.cz> <51D1C8DD.6040409@cogentembedded.com> <20130701195147.GA22174@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130701195147.GA22174@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hello.

On 07/01/2013 11:51 PM, Pavel Machek wrote:

>>> Errata workarounds for N900 hardware actually break operation on
>>> emulator. Fix it.

>>> This approach was suggested by Pali Roh=E1r <pali.rohar@gmail.com>
>>> (thanks!).

>>> (Also explain what "sleep_ind" led actually does).

>>     Looks like unrelated change and probably worth another patch?

> Separate patch for adding single-line comment?

    If it's unrelated to the main patch purpose, yes. As the Russians=20
say: "cutlets separately and flies separately".

>>> --- a/arch/arm/mach-omap2/board-rx51.c
>>> +++ b/arch/arm/mach-omap2/board-rx51.c
>>> @@ -33,9 +33,12 @@
>>>   #include "pm.h"
>>>   #include "sdram-nokia.h"
>>>   #include "board-rx51-secure.h"
>>> +#include "soc.h"
>>>
>>>   #define RX51_GPIO_SLEEP_IND 162
>>>
>>> +/* This lights up left part of keyboard */
>>> +
>>>   static struct gpio_led gpio_leds[] =3D {
> ...
>>>   #ifdef CONFIG_ARM_ERRATA_430973
>>> -	printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n=
");
>>> -	/* set IBE to 1 */
>>> -	rx51_secure_update_aux_cr(1 << 6, 0);
>>> +	if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_SEC) {
>>> +		printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\=
n");

>>     How about pr_info() instead?

> <sarcasm>Would not that be unrelated change and worth of separate
> patch?</sarcasm>

    No, this would be a related change. Sarcasm wasted.

> :-).

> 									Pavel

WBR, Sergei
