From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/10] arm: omap2: fix omap3 touchbook kconfig warning
Date: Thu, 22 Dec 2011 10:22:56 -0800
Message-ID: <20111222182256.GO24444@atomide.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1324341747-5922-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (MACH_OMAP3_TOUCHBOOK && DRM_RADEON_KMS && DRM_I915 && STUB_POULSBO && FB_BACKLIGHT && USB_APPLEDISPLAY && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI && EEEPC_LAPTOP && ACPI_ASUS && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)
> 
> A lot of boards need BACKLIGHT_CLASS_DEVICE for the framebuffers to
> work, but it's not *needed* for the device itself. It might be nice to
> enable it by default somewhoe if graphics stuff is enabled, but that's
> another story.

Thanks applying into fixes-non-critical-part3.

Tony
