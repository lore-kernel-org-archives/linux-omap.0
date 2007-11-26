From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [patch 2.6.24-rc3-omap1] i2c init section fixes
Date: Mon, 26 Nov 2007 10:54:00 +0200
Message-ID: <20071126105400.0133e18f.jarkko.nikula@nokia.com>
References: <200711232320.05916.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200711232320.05916.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Nov 2007 23:20:05 -0800
"ext David Brownell" <david-b@pacbell.net> wrote:

> Fix init section warnings in the new i2c init code.  It's
> wrong to call "__init" functions from non-__init ones.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
>
Since i2c_register_board_info is defined with __init, we have to define
functions here with __init as well.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>

---

How do I enable that warning since I don't see it now? I remember that I
saw some timer related __init warnings some time ago. I'm using
"gcc version 3.4.4 (release) (CodeSourcery ARM 2005q3-2)".


	Jarkko
