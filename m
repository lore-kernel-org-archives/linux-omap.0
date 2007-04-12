From: Raja Mallik <raja.mallik@sqlstar.com>
Subject: Testing SPI on omap5912
Date: Thu, 12 Apr 2007 19:53:26 +0530 (IST)
Message-ID: <10049.122.169.143.113.1176387806.squirrel@mail.sqlstar.com>
References: <20070409204433.GA23320@mail.solidboot.com>
	<20070412133710.GA9104@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070412133710.GA9104@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

hI,

I am trying to test SPI driver on omap5912. I have found I can't use
Sd/MMC as SPI slave device for it's host controller in-built on the
development board. I have found several ways to test SPI driver on my
development board.

Internal SPI slave device possibility:

   AIC23 codec uses I2C. We can use the SPI bus. Length work to write the
   SPI protocol driver. -- need reference to proceed..

   Another possibility of using the TOUCHSCREEN driver which uses MCBSP
   interface to use enabled SPI mode. --need reference

External SPI slave device:

   any flash device -- any reference...

I am actualy looking out to test any SPI application using linux-2.6.20
git kernel port to my development board that has omap5912 core.

-Raja
