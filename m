From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
Date: Thu, 05 Apr 2018 13:05:54 -0700
Message-ID: <152295875421.91052.344369730121423981@swboyd.mtv.corp.google.com>
References: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
 <0da17b8f-62af-1634-9dea-85445d28d587@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0da17b8f-62af-1634-9dea-85445d28d587@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2018-03-29 11:25:07)
> On 27/03/18 20:47, Tero Kristo wrote:
> > The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
> > clocks used a generic clock flag, which causes a conflict with the
> > rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
> > boot failures on certain platforms where this flag is introduced, by
> > omitting the wait for the clockctrl module to be fully enabled before
> > proceeding with rest of the code.
> > 
> > Fix this by moving all the clkctrl specific flags to their own bit-range.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
> > Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> 
> Stephen, can you pick this up as a late fix?
> 

Sorry I was traveling for a week. I'll pick this up for this merge
window and then stable can get it.
