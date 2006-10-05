From: Ladislav Michl <ladis@mips-linux.cz>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in clock.c
Date: Thu, 5 Oct 2006 09:48:57 +0200
Message-ID: <20061005074857.GA10371@orphique>
References: <4523B70B.6030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4523B70B.6030100@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 04, 2006 at 03:28:43PM +0200, Dirk Behme wrote:
> 
> Fix warning
> 
> arch/arm/mach-omap1/clock.c: In function
> 'omap1_clk_enable_generic':
> arch/arm/mach-omap1/clock.c:499: warning: 'return' with no
> value, in function returning non-void
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> --- ./arch/arm/mach-omap1/clock.c_orig	2006-10-04 15:07:39.000000000 +0200
> +++ ./arch/arm/mach-omap1/clock.c	2006-10-04 15:09:41.000000000 +0200
> @@ -496,7 +496,7 @@ static int omap1_clk_enable_generic(stru
>  		}
>  	}
>  
> -	return;
> +	return 0;
>  }

Does it make sense to return any vaule at all? This functions return
always 0. Perhaps in case there is no enable reg it should return
something else. Btw, can this code run on omap2 cpu?


diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index f8e1294..45d0314 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -432,8 +432,7 @@ static int omap1_clk_enable(struct clk *
 			}
 
 			if (clk->flags & CLOCK_NO_IDLE_PARENT)
-				if (!cpu_is_omap24xx())
-					omap1_clk_deny_idle(clk->parent);
+				omap1_clk_deny_idle(clk->parent);
 		}
 
 		ret = clk->enable(clk);
@@ -454,8 +453,7 @@ static void omap1_clk_disable(struct clk
 		if (likely(clk->parent)) {
 			omap1_clk_disable(clk->parent);
 			if (clk->flags & CLOCK_NO_IDLE_PARENT)
-				if (!cpu_is_omap24xx())
-					omap1_clk_allow_idle(clk->parent);
+				omap1_clk_allow_idle(clk->parent);
 		}
 	}
 }
