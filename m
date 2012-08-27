From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: AM33XX: clock: Add dcan clock aliases for device-tree
Date: Mon, 27 Aug 2012 15:34:02 +0530
Message-ID: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Currently, the device names for the dcan module follows the
format "dcan.X", where 'X' is the dcan instance number.
On other side, driver may request for clock with/without con_id
and dev_id, and it is expected that platform should respect this
request and return the requested clock handle.

Now, when using device tree, the format of the device name created
by OF layer is different, "<reg-address>.<device-name>",
assuming that the device-tree "reg" property is specified.
This causes the look-up failure for clock node in dcan driver

To fix this add new dcan clock alias for using device-tree.

Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/clock33xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index ae27de8..a4006b2 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1027,7 +1027,9 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"cefuse_fck",		&cefuse_fck,	CK_AM33XX),
 	CLK(NULL,	"clkdiv32k_ick",	&clkdiv32k_ick,	CK_AM33XX),
 	CLK(NULL,	"dcan0_fck",		&dcan0_fck,	CK_AM33XX),
+	CLK("481cc000.d_can",	NULL,		&dcan0_fck,	CK_AM33XX),
 	CLK(NULL,	"dcan1_fck",		&dcan1_fck,	CK_AM33XX),
+	CLK("481d0000.d_can",	NULL,		&dcan1_fck,	CK_AM33XX),
 	CLK(NULL,	"debugss_ick",		&debugss_ick,	CK_AM33XX),
 	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
 	CLK("davinci-mcasp.0",  NULL,           &mcasp0_fck,    CK_AM33XX),
-- 
1.7.0.4
