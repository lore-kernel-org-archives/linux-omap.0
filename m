From: David Brownell <david-b@pacbell.net>
Subject: Re: SPI controller on omap5912
Date: Wed, 24 Jan 2007 18:33:47 -0800
Message-ID: <200701241833.47414.david-b@pacbell.net>
References: <BAY130-F25DF6A55824D7E1548ED8EF8A30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY130-F25DF6A55824D7E1548ED8EF8A30@phx.gbl>
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
To: zil iram <zil_iram@hotmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 January 2007 6:06 pm, zil iram wrote:
> 
> Okey thanks Dave.
> 
> Has anyone used the "spi" controller on omap before? 

Almost certainly, or I expect TI would have desupported it by now.

> Is there an omap kernel  
> which supports the "spi controller?"

Do you see a driver for it in the current OMAP GIT tree?
If not, that's probably your answer ... someone may have
some code floating around to use it, though.
