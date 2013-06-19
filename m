From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on suspend
Date: Wed, 19 Jun 2013 10:23:55 -0700
Message-ID: <878v26815g.fsf@linaro.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
	<1371650753-11452-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371650753-11452-3-git-send-email-rogerq@ti.com> (Roger
	Quadros's message of "Wed, 19 Jun 2013 17:05:49 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, tony@atomide.com, balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

Roger Quadros <rogerq@ti.com> writes:

> In order to support wake up from suspend use the pinctrl
> framework to put the USB host pins in IDLE state during suspend.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

You should use helpers for this now in the pinctrl core:

    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html

Kevin
