From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Wed, 1 Mar 2017 17:49:11 -0800
Message-ID: <20170302014910.GM20572@atomide.com>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302013707.GK20572@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170301 17:45]:
> * Sebastian Reichel <sre@kernel.org> [170301 17:10]:
> > Hi,
> > 
> > Tony, since your omap4-droid4 dts patches were not
> > yet in a public repository and they would merge conflict
> > with my patches I put them all together into a single
> > patchset. I also added my Tested-By to your patches.
> 
> OK
> 
> > The mounting-matrix for the sensors and the touchscreen's 
> > rotation assume, that the phone's default rotation is vertical.
> > I think that's sensible, because
> > 
> >  * Android on the phone uses this as default rotation
> >    (like almost? all other phones)
> >  * volume buttons make sense (in horizontal position one
> >    would expect, that left button means lower volume. I
> >    know at least Maemo swaps them)
> > 
> > That should cover all mainline drivers.
> 
> Heheheh cool looks like you configured compass and accelerometer :)
> 
> I have a better touchscreen patch that also configures the wakeirq
> that I did not post yet at http://muru.com/linux/d4/patches/ in the
> updated set droid4-wip-next-20170217.tar.gz.
> 
> I have few more interesting ones coming, I got the HDMI working
> reliably over the weekend. I was planning on waiting until -rc1 to
> post them but let's see if I can send few patches out before that.

Oh and I have the poweroff-gpio patch and tmp105 patch.

And the LMU backlight patch should be OK to go as the binding was
already acked a while back.

Some of the command mode LCD patches could be sent out too, and
if the timing patch is OK then we can configure the LCD in the dts
too. Have you had a chance to look at those related to what all I
broke for n950?

Regards,

Tony
