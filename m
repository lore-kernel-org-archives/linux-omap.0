From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] OMAP2+: PM: initial runtime PM core support
Date: Wed, 8 Sep 2010 11:40:01 -0600
Message-ID: <20100908174001.GM3686@angua.secretlab.ca>
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
 <20100908162143.GD3686@angua.secretlab.ca>
 <87aans5fj9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48265 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab0IHRkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 13:40:04 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so161938pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 10:40:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aans5fj9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Wed, Sep 08, 2010 at 10:08:42AM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Tue, Sep 07, 2010 at 05:54:41PM -0700, Kevin Hilman wrote:
> >> From: Kevin Hilman <khilman@ti.com>
> >> 
> >> Implement the new runtime PM framework as a thin layer on top of the
> >> omap_device API.  OMAP specific runtime PM methods are registered with
> >> the as custom methods on the platform_bus.
> >> 
> >> In order to determine if a device is an omap_device, its parent device
> >> is checked.  All omap_devices have a new 'omap_bus' device as their
> >> parent device, so checking for this parent is used to check for valid
> >> omap_devices.  If a device is an omap_device, then the appropriate
> >> omap_device functions are called for it.  If not, only the generic
> >> runtime PM functions are called.
> >> 
> >> Device driver's ->runtime_idle() hook is called when the runtime PM
> >> usecount reaches zero for that device.  Driver's ->runtime_suspend()
> >> hooks are called just before the device is disabled (via
> >> omap_device_idle()), and device driver ->runtime_resume() hooks are
> >> called just after device has been enabled (via omap_device_enable().)
> >> 
> >> OMAP4 build support from Rajendra Nayak <rnayak@ti.com>.
> >> 
> >> Cc: Rajendra Nayak <rnayak@ti.com>
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >
> > It appears that this one will fail to compile when CONFIG_PM_RUNTIME
> > is unset.  Once you've fixed that you can add my a-b line:
> 
> Thanks for catching this. 
> 
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > I think this should go via Greg's tree to avoid ordering issues.
> 
> Not a strong preference, but I'd rather see this go via OMAP as we are
> building on it in the OMAP tree for this merge window.  The ordering
> issues will only affect OMAP users and I have taken care of that in my
> staging branches that other are using for their runtime PM conversions.

okay.

g.

