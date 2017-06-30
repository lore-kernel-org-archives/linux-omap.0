From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mfd: twl-core: Improve the documentation
Date: Fri, 30 Jun 2017 11:02:21 +0300
Message-ID: <20170630080220.ctwetsy2jfrxyn4s@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Saying it "returns the result" seems tautological.  The read function
does not return num_bytes on success, it returns zero on success.  I
noticed this discrepancy because some of the callers were checking for
>= 0.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c64615dca2bd..07d168f8cc81 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -448,7 +448,7 @@ static struct regmap *twl_get_regmap(u8 mod_no)
  * @reg: register address (just offset will do)
  * @num_bytes: number of bytes to transfer
  *
- * Returns the result of operation - 0 is success
+ * Returns 0 on success or else a negative error code.
  */
 int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
@@ -476,7 +476,7 @@ EXPORT_SYMBOL(twl_i2c_write);
  * @reg: register address (just offset will do)
  * @num_bytes: number of bytes to transfer
  *
- * Returns result of operation - num_bytes is success else failure.
+ * Returns 0 on success or else a negative error code.
  */
 int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
