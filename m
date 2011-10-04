From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 18/30] omap-usb: automatically select MFD_OMAP_USB_HOST
Date: Tue, 4 Oct 2011 13:00:26 +0200
Message-ID: <20111004110026.GZ4118@sortiz-mobl>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-19-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317566760-25681-19-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Sun, Oct 02, 2011 at 04:45:48PM +0200, Arnd Bergmann wrote:
> The ehci-omap and ohci-omap3 drivers both depend on the
> omap-usb-host MFD support driver. By default, this is
> automatically turned on, but it is possible to disable
> the driver, which results in a link error.
I don't see the Kconfig entry for e.g. the ohci-omap3 driver, but shouldn't
the dependency be handled there ?
If ohci-omap3 depends on omap-usb-host, then we should not be able to disable
the latter while the former is selected.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
