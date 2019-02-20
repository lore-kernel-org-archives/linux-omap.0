From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Date: Wed, 20 Feb 2019 14:31:32 -0800
Message-ID: <20190220223132.GV15711@atomide.com>
References: <20180922094405.4067-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180922094405.4067-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180922 09:48]:
> When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> the counter will be incremented but the resume callback not called,
> so enumeration and charging will not start properly.
> To avoid that happen, disable irq on suspend and recheck on resume.
> 
> Practically this happens when the device is woken up from suspend by
> plugging in usb.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> * use pm suspend/resume callback instead of delayed_work
>   as suggested by Dmitry

Hmm it just occurred to me that this issue too might be fixed with commit
c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
for suspend"). Andreas, care to check? That is if this is still an
issue.

Regards,

Tony
