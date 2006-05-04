From: David Brownell <david-b@pacbell.net>
Subject: Re: Undefined usb_disconnect,
	was [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Thu, 4 May 2006 09:32:45 -0700
Message-ID: <200605040932.46678.david-b@pacbell.net>
References: <4452384E.7080409@gmail.com>
	<200605040751.45417.david-b@pacbell.net>
	<445A2712.1000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <445A2712.1000606@gmail.com>
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

On Thursday 04 May 2006 9:08 am, Dirk Behme wrote:
> David Brownell wrote:
> > On Wednesday 03 May 2006 11:41 am, Dirk Behme wrote:

> > I see a curious and pointless routine, ohci_omap_host_enable(), which
> > isn't called from anywhere I can see, which wants usb_disconnect().
> > 
> > Try deleting that routine.
> 
> tahvo-usb.c uses ohci_omap_host_enable():

And so it does.  That would be a bug in how the Tahvo transceiver is
trying to activate the USB host.  It should be able to just use
the normal power management suspend and resume calls... certainly
there's no benefit to creating transceiver-specific backdoors into
usbcore for runtime PM.

- Dave
