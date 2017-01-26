From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: dts: dra7x-evm: Enable dual-role mode for USB1
Date: Thu, 26 Jan 2017 07:56:24 -0800
Message-ID: <20170126155622.GP7403@atomide.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
 <1485170381-32110-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485170381-32110-7-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@kernel.org, peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170123 03:21]:
> USB1 port is micro-AB type and can function as peripheral
> as well as host. Enable dual-role mode for USB1.

Good to see this happening :) Can you please send the dts changes
separately after the driver changes have gotten merged?

Meanwhile I'll untag this thread here.

Thanks,

Tony
