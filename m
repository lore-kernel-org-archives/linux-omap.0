From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Wed, 19 Sep 2012 13:27:22 +0200
Message-ID: <20120919112722.GG8138@sortiz-mobl>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342445471-18704-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Keshava,

On Mon, Jul 16, 2012 at 07:01:06PM +0530, Keshava Munegowda wrote:
> The TLL (Transceiver Less Link) is an separate IP block, independent of
> the host controller. Basically this TLL operates like USB PHY which allows
> the user to connect two USB transceiver interfaces together directly
> without the use of differential transceivers in omap3 and later chips.
> The TLL configuration is removed from the UHH driver and implemented as
> a seperate platform driver. Now, the UHH driver configures the TLL
> through API's exported by the TLL platform driver.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> 
> In v4:
>     - rebased on top of linux kernel version 3.5.rc7
>     - reworked as per the comments given by Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> 
> In v3:
>   - rebased on top V3 of Russ dill's patch
>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
>        fixes an issue where the ULPI PHYs were not held in reset
>        while initializing the EHCI controller
> 	http://permalink.gmane.org/gmane.linux.usb.general/65988
>       
>   - rebased on top of patch 
>     OMAP: USB : Fix the EHCI enumeration and core retention issue
>      http://permalink.gmane.org/gmane.linux.usb.general/66239
> 
> In V2:
>     - covered review comments from linux omap and usb community
>     - rebased on top Russ dill's patch
>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
>        fixes an issue where the ULPI PHYs were not held in reset
>        while initializing the EHCI controller
> 
> Keshava Munegowda (5):
>   ARM: OMAP: Add the USB TLL clocks device name
>   ARM: OMAP: USB: HOST TLL platform driver
>   ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
>   ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
>   ARM: OMAP: Remove older device name of the USB TLL clocks
All 5 patches applied now. I had to manually apply patches #1 and #5. Could
you please check that it's looking good to you ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
