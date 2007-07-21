From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: OMAP2430 GPIO Registers
Date: Sun, 22 Jul 2007 02:07:32 +0530
Message-ID: <7d8fdf6f0707211337w7bb2c0abm470c5cb7188cc00c@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

Refering Linux 2.6.19 kernel "arch/arm/plat-omap/gpio-2430.c" file the function
"omap_set_gpio_dataout( <pin number>, < high | low > )" should set the
pin to high or low value, prior to which the direction should be set.

This register actually write to the GPIO offset register 0x94, while
the dataout register is at offset 0x3C. Are these two registers
similiar ? Is writing to 0x94 similiar to writing to 0x3C?

Warm Regards,
Raghu
