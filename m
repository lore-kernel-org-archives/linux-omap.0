From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH, for GregKH] ARM: omap1: remove unused variable
Date: Mon, 17 Jun 2019 15:07:34 +0200
Message-ID: <20190617130734.GA15784@kroah.com>
References: <20190617125521.1553103-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617125521.1553103-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 17, 2019 at 02:55:02PM +0200, Arnd Bergmann wrote:
> The cleanup of the debugfs functions left one variable behind that
> should now be removed as well:
> 
> arch/arm/mach-omap1/clock.c:1008:6: error: unused variable 'err' [-Werror,-Wunused-variable]
> 
> Fixes: d5ddd5a51726 ("arm: omap1: no need to check return value of debugfs_create functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/clock.c | 1 -
>  1 file changed, 1 deletion(-)

Oops, sorry about that, odd that 0-day never reported it :(

I'll go queue this up now, thanks.

greg k-h
