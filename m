From: David Brownell <david-b@pacbell.net>
Subject: Re: 2430 GPIO programming example ?
Date: Sun, 12 Aug 2007 07:48:41 -0700
Message-ID: <20070812144841.DB720219CE7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, budheej@gmail.com
List-Id: linux-omap@vger.kernel.org

Avoid the OMAP-specific GPIO calls.  Instead use the calls described in

  Documentation/gpio.txt

which are used in a variety of places, such as

  drivers/leds/leds-gpio.c
  drivers/input/keyboard/gpio-keys.c
  drivers/i2c/busses/i2c-gpio.c

The ads7846.c code is a bad example; board-specific init like that should
should be moved into the board init code.

- Dave
