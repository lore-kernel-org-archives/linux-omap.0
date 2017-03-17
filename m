From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Fri, 17 Mar 2017 07:00:33 -0700
Message-ID: <20170317140032.GR20572@atomide.com>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170317114839.GA4771@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317114839.GA4771@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [170317 04:50]:
> Hi!
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
> Actually, I'd use orientation with keyboard open (horizontal) -- as
> that's how the console will be orientated (right?) and how the linux
> will be most useful...

Right, so how can we do that by default? I currently have
"fbcon=rotate:1" in cmdline.

BTW, I think with omap4 we have the tiler hardware taking care
of the rotation on omap4, well I have not verified that though.

Regards,

Tony
