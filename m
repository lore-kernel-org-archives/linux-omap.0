From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 8/9] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
Date: Fri, 10 Jun 2016 05:03:32 -0700
Message-ID: <20160610120332.GL22406@atomide.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-9-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462291015-1919-9-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> Devices that utilize the OCP registers and/or PRCM registers and
> register bit fields should be modeled using hwmod. Since eQEP, ePWM and
> eCAP don't fall under this category, remove their hwmod entries.
> 
> Instead these clocks simply use the clock that is passed through by its
> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
> subdevices.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>

And this one I'm applying into omap-for-v4.8/soc.

Tony
