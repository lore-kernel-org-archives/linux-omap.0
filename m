From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Horray, more CBUS patches
Date: Fri, 5 Nov 2010 09:44:46 -0700
Message-ID: <20101105164445.GL9264@atomide.com>
References: <1287473358-25634-1-git-send-email-balbi@ti.com>
 <20101019103825.e7906b0b.jhnikula@gmail.com>
 <20101019073807.GA12470@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54143 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0KEQpA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20101019073807.GA12470@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [101019 00:29]:
> On Tue, Oct 19, 2010 at 02:38:25AM -0500, Jarkko Nikula wrote:
> >On Tue, 19 Oct 2010 10:29:14 +0300
> >Felipe Balbi <balbi@ti.com> wrote:
> >
> >>I believe now everything is fine. Still, it's only
> >>compile tested with n770_defconfig and omap2plus_defconfig.
> >>
> >>Felipe Balbi (4):
> >>  cbus: remove unneded includes
> >>  cbus: retu: move platform_device to board file
> >>  cbus: tahvo: move platform_device to board file
> >>  cbus: tahvo-usb: move platform_device to board file
> >>
> >omap2plus_defconfig doesn't include CONFIG_CBUS(_x) so you must enable
> >them manually.
> 
> I did that, don't worry

Adding these patches to the cbus branch.

Tony
