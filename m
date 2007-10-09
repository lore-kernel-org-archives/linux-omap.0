From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 3/6] OMAP: Update gpio expander code to the corret i2c
	adapter id
Date: Tue,  9 Oct 2007 08:52:30 -0400
Message-ID: <1191934353-24072-4-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1191934353-24072-3-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

- Update gpio expander code to the corret i2c adapter id
- Due to changes on i2c binding style, the i2c adapter is 1
and not 0. (as configured on i2c_register_board_info)

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/i2c/chips/gpio_expander_omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/gpio_expander_omap.c b/drivers/i2c/chips/gpio_expander_omap.c
index 92e96ba..dfe7f04 100644
--- a/drivers/i2c/chips/gpio_expander_omap.c
+++ b/drivers/i2c/chips/gpio_expander_omap.c
@@ -26,7 +26,7 @@ int write_gpio_expa(u8 val, int addr)
 	struct i2c_msg msg[1];
 	unsigned char data[1];
 
-	adap = i2c_get_adapter(0);
+	adap = i2c_get_adapter(1);
 	if (!adap)
 		return -ENODEV;
 	msg->addr = addr;	/* I2C address of GPIO EXPA */
@@ -51,7 +51,7 @@ int read_gpio_expa(u8 * val, int addr)
 	struct i2c_msg msg[1];
 	unsigned char data[1];
 
-	adap = i2c_get_adapter(0);
+	adap = i2c_get_adapter(1);
 	if (!adap)
 		return -ENODEV;
 	msg->addr = addr;	/* I2C address of GPIO EXPA */
-- 
1.5.3.4.206.g58ba4
