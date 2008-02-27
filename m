From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Problem in twl4030_gpio.c
Date: Tue, 26 Feb 2008 19:00:20 -0800
Message-ID: <a46a26fd0802261900p3fc490ax4cc936ecc8993d11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

twl4030 gpio driver has a problem which causes the pull up/down registers to
be reset with every call to twl4030_request_gpio().

Below is a patch that fixes this.

--- twl4030_gpio.c.org  2008-02-26 18:52:57.000000000 -0800
+++ twl4030_gpio.c      2008-02-26 18:53:35.000000000 -0800
@@ -332,13 +332,13 @@
                        gpio_twl4030_write(REG_GPIO_CTRL,
                                        MASK_GPIO_CTRL_GPIO_ON);
                        ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
+                        ret =
+                            twl4030_i2c_write(TWL4030_MODULE_GPIO,
clear_pull,
+                                              REG_GPIOPUPDCTR1, 5);
                }
                if (!ret)
                        gpio_usage_count |= (0x1 << gpio);

-               ret =
-               twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
-                               REG_GPIOPUPDCTR1, 5);
        }
        up(&gpio_sem);
        return ret;

 - Juha

-- 
Madness takes it's toll. Please have exact change.
