From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 00/10] soc: ti: add OMAP PRM driver (for reset)
Date: Fri, 30 Aug 2019 15:18:06 +0300
Message-ID: <20190830121816.30034-1-t-kristo@ti.com>
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
To: ssantosh@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

V3 of the series, ended up re-sending the whole series as I squashed one
patch from v2 and because of that the ordering has changed a bit. Changes
in v3 contain fixes for the comments from Philipp Zabel.

- added spinlock to protect register writes
- added own xlate function to prevent bad reset IDs to be registered
- use mask for the valid reset detection instead of parsing reset map
- fixed reset status bit handling
- used iopoll macro instead of handwritten poll loop for timeouts
- squashed patch #6 into #4 from v2 of the series
- some other minor fixes.

This series still depends on the clk driver changes for the reset<->clk
syncing [1].

-Tero

[1] https://marc.info/?l=linux-clk&m=156697558331203&w=2


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
