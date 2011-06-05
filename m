From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and ohci
Date: Sun, 5 Jun 2011 19:19:38 +0200
Message-ID: <201106051919.38637.rjw@sisk.pl>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com> <201106011554.38415.rjw@sisk.pl> <20110601143256.GG2409@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110601143256.GG2409@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 01, 2011, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Jun 01, 2011 at 03:54:38PM +0200, Rafael J. Wysocki wrote:
> > > +static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
> > > +	.suspend	= usbhs_suspend,
> > > +	.resume		= usbhs_resume,
> > > +};
> > 
> > Please add .freeze()/.thaw() and .poweroff()/.restore() callbacks too.
> > They may point to the same routines, but must be present.
> > 
> > You can actually use the SIMPLE_DEV_PM_OPS() convenience macro for this
> > purpose.
> 
> good point. BTW, do we need this #ifdef CONFIG_PM stuff which has been
> popping on most drivers recently ? To me it looks like driver.pm field
> is always available even if PM is disabled, so what's the point ? Saving
> a few bytes ?

Basically, yes (you may want to avoid defining the object this points to if
CONFIG_PM is unset).

Thanks,
Rafael
