From: David Brownell <david-b@pacbell.net>
Subject: Re: Touchscreen on Innovator OMAP1510
Date: Fri, 5 May 2006 13:25:23 -0700
Message-ID: <200605051325.24349.david-b@pacbell.net>
References: <9343BE359FA4224CA72A94D8CC362C9C0936A8@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C0936A8@edpc500.cedt.iisc.ernet.in>
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
Cc: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
List-Id: linux-omap@vger.kernel.org

On Friday 05 May 2006 5:07 am, Prakash Narayanan M wrote:

> Innovator has ADS7846E as touchscreen controller.  How to enable the
> driver for ads7846 instead of tsc2101?

Did you try this with the current kernel tree?  There was a bogus
dependency in Kconfig which should resolve that even if you're using
the "old" touchscreen driver.

You could switch do the "new" drivers/input/touchscreen/ads7846.c driver
with a simple bitbang SPI module.  If you're interested, I'll post you one
off-list that you'd need to modify for Innovator.

- Dave
