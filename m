From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] OMAP2+: hwmod: Add support to parse clock info
 from DT
Date: Fri, 13 Dec 2013 09:31:10 -0800
Message-ID: <20131213173110.GF28184@atomide.com>
References: <1386848309-14076-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386848309-14076-1-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: nm@ti.com, mark.rutland@arm.com, paul@pwsan.com, mturquette@linaro.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [131212 03:40]:
> v1 of this series was posted a while back [1] but there wasn't much that
> was concluded if the approach used in the series was acceptable or if there
> are better alternatives. So I am just doing a repost of these to see if we
> can conclude this time around.
> 
> Needless to say, patches are based off Teros omap-clocks-to-dt v10 series [2]
> and I also pulled in Tonys fix to handle DT nodes with multiple 'ti,hwmod'
> values [3]. The approach taken in the series *does not* work for cases with
> multiple 'ti,hwmod' values and hence [3] helps me skip those instances
> for now. But based on some of the recent discussions on multiple 'ti-hwmod'
> values [4] it looks like its generally agreed upon that having DT nodes with
> multiple 'ti-hwmod' property is wrong and that those instances need to be
> fixed up anyway.

Yeah we need to have 1-to-1 mapping of device entries in the .dtsi files
to the device entries in the omap_hwmod_*_data.c files. And then we can
just deprecate "ti,hwmods" property and start parsing the standard compatible
flag instead.

Regards,

Tony
 
> [1] http://www.spinics.net/lists/linux-omap/msg95746.html
> [2] http://www.spinics.net/lists/devicetree/msg13455.html
> [3] http://www.spinics.net/lists/arm-kernel/msg288036.html
> [4] http://www.spinics.net/lists/arm-kernel/msg288023.html
> 
> Rajendra Nayak (3):
>   ARM: OMAP2+: Add support to parse 'main_clk' info from DT
>   ARM: OMAP2+: Add support to parse optional clk info from DT
>   ARM: OMAP4: dts: Add main and optional clock data into DT
> 
>  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod.c           |   88 ++++++++++++++++++--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  122 ----------------------------
>  3 files changed, 180 insertions(+), 130 deletions(-)
> 
> -- 
> 1.7.9.5
> 
