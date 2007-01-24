From: David Brownell <david-b@pacbell.net>
Subject: Re: SPI pins on omap5912
Date: Wed, 24 Jan 2007 11:25:24 -0800
Message-ID: <200701241125.24668.david-b@pacbell.net>
References: <BAY130-F68DE0B2ECF2ECFB623DA6F8AC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY130-F68DE0B2ECF2ECFB623DA6F8AC0@phx.gbl>
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

On Wednesday 24 January 2007 6:21 am, zil iram wrote:
> Hi,
> 
> I am using linux 2.6.17 on the omap5912 board. I would like to use the spif 
> pins, spif_cs0, spif_din, spif_dout, spif_sck on the board and connect them 
> to the spi pins on my device. Do I still need to make my own controller 
> driver for the spi framework?

yes

> Or can I use the omap_uwire? 

not unless you're using the microwire controller ...
