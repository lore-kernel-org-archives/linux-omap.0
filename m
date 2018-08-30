From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] leds: add TI LMU backlight driver
Date: Thu, 30 Aug 2018 21:20:18 +0200
Message-ID: <c72eb0ff-b54c-4670-580c-e31625b3c275@gmail.com>
References: <20180829212032.GB15786@amd> <20180830082219.GA10133@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830082219.GA10133@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Thank you for the patch.

Looking for DT bindings I can find the following

Documentation/devicetree/bindings/mfd/ti-lmu.txt,

which for LED bindings redirects to:

"[2] ../leds/leds-lm3633.txt",

but it is not present in the mainline.

Best regards,
Jacek Anaszewski

On 08/30/2018 10:22 AM, Pavel Machek wrote:
> 
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> 
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
> 
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
[...]
