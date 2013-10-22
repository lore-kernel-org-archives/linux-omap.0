From: Bryan Wu <cooloney@gmail.com>
Subject: Re: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
Date: Tue, 22 Oct 2013 10:22:59 -0700
Message-ID: <CAK5ve-KWdJFuJsvQ+JS2y7bpa9j4hGdU=ceb4nAz8BKQ1M9_XA@mail.gmail.com>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org> <20131022170604.GP15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131022170604.GP15154@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@debian.org>, Sebastian Reichel <sre@ring0.de>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@linaro.org>, Milo Kim <milo.kim@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 22, 2013 at 10:06 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Sebastian Reichel <sre@debian.org> [131022 06:02]:
>> This patch moves the handling of the chip's enable pin from the board
>> code into the driver. It also updates all board-code files using the
>> driver to incorporate this change.
>>
>> This is needed for device tree support of the enable pin.
>
> This seems safe to merge along with the other LED patches, the
> changes to arch/arm/mach-omap2 should not conflict with anything.
>
> So for the arch/arm/mach-omap2 changes:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I'm OK for LED parts, will this patch go through omap tree? If so,
please add my ack.

Acked-by: Bryan Wu <cooloney@gmail.com>

Thanks,
-Bryan
