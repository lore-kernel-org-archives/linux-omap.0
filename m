From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am57xx-beagle-x15: use palmas-usb for
 USB2
Date: Wed, 5 Aug 2015 03:37:29 -0700
Message-ID: <20150805103728.GC16878@atomide.com>
References: <1438002617-15152-1-git-send-email-rogerq@ti.com>
 <1438002617-15152-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438002617-15152-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150727 06:13]:
> The VBUS line of USB2 is connected to VBUS detect logic on
> the PMIC. Use the palmas-usb driver to report VBUS events
> to the USB driver.
> 
> As the palmas-usb driver supports GPIO based ID reporting
> provide the GPIO for ID pin as well.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

This should not cause merge conflicts with what I have queeud
for v4.3, so Chanwoo please feel free to apply with the rest
of the extcon series:

Acked-by: Tony Lindgren <tony@atomide.com>
