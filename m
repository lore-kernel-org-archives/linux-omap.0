From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 8/8] musb: set 'extvbus = 0' for Blackfin boards
Date: Tue, 17 Nov 2009 20:39:56 +0530
Message-ID: <1258470596-24321-9-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-6-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
	<1258470596-24321-8-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1258470596-24321-8-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Default value of 'extvbus' is being set as '0' to maintain the
current programming state of all Blackfin musb boards.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/cm_bf527.c |    6 ++++++
 arch/blackfin/mach-bf527/boards/ezbrd.c    |    6 ++++++
 arch/blackfin/mach-bf527/boards/ezkit.c    |    6 ++++++
 arch/blackfin/mach-bf548/boards/cm_bf548.c |    6 ++++++
 arch/blackfin/mach-bf548/boards/ezkit.c    |    6 ++++++
 5 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c b/arch/blackfin/mach-bf527/boards/cm_bf527.c
index f1996b1..48e1591 100644
--- a/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ b/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -104,6 +104,11 @@ static struct musb_hdrc_config musb_config = {
 	.gpio_vrsel	= GPIO_PF11,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata = {
+	.extvbus = 0,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #if defined(CONFIG_USB_MUSB_OTG)
 	.mode		= MUSB_OTG,
@@ -113,6 +118,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.config		= &musb_config,
+	.board_data	= &musb_bdata,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c b/arch/blackfin/mach-bf527/boards/ezbrd.c
index cad23b1..bc56ea9 100644
--- a/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -64,6 +64,11 @@ static struct musb_hdrc_config musb_config = {
 	.gpio_vrsel	= GPIO_PG13,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata = {
+	.extvbus = 0,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #if defined(CONFIG_USB_MUSB_OTG)
 	.mode		= MUSB_OTG,
@@ -73,6 +78,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.config		= &musb_config,
+	.board_data	= &musb_bdata,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index f09665f..c99e8f2 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -102,6 +102,11 @@ static struct musb_hdrc_config musb_config = {
 	.gpio_vrsel	= GPIO_PG13,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata = {
+	.extvbus = 0,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #if defined(CONFIG_USB_MUSB_OTG)
 	.mode		= MUSB_OTG,
@@ -111,6 +116,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.config		= &musb_config,
+	.board_data	= &musb_bdata,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c b/arch/blackfin/mach-bf548/boards/cm_bf548.c
index ccdcd6d..f745ab3 100644
--- a/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ b/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -333,6 +333,11 @@ static struct musb_hdrc_config musb_config = {
 	.gpio_vrsel	= GPIO_PH6,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata = {
+	.extvbus = 0,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #if defined(CONFIG_USB_MUSB_OTG)
 	.mode		= MUSB_OTG,
@@ -342,6 +347,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.config		= &musb_config,
+	.board_data	= &musb_bdata,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 1a5286b..00995e8 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -435,6 +435,11 @@ static struct musb_hdrc_config musb_config = {
 	.gpio_vrsel	= GPIO_PE7,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata = {
+	.extvbus = 0,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #if defined(CONFIG_USB_MUSB_OTG)
 	.mode		= MUSB_OTG,
@@ -444,6 +449,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.config		= &musb_config,
+	.board_data	= &musb_bdata,
 };
 
 static u64 musb_dmamask = ~(u32)0;
-- 
1.6.2.4
