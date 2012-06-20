From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/3] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
Date: Wed, 20 Jun 2012 03:44:40 -0700
Message-ID: <20120620104440.GE12766@atomide.com>
References: <1338388466-3565-1-git-send-email-kishon@ti.com>
 <1338388466-3565-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338388466-3565-4-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [120530 07:38]:
> All the unnessary functions in omap-phy-internal is removed.
> These functionality are now handled by omap-usb2 phy driver.

Glad to see these move to live under drivers. Up to Felipe
to merge via linux-usb once the driver parts are finished:

Acked-by: Tony Lindgren <tony@atomide.com>
