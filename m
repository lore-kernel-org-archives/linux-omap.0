From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/7] ARM: OMAP2+: clkctrl fixes/enhancements for omaps
Date: Fri, 3 Nov 2017 16:26:34 +0200
Message-ID: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
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
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds some fixes/enhancements for the clkctrl support on
omap family SoCs. Required to properly support clkctrl clocks on
am3,am4,am5,omap4,omap5,dra7. Targeted for 4.16 seeing we are pretty
late on 4.14-rc cycle.

This series can be merged independently from the other serieses
(driver part support code, DTS data.) Boot tested against 4.14-rc1
on the boards I have access to.

Series has been pushed here:
Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.14-rc1-clkctrl-mach-omap2

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
