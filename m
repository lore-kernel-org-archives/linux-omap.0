From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 20 Jul 2011 12:55:13 -0600
Message-ID: <20110720185513.GI4642@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com>
 <20110706185546.GJ4871@ponder.secretlab.ca>
 <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
 <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
 <20110720110419.GA6999@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110720110419.GA6999-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 20, 2011 at 07:04:20PM +0800, Shawn Guo wrote:
> > Mostly consistency.  Most of the experience we have with the flattened
> > device tree up to this point hasn't bothered with the 'status'
> > property.  It is only when AMP and hypervisors cam online that it
> > became important to use a status property, and that only when the
> > kernel needs to be told that the device does indeed exist, but it must
> > not be touched.  I'd like to continue that pattern for new DT users
> > with the default assumption that a device is enabled unless the board
> > .dts explicitly disables it.
[...]
> Besides the bothering that we have to list so many unused controllers
> in individual board dts file, it's also hard to tell which controllers
> are actually available on the board.  People have to look at imx53.dts
> to get a full list and then exclude the ones in imx53-<board>.dts as
> "disabled".
> 
> And if we go the way opposite, adding "disabled" status for everyone
> in imx53.dts, we will only need to specify the peripherals that are
> actually available on board with "okay" status in imx53-<board>.dts.
> And it's much more clear for people to see what peripherals are
> available on individual board.
> 
> So I'm going the way than you suggested.  Please let me know if you
> strongly dislikes it.

Yes, I strongly dislike it.  I understand the concern, but at this
early stage with converting to device tree I think consistency between
platforms is more important.  We can talk about the issue at Linaro
Connect in 2 weeks, but in the mean time please use the
enabled-by-default/explicitly-disabled pattern.

g.
