From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
Date: Tue, 27 Nov 2012 06:20:55 -0800
Message-ID: <87txsb160o.fsf@dell.be.48ers.dk>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
	<1353503469-18634-6-git-send-email-avinashphilip@ti.com>
	<20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
	<518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
	<20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
	<518397C60809E147AF5323E0420B992E3E9EEAAA@DBDE01.ent.ti.com>
	<20121123111811.GA5072@avionic-0098.adnet.avionic-design.de>
	<87mwy8eb7w.fsf@dell.be.48ers.dk>
	<20121124203423.GA26951@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121124203423.GA26951@avionic-0098.adnet.avionic-design.de>
	(Thierry Reding's message of "Sat, 24 Nov 2012 21:34:23 +0100")
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

>>>>> "Thierry" == Thierry Reding <thierry.reding@avionic-design.de> writes:

Hi,

 >> There's several different situations:
 >> 
 >> - Platform without pinctrl support
 >> - Platform with pinctrl support but no pinmux specified in dt for device
 >> (E.G. pinmux setup in bootloader)
 >> - Pinmux specified in dt
 >> - Some kind of misconfiguration in dt
 >> 
 >> You could argue that devm_pinctrl_get_select_default() shouldn't return
 >> an error for the first situation, but how should it be able to know the
 >> difference between 2 and 4?

 Thierry> In case where the platform supports pinctrl but no pinmux is specified
 Thierry> for the device it should just assume that no pinmuxing is needed. That
 Thierry> sounds like the most logical behaviour to me. In those cases pinctrl
 Thierry> could just assume that the default has already been selected and not
 Thierry> return an error.

Agreed.

 Thierry> But you can't reasonably expect to cope with misconfigured DT
 Thierry> content.  Heck, there's no way for you to even know if it is
 Thierry> misconfigured.

With 'misconfigured DT' I just mean any kind of real error.


 Thierry> That said, I'm not sure how much of an issue this really
 Thierry> is. Pinmuxing is only used for functions local to a given
 Thierry> chip, right? So if an SoC supports pinctrl and a given
 Thierry> peripheral needs pinmuxing then we can reasonably assume that
 Thierry> your second case can't happen, can't we?

Well, peripherals only need pinmuxing if the bootloader didn't already
set it up in advance. We could naturally enforce people to add
"redundant" pinmux info to their .dts files, but I'm not sure I like
that idea.

-- 
Bye, Peter Korsgaard
