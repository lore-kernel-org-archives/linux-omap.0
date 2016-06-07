From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] clk: ti: fapll: fix address space warnings
Date: Tue, 7 Jun 2016 17:13:26 +0100
Message-ID: <20160607161326.GZ5783@n2100.arm.linux.org.uk>
References: <1465308337-18047-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1465308337-18047-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 07, 2016 at 03:05:37PM +0100, Ben Dooks wrote:
> Fix the following warnings from casting "void __iomem *" pointers
> to u32 when using sparse:
> 
> drivers/clk/ti/fapll.c:583:13: warning: cast removes address space of expression
> drivers/clk/ti/fapll.c:623:21: warning: cast removes address space of expression

As a note of general principle, adding __force to casts is not the correct
way to solve these sparse warnings.

__force is supposed to be used in places which know that the cast is 100%
legitimate - in other words, architecture code removing the __iomem-ness
of the pointer so it can be dereferenced.  Sprinking the code with __force
to shut these warnings up doesn't actually help the cause.

> diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
> index 66a0d0e..d765f4a 100644
> --- a/drivers/clk/ti/fapll.c
> +++ b/drivers/clk/ti/fapll.c
> @@ -43,14 +43,14 @@
>  #define to_synth(_hw)		container_of(_hw, struct fapll_synth, hw)
>  
>  /* The bypass bit is inverted on the ddr_pll.. */
> -#define fapll_is_ddr_pll(va)	(((u32)(va) & 0xffff) == 0x0440)
> +#define fapll_is_ddr_pll(va)	(((u32 __force)(va) & 0xffff) == 0x0440)

This should be a cast to unsigned long, not u32.

>  
>  /*
>   * The audio_pll_clk1 input is hard wired to the 27MHz bypass clock,
>   * and the audio_pll_clk1 synthesizer is hardwared to 32KiHz output.
>   */
> -#define is_ddr_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x044c)
> -#define is_audio_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x04a8)
> +#define is_ddr_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x044c)
> +#define is_audio_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x04a8)

Ditto.

A cast from an __iomem pointer to unsigned long is permitted - no need
to use __force.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
