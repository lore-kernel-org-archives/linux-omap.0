From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Thu, 17 Aug 2017 00:23:44 +0300
Message-ID: <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 16, 2017 at 10:59:15PM +0200, Pavel Machek wrote:
> > Hi,
> > 
> > On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> > > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > index 852041a..aade681 100644
> > > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > @@ -119,6 +119,8 @@ Optional endpoint properties
> > >    as 0 (normal). This property is valid for serial busses only.
> > >  - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
> > >    with CCP2, for instance.
> > > +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
> > > +- crc: crc is in use
> > 
> > booleans in DT are not done with <0> and <1>, but as properties without
> > values. True = property exists, False = property does not exist.

Now that you mention it, I remember that now.

> 
> Well, strobe property above already uses = <0>/<1> format, as do
> others.
> 
> Problem with "false = property does not exist" is that you don't know
> if it is "someone forgot to define it" or "someone made a typo" or
> "dts is too old to know about this property" or "the property indeed
> should be false"...

As this is an established practice, I think we should follow it for bool
properties.

We could change the existing ones, too, and leave some extra checks in
place to handle old dtbs.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
