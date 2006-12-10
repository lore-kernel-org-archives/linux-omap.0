From: David Brownell <david-b@pacbell.net>
Subject: Re: i2c for omap5912,help me
Date: Sat, 9 Dec 2006 23:16:21 -0800
Message-ID: <200612092316.22449.david-b@pacbell.net>
References: <20061130231453.48C468062D@linux.omap.com>
	<004401c71a95$3faead50$420aa8c0@yfliwei>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <004401c71a95$3faead50$420aa8c0@yfliwei>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: =?utf-8?q?=E6=9D=8E=E7=8E=AE?= <coffeeyu531@126.com>
List-Id: linux-omap@vger.kernel.org

>  I'm using an omap5912 and would like to light the led D3 
> on the board thru the i2c driver.

In the kernel, <asm/arch/tps65010.h> exports

extern int tps65010_set_led(unsigned led, unsigned mode);
extern int tps65010_set_gpio_out_value(unsigned gpio, unsigned value);

which are used for those LEDs.  D3 is connected to TPS65010 GPIO 2...
