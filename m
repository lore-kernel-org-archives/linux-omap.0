From: "Rafael J. Wysocki" <rjw@suse.com>
Subject: Re: [PATCH/RFC 0/6] ARM: runtime PM: consolidate runtime PM implementations
Date: Thu, 7 Apr 2011 07:38:42 +0200
Message-ID: <201104070738.42956.rjw@suse.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1302134569-22825-1-git-send-email-khilman@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Thursday, April 07, 2011, Kevin Hilman wrote:
> This series aims to consolidate OMAP and SH-mobile runtime PM
> implementations around the new device power domains.
> 
> In 2.6.39, device power domains were added (commit
> 7538e3db6e015e890825fbd9f8659952896ddd5b, PM: add support for device
> power domains).  In converting both OMAP and SH-mobile to use device
> power domains, the overlap between implementations was almost 100%.  
> 
> To share the runtime PM implementation based on simple clock gating,
> move it to arch/arm/common and initialize it from OMAP and SH-mobile.
> 
> Also, OMAP was the only user of platform_bus_set_pm_ops().  Now that
> it has been converted to device power domains, remove
> platform_bus_set_pm_ops().

Please, don't do it this way.

First, we'll still need platform_bus_set_pm_ops() on shmobile and the reason
is that we want to override the platform bus type PM ops for _all_ devices on
that platform, which power domains are not really suitable for.

Second, we're going to introduce code for handling real power domains for
shmobile that would conflict with the way you're using power domains for
overriding the default PM ops.

Besides, the way you've used power domains appears to assume that drivers
will not define their own runtime PM callbacks, because if they do, those
callbacks will be called _in_ _addition_ to the power domain callbacks you're
trying to add (from the default platform bus type callbacks).

Thanks,
Rafael
