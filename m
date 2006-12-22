From: David Brownell <david-b@pacbell.net>
Subject: Re: touchscreen on omap5912
Date: Fri, 22 Dec 2006 10:29:40 -0800
Message-ID: <200612221029.41005.david-b@pacbell.net>
References: <e14857210612220618g1a1ce01evcd8df9c585050630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <e14857210612220618g1a1ce01evcd8df9c585050630@mail.gmail.com>
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
List-Id: linux-omap@vger.kernel.org

> I've no idea how I can connect the touchscreen signals(they are x+, x-, y+
> and y-) to omap5912.
> Is ADS7846 needed?
> Or should I connect them directly to CPU?

If you look at schematics for a board that uses a touchscreen, you'll
notice that x+/x- and y+/y- are differential signals, so you'll need
digital-to-analog conversion.  OMAP doesn't integrate such stuff.

You don't need an ads7846, but you'll need _some_ chip.  TSC2101 is
another option (from TI, and there are dozens of others.
