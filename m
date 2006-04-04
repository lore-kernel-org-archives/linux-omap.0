From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] Fix USB host on 1510/5910?
Date: Tue, 4 Apr 2006 09:38:19 +0200
Message-ID: <20060404073819.GA15569@orphique>
References: <20060328164403.GL26949@earth.li> <20060328190519.GS26949@earth.li>
	<20060330180220.GH26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060330180220.GH26949@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 30, 2006 at 07:02:21PM +0100, Jonathan McDowell wrote:
> ladis, I think this was you. Does the attached help at all, if you're
> still having problems? It sorts things out for me on the E3 with latest
> git; the OMAP5910 datasheet says that the lb clock needs enabled for USB
> to work, so it seems reasonable that this is required.

Yes, that's it. Now it ends with:
ohci ohci: OMAP OHCI
ohci ohci: new USB bus registered, assigned bus number 1
ohci ohci: irq 38, io mem 0xfffba000
ohci ohci: OHCI Unrecoverable Error, disabled
ohci ohci: HC died; cleaning up
irq38: nobody cared
which is expected result, because voiceblue board has 64MB memory and
it's something what current omap_1510_local_bus_init cannot handle.

Thanks,
	ladis
