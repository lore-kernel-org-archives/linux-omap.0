From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] phy: Add a driver for dm816x USB PHY
Date: Wed, 18 Mar 2015 07:56:33 -0700
Message-ID: <20150318145632.GM31346@atomide.com>
References: <1426637554-27178-1-git-send-email-tony@atomide.com>
 <1426677211.15575.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426677211.15575.27.camel@x220>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> [150318 04:13]:
> Two trivialities I failed the spot the first time.
> 
> On Tue, 2015-03-17 at 17:12 -0700, Tony Lindgren wrote:
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 2962de2..c858c2b 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> 
> > +config PHY_DM816X_USB
> > +	tristate "TI dm816x USB PHY driver"
> > +	depends on ARCH_OMAP2PLUS
> > +	select GENERIC_PHY
> > +	help
> > +	  Enable this for dm81xx USB to work."
> > +
> 
> A trailing double quote.

Oops thanks for spotting that, will remove.
 
> > --- /dev/null
> > +++ b/drivers/phy/phy-dm816x-usb.c
> 
> > +MODULE_ALIAS("platform: dm816x_usb");
> 
> That space looks odd. Will it be removed by scripts/mod/file2alias.c? Or
> will it end up in the mdule, in modules.alias, and presumably break
> something (I'm not sure what, actually)?
> 
> There are currently six other instances MODULE_ALIAS() that have a space
> there. That would mean they're all broken, somehow, which would be
> unlikely, so I guess it's just a stylistic nit.

That looks like copy paste error, will fix. It seems like a style issue,
there's commit dd64ad387cc0 ("phy: ti/omap: Fix modalias") fixing those
up for drivers/phy.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
