From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: omap-usb-host: fix clock API usage on
 usbhs_disable()
Date: Wed, 27 Jul 2011 11:53:28 +0200
Message-ID: <20110727095328.GC26275@sortiz-mobl>
References: <1311340170-28773-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1311340170-28773-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, parthab@india.ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Keshava,

On Fri, Jul 22, 2011 at 06:39:30PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> 
> usbhs_disable function was invoking clk_enable() instead of
> clk_disable(), thus only increasing the clock usage counter and
> preventing this particular clock from being ever turned off.
> Because of this, the power domain of omap4 the USB Host subsystem
> would never reach lower power states.This patch calls clk_disable()
> in usbhs_disable function
I applied this patch now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
