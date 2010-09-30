From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: tidspbridge: disable all peripherals at
	bridge_brd_stop
Date: Thu, 30 Sep 2010 04:36:34 -0700
Message-ID: <20100930113634.GA29480@kroah.com>
References: <1285362123-31323-1-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:52098 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab0I3RRD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 13:17:03 -0400
Content-Disposition: inline
In-Reply-To: <1285362123-31323-1-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ernesto Ramos <ernesto@ti.com>
Cc: gregkh@suse.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@gmail.com, andy.shevchenko@gmail.com, Omar Ramirez Luna <omar.ramirez@ti.com>

On Fri, Sep 24, 2010 at 04:02:03PM -0500, Ernesto Ramos wrote:
> DSP Bridge needs to disable the peripheral clocks when switches to
> BRD_STOPPED since that would prevent the domain to enter in OFF state.
> 
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

This patch doesn't apply to the latest linux-next tree, what did you
make it against?

Care to fix it up and resend it?

thanks,

greg k-h
