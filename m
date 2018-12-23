From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/18] mfd: tps65910: Make it explicitly non-modular
Date: Sun, 23 Dec 2018 08:35:28 -0800
Message-ID: <20181223163528.GP6707@atomide.com>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-12-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545078688-21217-12-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Graeme Gregory <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Gortmaker <paul.gortmaker@windriver.com> [181217 20:36]:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_TPS65910
> drivers/mfd/Kconfig-    bool "TI TPS65910 Power Management chip"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.

Acked-by: Tony Lindgren <tony@atomide.com>
