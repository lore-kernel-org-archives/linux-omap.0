From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 1/1] OMAP4: DSS: Add panel for Blaze Tablet boards
Date: Fri, 8 Feb 2013 13:48:30 +0100
Message-ID: <20130208124829.GB10564@jack.whiskey>
References: <1360248051-16541-1-git-send-email-ruslan.bilovol@ti.com>
 <1360248051-16541-2-git-send-email-ruslan.bilovol@ti.com>
 <20130207145952.GA7860@jack.whiskey>
 <CAB=otbTH8bQp5X4Y2cvMYKwYqMbT0HQxmuRD9gRtna=-vy2ptA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbTH8bQp5X4Y2cvMYKwYqMbT0HQxmuRD9gRtna=-vy2ptA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: Andi Shyti <andi@etezian.org>, tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

> Thanks for looking into

if you want you can put me in CC and I can review the next
patches (perhaps V2 of the patches)

> >> +     mutex_lock(&tc358765_i2c->xfer_lock);
> >> +     ret = i2c_transfer(tc358765_i2c->client->adapter, &msg, 1);
> >> +     mutex_unlock(&tc358765_i2c->xfer_lock);
> >
> > What about using smbus?
> 
> OMAP2+ SoCs have full I2C controller so panel drivers traditionally use I2C.
> Since implementation is OMAP-specific, I don't think we need to use smbus here.
> 
> Also please look at other panels implementation:
> drivers/video/omap2/displays/panel-tfp410.c
> drivers/video/omap2/displays/panel-picodlp.c

Yeah, it's the same problem with other i2c drivers, they should
be written to be working as much as possible with the emulated
smbus.

I don't actually know the internals of the omap2 driver
controller, but not being able to use smbus, definitely sucks!

> Will be fixed in next patchset

What about sending a patch V2? :)

Andi
