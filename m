From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-rc3-omap-git 2/2] musb_hdrc cleanup -- cppi and
	sparse
Date: Mon, 27 Aug 2007 07:03:43 -0700
Message-ID: <20070827140342.GL13538@atomide.com>
References: <200708251442.13105.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708251442.13105.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070826 23:53]:
> Cleanup for CPPI DMA (for DaVinci, and someday TUSB6020):
> 
>  - Move state ram structs to CPPI header, it's not DaVinci-specific
> 
>  - Do some associated CamelCase removal, in conjunction with removing
>    inappropriate "volatile" declarations.
> 
> This resolves a bunch of "sparse" warnings with this code, most of which
> seem to have been caused by bugs in older versions of "sparse".

Pushed.

Tony
