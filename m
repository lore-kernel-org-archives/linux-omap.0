From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to postcore
Date: Sun, 11 Dec 2011 21:11:59 +0100
Message-ID: <1323634328-856-2-git-send-email-jkrzyszt__39158.0503587194$1323634476$gmane$org@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

This will allow boards with custom memory mapped GPIO ports to set up
and use those port pins while initializing devices from arch init.

Created against linux-3.2-rc5.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/gpio/gpio-generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 4e24436..a6eaf38 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -528,7 +528,7 @@ static int __init bgpio_platform_init(void)
 {
 	return platform_driver_register(&bgpio_driver);
 }
-module_init(bgpio_platform_init);
+postcore_initcall(bgpio_platform_init);
 
 static void __exit bgpio_platform_exit(void)
 {
-- 
1.7.3.4
