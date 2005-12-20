From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: H3 LCD clocking changes suggested by the driver.
Date: Tue, 20 Dec 2005 14:15:57 +0200
Message-ID: <1135080957.12906.38.camel@two.research.nokia.com>
References: <20051213015621.GA25503@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051213015621.GA25503@slurryseal.ddns.mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, 2005-12-20 at 13:57 +0200, Todd Poynor wrote:

> H3 LCD internal controller clocking updates suggested by the driver:
> 
> omapfb-lcdc: Pixel clock divider value is obsolete.
> omapfb-lcdc: Try to set pixel_clock to 12000 and pcd to 0 in drivers/video/omap/lcd_h3.c and submit a patch.
> 
> Tux logo appears fine and so does IceWM under Xfbdev.

Thanks, applied.

Cheers,
Juha
