From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Thu, 8 Mar 2007 12:36:59 +0200
Message-ID: <20070308103659.GA4315@bitbox.mine.nu>
References: <85ps7pgphq.fsf@orfeo.duckcorp.org>
	<45EAFDBA.9010406@googlemail.com>
	<85r6s4damj.fsf@orfeo.duckcorp.org>
	<20070305100136.GC17801@atomide.com>
	<45EC7605.8060808@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45EC7605.8060808@googlemail.com>
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
Cc: linux-omap-open-source@linux.omap.com, jekyll@mail.jekyll.idv.tw, lastjp_fr@yahoo.fr
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Mar 05, 2007 at 08:56:53PM +0100, Dirk Behme wrote:
[...]
> 
> All: Following files need update. Let's try the names in 
> file headers:
> 
> * drivers/video/omap/lcd_h2.c
> 
> -> update to use drivers/spi/omap-uwire
> -> Imre?

It's dependent on the tsc2101 driver, but I'll take a look at both.

--Imre

> 
> * drivers/video/omap/lcd_p2.c
> 
> -> update to use drivers/spi/omap-uwire
> -> jekyll & B Jp & Brian Swetland?
> 
> * drivers/ssi/omap-tsc2101.{c,h}
> 
> -> update to use drivers/spi/omap-uwire and move it to 
> drivers/spi
> -> Nishanth?
> 
> Anything else?
> 
> Until this is done, only thing we can do to make Kconfig 
> happy is
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009220.html
> 
> Dirk
