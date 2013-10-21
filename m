From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V2 0/2] ARM: dts: OMAP2+: add i2c aliases
Date: Mon, 21 Oct 2013 14:48:00 +0530
Message-ID: <5264F148.7030705@ti.com>
References: <525E8D91.5090400@ti.com>
 <1381954864-24410-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381954864-24410-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 17 October 2013 01:51 AM, Nishanth Menon wrote:
> Add i2c aliases for OMAP and AM processor dts nodes to ensure proper
> i2c ordering. Based on Benoit's for_13/dts branch[1]
> 
> Changes in V2:
> 	- Following Rajendra's suggestion, done for all OMAP and AM
> 	  series SoCs, where i2c is defined.

Thanks Nishanth.
Acked-by: Rajendra Nayak <rnayak@ti.com>

> 
> V1: https://patchwork.kernel.org/patch/3046671/
> 
> Nishanth Menon (2):
>   ARM: dts: OMAP3+: Add i2c aliases
>   ARM: dts: AM33xx+: Add i2c aliases
> 
>  arch/arm/boot/dts/am33xx.dtsi |    3 +++
>  arch/arm/boot/dts/am4372.dtsi |    3 +++
>  arch/arm/boot/dts/dra7.dtsi   |    5 +++++
>  arch/arm/boot/dts/omap3.dtsi  |    3 +++
>  arch/arm/boot/dts/omap4.dtsi  |    4 ++++
>  arch/arm/boot/dts/omap5.dtsi  |    5 +++++
>  6 files changed, 23 insertions(+)
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
> 
