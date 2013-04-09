From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/6] mfd: omap-usb-host: Device tree support for 3.10
Date: Tue, 9 Apr 2013 09:54:57 +0200
Message-ID: <20130409075457.GF24058@zurbaran>
References: <1363083940-20050-1-git-send-email-rogerq@ti.com>
 <515029FC.3030405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <515029FC.3030405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, b-cousson@ti.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Mon, Mar 25, 2013 at 12:42:04PM +0200, Roger Quadros wrote:
> Hi Samuel,
> 
> I've rebased this now on top of 3.9-rc4. Please pull this into your
> next branch when appropriate. Thanks.
> 
> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
> 
>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost-mfd-next
> 
> Roger Quadros (5):
>       mfd: omap-usb-host: update nports in platform_data
>       mfd: omap-usb-host: Remove PHY reset handling code
>       mfd: omap-usb-tll: move configuration code to omap_tll_init()
>       mfd: omap-usb-tll: Add device tree support and binding information
>       mfd: omap-usb-host: Add device tree support and binding information
I had to apply them manually, as patches #2 and #5 do not apply.
I am pushing #1, #3 and #4, please rebase 2 and 5 on top of mfd-next and
resend them to me.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
