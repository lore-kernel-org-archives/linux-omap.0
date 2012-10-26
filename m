From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/3] ARM: OMAP: ocp2scp: create omap device for ocp2scp
Date: Fri, 26 Oct 2012 07:47:11 +0000
Message-ID: <201210260747.11848.arnd@arndb.de>
References: <1349675983-23803-1-git-send-email-kishon@ti.com> <1349675983-23803-4-git-send-email-kishon@ti.com> <20121026065012.GC22206@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121026065012.GC22206@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Kishon Vijay Abraham I <kishon@ti.com>, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, olof@lixom.net, rdunlap@xenotime.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 26 October 2012, Felipe Balbi wrote:
> > +static void omap_init_ocp2scp(void)
> > +{
> > +     struct omap_hwmod       *oh;
> > +     struct platform_device  *pdev;
> > +     int                     bus_id = -1, dev_cnt = 0, i;
> > +     struct omap_ocp2scp_dev *ocp2scp_dev;
> > +     const char              *oh_name, *name;
> > +     struct omap_ocp2scp_platform_data *pdata;
> > +
> > +     oh_name = "ocp2scp_usb_phy";
> > +     name    = "omap-ocp2scp";
> 
> how about adding checks here to return early case we're not running on
> OMAP4 or OMAP5 ??
> 

I suppose even OMAP4-only, since OMAP5 always has DT enabled.

	Arnd
