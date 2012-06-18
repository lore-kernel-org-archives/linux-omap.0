From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on
 OMAP4
Date: Mon, 18 Jun 2012 09:57:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206180957250.9031@utopia.booyaka.com>
References: <4FDEF7FE.9040202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FDEF7FE.9040202@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "Lopez Cruz,
 Misael" <misael.lopez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 18 Jun 2012, Cousson, Benoit wrote:

> The commit 503d0ea24d1d3dd3db95e5e0edd693da7a2a23eb
>   ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
> 
> added a wrong "prcm_clk" alias for PRCM clock whereas the McBSP
> driver and previous OMAPs are using "prcm_fck".
> 
> It thus lead to the following warning.
> 
> [   47.409729] omap-mcbsp: clks: could not clk_get() prcm_fck
> 
> Fix that by changing the opt_clk role to prcm_fck.
> 
> Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Sebastien Guiriec <s-guiriec@ti.com>

Thanks, will queue this as part of the next 3.5-rc series.

- Paul
