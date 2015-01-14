From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2+: Remove unused ti81xx platform init code
Date: Wed, 14 Jan 2015 09:19:09 -0800
Message-ID: <20150114171909.GM2419@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-2-git-send-email-tony@atomide.com>
 <20150114011951.GD18523@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53140 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbbANRWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 12:22:52 -0500
Content-Disposition: inline
In-Reply-To: <20150114011951.GD18523@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Felipe Balbi <balbi@ti.com> [150113 17:23]:
> On Tue, Jan 13, 2015 at 03:13:51PM -0800, Tony Lindgren wrote:
> > The support for 81xx was never working in mainline, and it
> > will be only supported in device tree mode. Let's remove all
> > the remaining 81xx related platform code.
> 
> you should probably also mention here that you're dropping unnecessary
> non-DT AM33xx support since that has never booted on legacy mode.
> 
> Other than that
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks, the 81xx legacy booting support already got removed, these
are just left overs I noticed.

I've updated the description with the following:

The support for 81xx was never working in mainline, and the
broken legacy booting support has been removed. There are
patches coming to make 81xx boot with device tree, and for
that we won't need any of this legacy platform code, so let's
just remove it.

Regards,

Tony 
