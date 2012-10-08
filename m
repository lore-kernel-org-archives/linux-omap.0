From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] musb : remove generic_interrupt and have all
 drivers define the isr on their own. Remove some unneeded
 CONFIG_SOC_OMAP_3430 instances
Date: Mon, 8 Oct 2012 09:34:51 -0700
Message-ID: <20121008163451.GF3874@atomide.com>
References: <1349369952-7036-1-git-send-email-philippe.deswert@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349369952-7036-1-git-send-email-philippe.deswert@jollamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe De Swert <philippedeswert@gmail.com>
Cc: Philippe De Swert <philippe.deswert@jollamobile.com>, Praveena Nadahally <praveen.nadahally@stericsson.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Philippe De Swert <philippedeswert@gmail.com> [121004 10:00]:
> This patch is based on the discussion of a previous patch to fix an issue
> where the omap2430 musb driver is not working for N9/N950.
> 
> Moving all the interrupt handling to the devices. Avoids inclusion of generic
> interrupt and breakage due to sometimes misleading CONFIG options. This makes 
> sure usb always works if on of the subdrivers is chosen. Tested on Nokia N9/N950. 
> 
> Partially clean up CONFIG_SOC_OMAP3430 which is not necessary in the cases
> where I removed it. Also helps with the removal work of those options that 
> Tony Lindgren predicted would happen at some point.

Thanks looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
