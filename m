From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] mfd: twl-core: Make it explicitly non-modular
Date: Mon, 12 Sep 2016 20:26:26 -0700
Message-ID: <20160913032625.v54s7e5m2eyo3k4z@atomide.com>
References: <20160912144054.27522-1-paul.gortmaker@windriver.com>
 <20160912144054.27522-7-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160912144054.27522-7-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Gortmaker <paul.gortmaker@windriver.com> [160912 07:41]:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config TWL4030_CORE
> drivers/mfd/Kconfig:    bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove what modular code that we can, so that when reading the
> driver there is less doubt that it is builtin-only.  Note that we can't
> remove the twl_remove() itself ; it is still used by the probe unwind
> routine.  So we leave it linked into the .remove as well, even though
> it will most likely never be called via that path from an unbind.
> 
> Since module_i2c_driver() uses the same init level priority as
> builtin_i2c_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Yeah makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>
