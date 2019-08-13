From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: dts: am335x: Fix UARTs length
Date: Tue, 13 Aug 2019 03:20:50 -0700
Message-ID: <20190813102050.GH52127@atomide.com>
References: <20190724122329.21231-1-manu@freebsd.org>
 <20190724122329.21231-2-manu@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724122329.21231-2-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Emmanuel Vadot <manu@freebsd.org>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Emmanuel Vadot <manu@freebsd.org> [190724 05:24]:
> As seen on the AM335x TRM all the UARTs controller only are 0x1000 in size.
> Fix this in the DTS.

Thanks applying into fixes.

FYI, the module size is usually (but not always) 0x1000 with additional
0x1000 for the interconnect related registers.

Regards,

Tony
