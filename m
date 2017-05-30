From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3b 4/5] ARM: OMAP4: cminst: add support for
 clkdm_xlate_address
Date: Tue, 30 May 2017 11:10:28 -0700
Message-ID: <20170530181028.GA3730@atomide.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1496155669-1677-5-git-send-email-t-kristo@ti.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tero Kristo <t-kristo@ti.com> [170530 07:51]:
> This function gets the physical base address of a clockdomain.
..
> +static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
> +{
> +	u32 addr = (u32)_cm_bases[clkdm->prcm_partition] - OMAP2_L4_IO_OFFSET +
> +		clkdm->cm_inst + clkdm->clkdm_offs;
> +
> +	return addr;
> +}
> +

Hmm this will be flakey as it assumes fixed mappings
for all these which we do not have on all SoCs.

It would be best to pass the domain bases around as
struct resource then just ioremap locally.

It might be enough if we changed _cm_bases[] locally
to be an array of:

struct omap_domain_base {
       struct resource res;
       void __iomem *va;
};

Or do you have better ideas?

Regards,

Tony
