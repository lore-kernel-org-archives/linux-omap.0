From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Combine zoom board-files
Date: Fri, 5 Nov 2010 14:43:58 -0700
Message-ID: <20101105214358.GX9264@atomide.com>
References: <1287555912-16058-1-git-send-email-balbi@ti.com>
 <20101104123345.GA1952@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61455 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0KEVoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:44:14 -0400
Content-Disposition: inline
In-Reply-To: <20101104123345.GA1952@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

* Felipe Balbi <balbi@ti.com> [101104 05:24]:
> Hi,
> 
> On Wed, Oct 20, 2010 at 01:25:10AM -0500, Balbi, Felipe wrote:
> >Those boards are so similar that they don't
> >deserve separate board files.
> >
> >Felipe Balbi (2):
> > arm: omap: combine zoom2 and zoom3 board-files
> > arm: omap: zoom: substitute gpio number with symbolic name
> 
> a gentle ping on these two patches. Here are patchwork links:
> 
> [1] https://patchwork.kernel.org/patch/267491/
> [2] https://patchwork.kernel.org/patch/267501/
> 
> they are also rebased on top of today's l-o and compile tested with
> omap2plus_defconfig, attached to this mail.

Looks good to me, but please can you please repost with also
linux-arm-kernel list Cc'd? That way I don't have to repost
before merging.

Regards,

Tony
