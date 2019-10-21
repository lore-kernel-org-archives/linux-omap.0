From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: make omap44xx_sha0_hwmod and
 omap44xx_l3_main_2__des static
Date: Mon, 21 Oct 2019 10:37:27 -0700
Message-ID: <20191021173727.GF5610@atomide.com>
References: <20191009085646.21755-1-ben.dooks@codethink.co.uk>
 <20191009085646.21755-2-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191009085646.21755-2-ben.dooks@codethink.co.uk>
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
Cc: linux-kernel@lists.codethink.co.uk, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ben Dooks <ben.dooks@codethink.co.uk> [191009 01:57]:
> The omap44xx_sha0_hwmod and omap44xx_l3_main_2__des objects are
> not exported so make them static to avoid the following warnings:
> 
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c:793:19: warning: symbol 'omap44xx_sha0_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c:977:26: warning: symbol 'omap44xx_l3_main_2__des' was not declared. Should it be static?

Applying into omap-for-v5.5/soc thanks.

Tony
