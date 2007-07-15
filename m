From: David Brownell <david-b@pacbell.net>
Subject: Re: Common code for TSC 2101 and 2102
Date: Sun, 15 Jul 2007 13:18:51 -0700
Message-ID: <200707151318.51976.david-b@pacbell.net>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
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
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

When I built this:

ERROR: "tsc210x_coords_cb" [drivers/input/touchscreen/tsc210x_ts.ko] undefined!
ERROR: "tsc210x_touch_cb" [drivers/input/touchscreen/tsc210x_ts.ko] undefined!
ERROR: "tsc210x_temp2_cb" [drivers/hwmon/tsc210x_sensors.ko] undefined!
ERROR: "tsc210x_temp1_cb" [drivers/hwmon/tsc210x_sensors.ko] undefined!
ERROR: "tsc210x_ports_cb" [drivers/hwmon/tsc210x_sensors.ko] undefined!

with

CONFIG_TOUCHSCREEN_TSC210X=m
CONFIG_SPI_TSC210X=m
CONFIG_SENSORS_TSC210X=m

Same with SPI_TSC210X=y ... problem went away when everything
was statically linked.
