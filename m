From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap5/dra7xx: Enable booting secondary CPU in HYP
 mode
Date: Mon, 5 Jan 2015 14:33:47 -0800
Message-ID: <20150105223347.GL4081@atomide.com>
References: <20141219214924.GA17160@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141219214924.GA17160@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Lennart Sorensen <lsorense@csclub.uwaterloo.ca> [141219 13:51]:
> If the boot loader enables HYP mode on the boot CPU, the secondary CPU
> also needs to call into the ROM to switch to HYP mode before booting.
> The firmwares on the omap5 and dra7xx unfortunately do not take care
> of this, so it has to be handled by the kernel.
> 
> This patch is based on "[PATCH 2/2] ARM: OMAP5: Add HYP mode entry support
> for secondary CPUs" by Santosh Shilimkar <santosh.shilimkar@ti.com>,
> except this version does not require a compile time CONFIG to control
> if it should enable HYP mode or not, it simply does it based on the mode
> of the boot CPU, so it works whether the CPU boots in SVC or HYP mode,
> and should even work as a guest kernel inside kvm if qemu decides to
> support emulating the omap5 or dra7xx.

Applying into omap-for-v3.19/fixes with cc stable for v3.16+.

Thanks,

Tony
