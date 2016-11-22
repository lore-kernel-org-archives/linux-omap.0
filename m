From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: mfd: Improve readability for TPS65217 interrupt sources
Date: Tue, 22 Nov 2016 22:08:10 +0100
Message-ID: <2502592.54T1nU6yzL@wuerfel>
References: <20161121131515.8040-1-woogyom.kim@gmail.com> <20161122155759.GG10134@dell.home> <20161122160013.GH10134@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161122160013.GH10134-Re9dqnLqz4GzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday, November 22, 2016 4:00:13 PM CET Lee Jones wrote:
> > > diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> > > index cafb9e6..0293fdd 100644
> > > --- a/include/dt-bindings/mfd/tps65217.h
> > > +++ b/include/dt-bindings/mfd/tps65217.h
> > > @@ -19,8 +19,8 @@
> > >  #ifndef __DT_BINDINGS_TPS65217_H__
> > >  #define __DT_BINDINGS_TPS65217_H__
> > >  
> > > -#define TPS65217_IRQ_USB   0
> > > -#define TPS65217_IRQ_AC            1
> > > -#define TPS65217_IRQ_PB            2
> > > +#define TPS65217_IRQ_USB_POWER             0       /* USB power state change */
> > > +#define TPS65217_IRQ_AC_POWER              1       /* AC power state change */
> > > +#define TPS65217_IRQ_PUSHBUTTON            2       /* Push button state change */
> > 
> > This changes the ABI.
> > 
> > It will require a DT Ack.
> 
> Tell a lie.  Sorry, I was getting false positives from my grep.  It
> looks like you use the same scheme from within include/linux.  I
> suggest that you probable don't want to do that.

Doing this change however would cause a bisection problem: you
can't rename just the constants in the header or just the driver
using those constants.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
