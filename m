From: Jukka Honkela <jukka@honkela.org>
Subject: RE: touchscreen problem with H3
Date: Thu, 7 Jun 2007 14:44:08 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0706071103410.3089@ugly.blerp.org>
References: <200705311104.l4VB4wAj004753@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200705311104.l4VB4wAj004753@dbdp31.itg.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 31 May 2007, Girish wrote:

>>> I've been trying to get touchscreen to work with omap1710 h3 board
>>> but I seem to get
>>> tsc2101 spi2.0: error reading from I/O EXPANDER

> I see this error coming while doin' some read_gpio_expa, it uses i2c
> internally...u might want to check this...

Well, the problem was a bit something else than what I originally thought.
First of all, the read_gpio_expa is not a flawless thing, it assumes that
the first (0) adapter is what it should use. It happened to be that due
to my configuration options (apparently) the actual device number is 1.

But, this is actually somewhat unrelated, because the true problem
here is that CONFIG_TOUCHSCREEN_OMAP is not supported at the moment,
the driver is apparently out of date. I can try to hack that driver
up to date, but that might turn out to be complicated (or not,
hard to tell)... -> I wonder if a patch for this would exist already
somewhere?

-- 
Jukka Honkela
