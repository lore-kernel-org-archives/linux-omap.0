From: Rob Herring <robh@kernel.org>
Subject: Re: [Patch v4 1/3] clk: ti: dra7: add vpe clkctrl data
Date: Mon, 18 Nov 2019 11:37:18 -0600
Message-ID: <20191118173718.GA2603@bogus>
References: <20191112142657.22898-1-bparrot@ti.com>
 <20191112142657.22898-2-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191112142657.22898-2-bparrot@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Benoit Parrot <bparrot@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 12 Nov 2019 08:26:55 -0600, Benoit Parrot wrote:
> Add clkctrl data for VPE.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         |  6 ++++++
>  include/dt-bindings/clock/dra7.h | 10 ++++++++++
>  2 files changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
