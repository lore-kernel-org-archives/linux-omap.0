From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [patch linux-omap-git] fix SPI_CPHA related errors
Date: Wed, 23 May 2007 09:50:57 -0700
Message-ID: <465470F1.2020109@mvista.com>
References: <200705222232.27584.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200705222232.27584.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> The OMAP SPI controller drivers handle SPI_CPHA incorrectly.
> It should mean:
> 
>   CPHA=0 ... sample at leading edge of clock
>   CPHA=1 ... sample at trailing edge of clock
> 
> This fixes them, and the protocol drivers which depended on the wrong
> meaning.  Separate ads7846 and omap_uwire patches are going upstream,
> already since those drivers were already pushed there.  The tsc2102
> code already had this right ... strange.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Verified that tsc2046 driver still works.

Acked-by: Kevin Hilman <khilman@mvista.com>
