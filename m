From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix USB host on 1510/5910?
Date: Tue, 4 Apr 2006 07:47:34 -0700
Message-ID: <20060404144733.GC15266@atomide.com>
References: <20060328164403.GL26949@earth.li> <20060328190519.GS26949@earth.li>
	<20060330180220.GH26949@earth.li> <20060404073819.GA15569@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060404073819.GA15569@orphique>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [060404 00:39]:
> On Thu, Mar 30, 2006 at 07:02:21PM +0100, Jonathan McDowell wrote:
> > ladis, I think this was you. Does the attached help at all, if you're
> > still having problems? It sorts things out for me on the E3 with latest
> > git; the OMAP5910 datasheet says that the lb clock needs enabled for USB
> > to work, so it seems reasonable that this is required.
> 
> Yes, that's it. Now it ends with:
> ohci ohci: OMAP OHCI
> ohci ohci: new USB bus registered, assigned bus number 1
> ohci ohci: irq 38, io mem 0xfffba000
> ohci ohci: OHCI Unrecoverable Error, disabled
> ohci ohci: HC died; cleaning up
> irq38: nobody cared
> which is expected result, because voiceblue board has 64MB memory and
> it's something what current omap_1510_local_bus_init cannot handle.

Good to hear, I've pushed it and generated 2.6.16-omap2 patch with it.

This should cut down the once a month usb-host-does-not-work-on-1510 mails :)

Tony
