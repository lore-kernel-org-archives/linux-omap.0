From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 21:56:29 +0200
Message-ID: <20150529195629.GA9811@amd>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150529194955.GV2026@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, maxime.ripard@free-electrons.com, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri 2015-05-29 14:49:55, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > Fix dts to match what the Linux kernel expects. This works around
> > touchscreen problems in 4.1 linux on Nokia n900.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > index 4b641c7..09089a6 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > @@ -32,8 +32,8 @@ Example:
> >  		touchscreen-fuzz-x = <4>;
> >  		touchscreen-fuzz-y = <7>;
> >  		touchscreen-fuzz-pressure = <2>;
> > -		touchscreen-max-x = <4096>;
> > -		touchscreen-max-y = <4096>;
> > +		touchscreen-size-x = <4096>;
> > +		touchscreen-size-y = <4096>;
> 
> IMHO, the older binding needs to be supported as well. It's fine to
> update the DTS for the new binding, but even Documentation says
> touchscreen-max-[xy] and if the driver changed that, the driver should
> be fixed too. Besides, it seems like this has been in tree since
> v3.16:

Agreed. In parent email, I have list of two commits that should be
reverted.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
