From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sat, 17 Mar 2012 10:47:51 +0000
Message-ID: <20120317104751.4F00E3E0910@localhost>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203150922.06379.arnd@arndb.de> <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33734 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab2CQPRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Mar 2012 11:17:21 -0400
Received: by lbbgm6 with SMTP id gm6so2560483lbb.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Mar 2012 08:17:19 -0700 (PDT)
In-Reply-To: <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>

On Thu, 15 Mar 2012 11:27:36 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> * Arnd Bergmann wrote:
> > On Thursday 15 March 2012, Nicolas Ferre wrote:
> [...]
> > > +	i2c1: i2c@1 {
> > > +		...
> > > +		dma-request = <&sdma 2 &sdma 3>;
> > > +		dma-request-names = "tx", "rx";
> > > +		...
> > > +	};
> > 
> > This is slightly different from how the proposed pwm binding works that
> > Thierry is working on, which uses an arbitrary property name instead of
> > requiring the use of a specific property but then allowing to give names
> > in another property.
> > 
> > I don't care much which way it's done, but please try to agree on one
> > approach that is used for both.
> > 
> > The one you have here is already used by reg and irq, while the other
> > one is used in gpio.
> 
> I think we can just use pwm as the fixed property name. Or alternatively do
> something along the lines of the regulator bindings, where we use "-pwm" as
> the suffix for specifying PWM devices. For instance if a named PWM is
> requested, the OF support code would look for a <name>-pwm property, while
> requesting an unnamed PWM would simply look at the pwm property.
> 
> When it comes to the labelling of PWM devices, I don't think both variants
> are exclusive. Currently the PWM framework uses name of the user OF device
> node for the PWM label. That is, if I have the following in the DTS:
> 
> 	pwm {
> 		..
> 	};
> 
> 	backlight {
> 		compatible = "pwm-backlight";
> 		pwm = <&pwm 0 5000000>;
> 		...
> 	};
> 
> Then the PWM will be labelled "backlight":
> 
> 	$ cat cat /sys/kernel/debug/pwm
> 	platform/tegra-pwm, 4 PWM devices
> 	pwm-0   (backlight           ): requested enabled
> 	pwm-1   ((null)              ):
> 	pwm-2   ((null)              ):
> 	pwm-3   ((null)              ):
> 
> So if we decide to explicitly allow specifying names, then we can always add
> a pwm-names property (or <name>-pwm-names respectively) to use as label and
> fallback to the user OF device node name if that property is not present.

After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
I definitely prefer the fixed property name plus a separate names property.
It is easier to use common code with that scheme, and easier to statically
check for correctness.

g.
