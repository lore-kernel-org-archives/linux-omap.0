From: Tony Lindgren <tony@atomide.com>
Subject: Re: TSC2101/2102
Date: Tue, 3 Apr 2007 15:23:20 -0400
Message-ID: <20070403192318.GJ32591@atomide.com>
References: <20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
	<a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
	<20070331170100.GA2565@bitbox>
	<a0580c510704020643k6c29da26h548385a1dd1b348f@mail.gmail.com>
	<20070402202325.GA23808@bitbox>
	<a0580c510704021341y476604b7l129b11f6a8ce4f57@mail.gmail.com>
	<a0580c510704030422u1ce3df44n45c4617fa2abb1a8@mail.gmail.com>
	<20070403143616.GA12681@bitbox>
	<a0580c510704030810x2808fe0ara07c55914c536173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <a0580c510704030810x2808fe0ara07c55914c536173@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval@gmail.com> [070403 11:10]:
> Hi Imre,
> 
> 
>   All right, I agreed with you :). I'm re-sending now an updated
> patch. Now it uses  platform_data field to pass the spi_device to lcd.
> The lcd now is working here. It also fix the omap_h2_1610_defconfig
> file to include CONFIG_SPI_TSC2101 option.

I'll merge the drivers/video/omap/ changes to Imre's add framebuffer
patch. And I'll push the board init changes to omap-upstream.
The h2 defconfig should end up in the master branch.

Subject to comments from Imre, of course.

Regards,

Tony
