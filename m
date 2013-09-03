From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v11 0/8] PHY framework
Date: Tue, 3 Sep 2013 08:50:30 -0700
Message-ID: <20130903155030.GA21525@kroah.com>
References: <1377063973-22044-1-git-send-email-kishon@ti.com>
 <521B0E79.6060506@ti.com>
 <20130827192059.GZ3005@radagast>
 <5225FF63.6080608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5225FF63.6080608-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 03, 2013 at 08:55:23PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On Wednesday 28 August 2013 12:50 AM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Aug 26, 2013 at 01:44:49PM +0530, Kishon Vijay Abraham I wrote:
> >> On Wednesday 21 August 2013 11:16 AM, Kishon Vijay Abraham I wrote:
> >>> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> >>> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> >>> the PHY with or without using phandle.
> >>>
> >>> This framework will be of use only to devices that uses external PHY (PHY
> >>> functionality is not embedded within the controller).
> >>>
> >>> The intention of creating this framework is to bring the phy drivers spread
> >>> all over the Linux kernel to drivers/phy to increase code re-use and to
> >>> increase code maintainability.
> >>>
> >>> Comments to make PHY as bus wasn't done because PHY devices can be part of
> >>> other bus and making a same device attached to multiple bus leads to bad
> >>> design.
> >>>
> >>> If the PHY driver has to send notification on connect/disconnect, the PHY
> >>> driver should make use of the extcon framework. Using this susbsystem
> >>> to use extcon framwork will have to be analysed.
> >>>
> >>> You can find this patch series @
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git testing
> >>
> >> Looks like there are not further comments on this series. Can you take this in
> >> your misc tree?
> > 
> > Do you want me to queue these for you ? There are quite a few users for
> > this framework already and I know of at least 2 others which will show
> > up for v3.13.
> 
> Can you queue this patch series? There are quite a few users already for this
> framework.

It will have to wait for 3.13 as the merge window for new features has
been closed for a week or so.  Sorry, I'll queue this up after 3.12-rc1
is out.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
