From: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: RE: [PATCH] mfd: twl-core: convert to module_init()
Date: Sat, 1 Jun 2013 07:59:03 +0000
Message-ID: <902E09E6452B0E43903E4F2D568737AB31F402@DNCE04.ent.ti.com>
References: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

It's done alreday here:
https://patchwork.kernel.org/patch/2477541/ - mfd: twl-core: convert to module_i2c_driver()
 (Samuel has taken this one)
- and -
https://patchwork.kernel.org/patch/2477561/ - i2c: omap: convert to module_platform_driver()
 (you can vote here - TWL can't be shifted without I2C)

(Sent from Web Outlook - sorry if format is wrong)
Best regards,
- Grygorii Strashko 

________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] on behalf of Kevin Hilman [khilman@linaro.org]
Sent: Friday, May 31, 2013 11:56 PM
To: Samuel Ortiz; Tony Lindgren
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; open list
Subject: [PATCH] mfd: twl-core: convert to module_init()

There's no reason for twl-core to be subsys_inicall anymore.  Anything
using twl that early needs a rethink, or deferred probe changes.

Boot tested and RTC wake tested (via TWL RTC) on OMAP platforms:
3530/Beagle, 3730/Beagle-xM, 3530/Overo, 3730/Overo-STORM, 4430/Panda,
4460/Panda-ES.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 89ab4d9..7749b9e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1309,7 +1309,7 @@ static int __init twl_init(void)
 {
        return i2c_add_driver(&twl_driver);
 }
-subsys_initcall(twl_init);
+module_init(twl_init);

 static void __exit twl_exit(void)
 {
--
1.8.2

