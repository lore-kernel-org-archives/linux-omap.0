From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
Date: Fri, 18 Nov 2016 10:42:10 -0600
Message-ID: <20161118164210.xumqsn3gfd54vv5g@rob-hp-laptop>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
 <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e69a797c-bec3-2243-5c19-9d7633092369-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 17, 2016 at 08:56:18PM -0600, Nishanth Menon wrote:
> On 11/17/2016 08:44 PM, Robert Nelson wrote:
> again.. a short commit message at least please? :)
> 
> > Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> > CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> > index 6df7829..3bc47be 100644
> > --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> > +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> > @@ -97,6 +97,12 @@
> >  		#cooling-cells = <2>;
> >  	};
> > 
> > +	gpu-subsystem {
> A) do we want to make things clear that this is gpu subsystem for gc320?

No.

> B) How about other platforms that could equally reuse?

Better yet, get rid of this nonsense. You are defining a wrapper to 
group 1 nodes. Yes, I know this is what the driver wants, but you should 
be able to make it deal with this situation and only have a gc320 node.

> > +		compatible = "ti,gc320-gpu-subsystem";
> > +		cores = <&bb2d>;
> > +		status = "okay";
> > +	};
> > +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
