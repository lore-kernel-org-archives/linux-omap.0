From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Question about USB mass storage on omap2420
Date: Thu, 25 May 2006 17:26:40 +0900
Message-ID: <003e01c67fd4$f2d7efb0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi

I'm working with USB on omap2420

The current usb source code can't support omap2420 but it's not difficult
to port from TI web 2.6.9 kernel Now USB gadget is working and the windows
recognizes the removable disk, and File-backed Storage Gadget.
But I can't see real disk drive.

I wonder the current USB gadget code can't support removable disk since the
OSK has same problem.
Does anyone who has similar problem?

and is it the right clocks in omap2420?

@@ -2780,6 +2831,15 @@ static int __init omap_udc_probe(struct
                udelay(100);
        }

+       if (cpu_is_omap24xx()) {
+               dc_clk = clk_get(&pdev->dev, "usb_fck");
+               hhc_clk = clk_get(&pdev->dev, "usb_l4_ick");
+               BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
+               clk_enable(dc_clk);
+               clk_enable(hhc_clk);
+               udelay(100);
+       }
+
        INFO("OMAP UDC rev %d.%d%s\n",
                UDC_REV_REG >> 4, UDC_REV_REG & 0xf,
                config->otg ? ", Mini-AB" : "");

Regards,
Kyungmin Park
