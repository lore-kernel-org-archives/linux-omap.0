From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
Date: Tue, 27 Mar 2018 13:55:10 -0700
Message-ID: <20180327205510.GJ5700@atomide.com>
References: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: arnd@arndb.de, sboyd@kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [180327 17:48]:
> The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
> clocks used a generic clock flag, which causes a conflict with the
> rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
> boot failures on certain platforms where this flag is introduced, by
> omitting the wait for the clockctrl module to be fully enabled before
> proceeding with rest of the code.
> 
> Fix this by moving all the clkctrl specific flags to their own bit-range.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>

I boot tested this on am437x-idk and bbb with multi_v7_defconfig, so:

Tested-by: Tony Lindgren <tony@atomide.com>
