From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: twl4030 - converting to new I2C style
Date: Mon, 11 Jun 2007 17:24:56 +0530
Message-ID: <5d5443650706110454r1203365exacb8337c11ab1f09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: David Brownell <david-b@pacbell.net>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

David,

I would like to convert twl4030_core.c (driver for TWL4030 chip
available on OMAP2430/3430 TI EVM) [1] to new I2C style bindings. But
it doesn't look straightforward to me compared to menelaus, because

* this chip can decode upto four slave addresses (0x48, 0x49, 0x4A,
0x4B), which we can consider as four different module chips inside one
twl4030.

Now as per new I2C style, we bind one i2c_driver with one client,
matching it (i2c_match) based on it's name in I2C_BOARD_INFO to the
driver name in order to call probe on that.

Now mapping the same concept here we have four clients which should
have different name which registering with i2c_regsiter_board_info,
like this ?

+static struct i2c_board_info __initdata sdp2430_i2c_board_info[] = {
+       {
+               I2C_BOARD_INFO("twl4030:0", 0x48),
+       },
+       {
+               I2C_BOARD_INFO("twl4030:1", 0x49),
+       },
+       {
+               I2C_BOARD_INFO("twl4030:2", 0x4A),
+       },
+       {
+               I2C_BOARD_INFO("twl4030:3", 0x4B),
+       },
+};
+

OR should we keep the same name as in i2c_driver.driver.name for all
four clients above?

[1]
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;f=drivers/i2c/chips/twl4030_core.c;h=6123ce893ee731d5fcb0ed3467066e79f3c29571;hb=HEAD
-- 
--Trilok Soni
