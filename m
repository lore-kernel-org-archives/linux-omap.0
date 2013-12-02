From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems on OMAP4 Panda
Date: Mon, 2 Dec 2013 16:28:09 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7455@saturn3.aculab.com>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com> <1385730118-26402-2-git-send-email-rogerq@ti.com> <AE90C24D6B3A694183C094C60CF0A2F6026B744D@saturn3.aculab.com> <529C4726.6080708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <529C4726.6080708@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com
Cc: tomi.valkeinen@ti.com, balbi@ti.com, sr@denx.de, ljkenny.mailinglists@gmail.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> From: Roger Quadros [mailto:rogerq@ti.com]
> On 11/29/2013 03:17 PM, David Laight wrote:
...
> >> +	timeout = jiffies + msecs_to_jiffies(100);
> >> +	while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS)
> >> +			& OMAP_UHH_SYSSTATUS_RESETDONE)) {
> >> +		cpu_relax();
> 
> You mean use msleep(1) here instead of cpu_relax()?
> Shouldn't be a problem IMO, but can you please tell me why that is better
> as the reset seems to complete usually in the first iteration.

If it doesn't finish in the first iteration you don't want to
spin the cpu for 100ms.

If it hasn't finished in the first millisecond, you probably expect
it to actually time out - so you might as well look (say) every 10ms.

	David
