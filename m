From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling Mistral touch screen driver
Date: Mon, 15 May 2006 11:54:20 -0700
Message-ID: <200605151154.22221.david-b@pacbell.net>
References: <4465A8C0.4020100@nextbitcpu.com>
	<200605140955.53619.david-b@pacbell.net>
	<4468BC84.6050205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4468BC84.6050205@gmail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 15 May 2006 10:38 am, Dirk Behme wrote:
> > 
> > CONFIG_OMAP_OSK_MISTRAL=y
> > CONFIG_INPUT_TOUCHSCREEN=y
> > CONFIG_TOUCHSCREEN_ADS7846=y
> > CONFIG_SPI_OMAP_UWIRE=y
> > 
> > That assumes a recent GIT tree, which includes the board-specific init
> > needed to make that work.
> 
> Any plans to remove CONFIG_OMAP_UWIRE or 
> CONFIG_TOUCHSCREEN_OMAP so that guys like me using their 
> configuration for ages are forced to rethink about it?

Yes.  Given patches merged today, and one I'll post soonish, it's almost
time to get rid of

	drivers/input/touchscreen/omap/
		ads7846.h
		ts_inn1510.c
		ts_osk.c

Until there's a tsc2101.c SPI-framework driver, the ts_hx.c support
(and omap-alsa-tsc2101) will need to stick around though.  

And there will be similar issues for the CONFIG_OMAP_UWIRE too;
likely more than just tsc2101 support needs that for the moment.

- Dave
