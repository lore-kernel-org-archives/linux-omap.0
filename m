From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [RFC 2/8] ARM: twd: register clock event for 1 core SMP
Date: Mon, 18 Feb 2013 12:00:15 +0530
Message-ID: <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361166003.git.afzal@ti.com>
References: <cover.1361166003.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1361166003.git.afzal-l0cyMroinI0@public.gmane.org>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Syed Mohammed Khasim <khasim-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Register percpu local timer for scheduler tick in the case of one core
SMP configuration. In other cases - secondary cpu's as well as boot
cpu's having more than one core, this is being registered as per
existing boot flow, with a difference that they happens after delay
calibration. Registering the clock for tick in case of one core should
be done before Kernel calibrates delay (this is required to boot,
unless local timer is the only one registered for tick). Registering
twd local timer at init_time (which platforms are doing now) helps
achieve that with the proposed change.

This helps in an almost booting Kernel (minimal) by only relying on
ARM parts for an A9 one core SMP.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/kernel/smp_twd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 616268c..118f4f2 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -335,6 +335,9 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 
 	twd_get_clock(np);
 
+	if (num_possible_cpus() == 1)
+		twd_timer_setup(evt);
+
 	return 0;
 
 out_irq:
-- 
1.7.12
