From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: twl6040: fix child-node lookup
Date: Wed, 29 Nov 2017 11:25:14 +0000
Message-ID: <20171129112514.lhg4qir2qsytg3dr@dell>
References: <20171111153844.16741-1-johan@kernel.org>
 <20171111153844.16741-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171111153844.16741-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 11 Nov 2017, Johan Hovold wrote:

> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
> 
> To make things worse, the parent node was prematurely freed, while the
> child node was leaked.
> 
> Note that the CONFIG_OF compile guard can be removed as
> of_get_child_by_name() provides a !CONFIG_OF implementation which always
> fails.
> 
> Fixes: 37e13cecaa14 ("mfd: Add support for Device Tree to twl6040")
> Fixes: ca2cad6ae38e ("mfd: Fix twl6040 build failure")
> Cc: stable <stable@vger.kernel.org>     # 3.5
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl6040.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
