From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/10] ARM: dts: omap changes for IOMMU / reset support
Date: Wed, 28 Aug 2019 10:56:34 +0300
Message-ID: <20190828075644.4493-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds reset nodes for OMAP4+ family of SoCs, and fixes the
IOMMUs to support these also.

This series depends on the earlier posted clock series [1], PRM support
series [2], and the pdata quirks [3] and [4].

-Tero

[1] https://marc.info/?l=linux-clk&m=156697558331203&w=2
[2] https://marc.info/?l=linux-omap&m=156697680731569&w=2
[3] https://marc.info/?l=linux-omap&m=156517109506492&w=2
[4] https://marc.info/?l=linux-omap&m=156697839332083



--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
