From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Activate MPU retention code in omap2/pm.c
Date: Tue, 3 Apr 2007 14:52:40 -0400
Message-ID: <20070403185238.GG32591@atomide.com>
References: <20070403153826.a614fb57.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070403153826.a614fb57.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070403 08:40]:
> FIXME section in function omap2_allow_mpu_retention didn't allow MPU to
> enter into retention even if system was idle. MPU retention works fine at
> least in Nokia N800.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/pm.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index cb1ae46..ef2c067 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -573,8 +573,7 @@ static int omap2_allow_mpu_retention(void)
>  	if (sti_console_enabled)
>  		return 0;
>  
> -	/* FIXME: Enable soon */
> -	return 0;
> +	return 1;
>  }
>  
>  static void omap2_enter_mpu_retention(void)

Pushing to omap-upstream.

Tony
