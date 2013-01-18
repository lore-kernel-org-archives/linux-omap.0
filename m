From: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] Add device tree support for NAND flash in am335x-evm
Date: Fri, 18 Jan 2013 12:11:32 +0530
Message-ID: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds device tree support for NAND flash in am335x-evm.
Also ELM node is populated in device tree and been used for BCH error
correction in NAND flash part. Also this patch series ensures RBL ecc
layout maintained in Linux kernel with BCH8 ecc scheme.

This patch series based on [1] and depends on [2] & [3].

1. http://git.kernel.org/?p=linux/kernel/git/bcousson/linux-omap-dt.git;a=tree;h=refs/heads/for_3.9/dts;hb=refs/heads/for_3.9/dts
2. OMAP GPMC DT bindings
   http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=shortlog;h=refs/heads/omap-for-v3.9/gpmc
3. mtd: nand: OMAP: ELM error correction support for BCH ecc
   http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/shortlog/refs/heads/master


Philip Avinash (1):
  ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm

Philip, Avinash (2):
  ARM: dts: AM33XX: Add ELM node
  ARM: dts: AM33XX: Add GPMC node

 arch/arm/boot/dts/am335x-evm.dts |   93 +++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi    |   18 ++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

-- 
1.7.9.5
