From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv2 0/2] mfd: omap-usb-tll: Fixes for USB TLL mode
Date: Mon, 24 Apr 2017 12:43:36 +0100
Message-ID: <20170424114336.snjiat3fph27hxe7@dell>
References: <20170415170509.17364-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170415170509.17364-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 15 Apr 2017, Tony Lindgren wrote:

> Hi
> 
> Here's v2 of this that move the enabling of ULPIAUTOIDLE bit into a
> separate patch as suggested by Roger Quadros <rogerq@ti.com>.
> 
> Both patches can wait for v4.12.
> 
> Regards,
> 
> Tony
> 
> 
> Tony Lindgren (2):
>   mfd: omap-usb-tll: Fix inverted bit use for USB TLL mode
>   mfd: omap-usb-tll: Configure ULPIAUTOIDLE
> 
>  drivers/mfd/omap-usb-tll.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

FYI: I don't know where you're getting Sam's email from, but I assume
that after being MFD-free for several years now, I'm assuming he's
lost interest in the subsystem.  Might be about time to stop CC'ing
him. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
