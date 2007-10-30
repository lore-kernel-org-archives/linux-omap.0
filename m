From: David Brownell <david-b@pacbell.net>
Subject: [patch 0/2 2.6.24-rc1-git] OMAP and gpiolib
Date: Tue, 30 Oct 2007 08:54:58 -0700
Message-ID: <200710300854.58334.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yesterday I posted some new GPIO infrastructure, "gpiolib", which
lets platforms support multiple plug-in GPIO providers, to LKML.
And includes a pcf857x driver, which several OMAP boards could
be using..

One of my test platforms for this was OMAP.  Following this are
two patches:

 - one updating the plat-omap/gpio.c infrastructure to
   use this code (a quick'n'dirty update), and

 - another updating the board support for the OSK5912.

I've got some H4 stuff somewhere too, exposing the debug board's
FPGA support for the LEDs ... although not the other GPIO signals
which it evidently provides.  I'll try to refresh that.

- Dave
