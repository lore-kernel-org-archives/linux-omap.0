From: tony@atomide.com
Subject: Re: I2C zero length transfers and SMBUS_QUICK,
	was: Pending October patches
Date: Tue, 7 Nov 2006 19:40:40 +0200
Message-ID: <20061107174039.GG6215@atomide.com>
References: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
	<454DBDC7.70706@gmail.com> <200611051737.11242.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611051737.11242.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061106 03:44]:
> On Sunday 05 November 2006 2:32 am, Dirk Behme wrote:
> >
> > Our hack to make things work on OMAP will not be accepted 
> > upstream. But staying with broken OMAP features only because 
> > (available) hack isn't acceptable in mainline doesn't sound 
> > like an option as well.
> > 
> > I personally vote for working OMAP ;)
> 
> Me too ... the sad part is that this is basicallly a design bug
> in the upstream I2C stack, and over the past couple years there
> have been no evident signs of it ever getting fixed.

I wonder if we could help somehow by doing "embedded i2c stack"
by modifying your SPI framework to support i2c?

Tony
