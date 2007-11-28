From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Add temporary NOKIA_N810 machine type
Date: Tue, 27 Nov 2007 18:18:50 -0800
Message-ID: <20071128021850.GE11825@atomide.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Lauri Leukkunen <lauri.leukkunen@nokia.com> [071122 16:38]:
> This patch should be dropped once the official machine type
> is available in the tree.
> 
> Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> ---
>  arch/arm/tools/mach-types |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 71555a5..02fc824 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -16,6 +16,7 @@
>  #
>  # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
>  #
> +nokia_n810		MACH_NOKIA_N810		NOKIA_N810		5555
>  ebsa110			ARCH_EBSA110		EBSA110			0
>  riscpc			ARCH_RPC		RISCPC			1
>  nexuspci		ARCH_NEXUSPCI		NEXUSPCI		3


Pushing this too.. In general, let's try not to have temporary board
id's, there's really no need for that.

Tony
