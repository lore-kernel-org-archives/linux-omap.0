From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-omap] fix omap2 kconfig goofage
Date: Sun, 14 Oct 2007 10:08:52 -0700
Message-ID: <20071014170850.GD22833@atomide.com>
References: <200710121423.48331.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200710121423.48331.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [071012 14:27]:
> Clean up OMAP2 Kconfig.  Again.
> 
>  - 34xx shouldn't go in the middle of the 24xx stuff, it
>    goofs the dependency tree displayed by e.g. kconfig.
>    In particular, not in the middle of the H4-specific
>    options.
> 
>  - Make the 2420 boards depend on OMAP2420, and 2430 boards
>    on OMAP2430 ... a 2420-only kernel shouldn't show 2430
>    boards, and vice versa.

Thanks again, pushed.

Tony
