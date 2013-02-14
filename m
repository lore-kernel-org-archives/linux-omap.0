From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [GIT PULL] mfd: OMAP USB Host cleanup for 3.9
Date: Thu, 14 Feb 2013 13:26:20 +0100
Message-ID: <20130214122620.GF20996@sortiz-mobl>
References: <511CD215.8080005@ti.com>
 <511CD26F.4080909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <511CD26F.4080909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger

On Thu, Feb 14, 2013 at 02:02:55PM +0200, Roger Quadros wrote:
> Hi Samuel,
> 
> This contains the MFD portion of the OMAP USB Host cleanup series for 3.9.
> It is based on 3.8-rc6 + usbhost17-common that I've sent earlier.
> 
> The first patch touches drivers/usb/ehci-omap.c and is pending ACK from Greg KH.
> The reason it needs to go through MFD tree is that it depends on the platform
> header changes as the MFD drivers.
> 
> Please pull. Thanks.
> 
> The following changes since commit 7f07863ec60f7d3dbeec5aff881ea074db3925ed:
> 
>   ARM: OMAP: Consolidate OMAP USB-HS platform data (part 1/3) (2013-02-13 13:22:34 +0200)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost17-for-mfd
Pulled as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
