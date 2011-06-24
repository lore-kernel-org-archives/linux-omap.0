From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl: Add 'fixed' set_voltage callback
Date: Fri, 24 Jun 2011 12:19:29 +0100
Message-ID: <20110624111929.GC9483@opensource.wolfsonmicro.com>
References: <1308862014-11212-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308862014-11212-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, ti@lists.linaro.org, linux-omap@vger.kernel.org, lrg@ti.com, sameo@linux.intel.com, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 02:16:54AM +0530, Jassi Brar wrote:
> Define dummy set_voltage callback for fixed lines,
> without which voltage constraints fail to apply.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

No, this isn't sensible - fixed voltage regulators aren't an unusual
property of this device, they've very common.  The core should handle
this gracefully.  Probably whatever consumer is doing the setting also
ought to be updated to check that the voltages it wants to set are
supported at startup since otherwise it can end up repeatedly trying to
set something that'll never work.
