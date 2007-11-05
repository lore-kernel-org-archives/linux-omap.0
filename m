From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Mon, 5 Nov 2007 01:56:40 -0800
Message-ID: <200711050156.40287.david-b@pacbell.net>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<200711020927.40350.david-b@pacbell.net>
	<20071105102657.f195e5c0.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071105102657.f195e5c0.jarkko.nikula@nokia.com>
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
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 05 November 2007, Jarkko Nikula wrote:
> 
> > Is there a reason you're not using 400k anywhere?
> > ISTR at one point checking specs and finding that
> > many TI dev boards were spec'd so that 400k should
> > work fine.
> > 
> Reason is to not break anything :-)
> 
> Honestly I don't believe that we have many boards with components not
> rated for 400 kHz.

Most components are rated like that.  Unfortunately it
seems the isp1301 transceiver -- for full speed USB-OTG
support -- has a 100 KHz ceiling on the clock rate,
so bus segments with those (found on H2, H3, H4, and
surely a few others) can't use 400K.  Ditto the pcf8574
I/O expanders.

- Dave
