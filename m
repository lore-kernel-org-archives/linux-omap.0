From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.18-omap] 24xx pinmux updates
Date: Wed, 18 Oct 2006 22:45:22 +0300
Message-ID: <20061018194521.GI4669@atomide.com>
References: <200610171415.46306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610171415.46306.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [061018 00:23]:
> Add some OMAP 24xx pin mux declarations to support:
> 
>  - TUSB 6010 EVM (on H4)
>  - All three full speed USB ports
>  - GPIOs used with USB0 on Apollon and H4
> 
> For OMAP2, issue MUX_WARNINGS and debug messages correctly; and make the
> message look more like the OMAP1 message.

Pushing today.

Tony
