From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: clock: ti: add latching support to mux
 and divider clocks
Date: Mon, 19 Feb 2018 08:36:20 -0600
Message-ID: <20180219143620.vu3ucann7vmgsdlt@rob-hp-laptop>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
 <1518698991-10099-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1518698991-10099-2-git-send-email-t-kristo@ti.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 15, 2018 at 02:49:47PM +0200, Tero Kristo wrote:
> Certain hardware configurations, like dra76x, have some of the clock
> registers partitioned in a funky manner that requires the clock
> control setup to be latched for PRCM to be notified of the change. This
> is accomplished with a separate control bit under the register. Add
> support for this clock latching support to divider and mux clocks.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/ti/divider.txt | 3 +++
>  Documentation/devicetree/bindings/clock/ti/mux.txt     | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
