From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/2] i2c-omap: Fix i2c_xfer for 1 msg
Date: Tue, 24 Jan 2006 13:46:54 +0100
Message-ID: <20060124124654.GA21123@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

omap_i2c_xfer is supposed to return number of messages successfuly
transfered. Remove bogus condition which causes it to fail when
transfering one message.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fb41255..b021073 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -403,7 +403,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, 
 			break;
 	}
 
-	if (r == 0 && num > 1)
+	if (r == 0)
 		r = num;
 out:
 	omap_i2c_disable_clocks(dev);
