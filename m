From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
Date: Mon, 03 Oct 2011 11:09:33 +0530
Message-ID: <4E894A95.5030107@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-29-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-29-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> The omap platform requires CPU_FREQ_TABLE support to be enabled for its
> CPU_FREQ implementations, so automatically select that when CPU_FREQ
> is enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-omap/Kconfig |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index bb8f4a6..f7ef9f4 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -217,6 +217,11 @@ config OMAP_PM_NOOP
>  
>  endchoice
>  
> +config OMAP_CPU_FREQ
> +	def_bool "y"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_TABLE
> +
>  endmenu
With CPUFREQ series from Kevin [1], I don't think we need this any-more.
More so, I didn't find OMAP_CPU_FREQ is being used anywhere on mainline.

Regards
Santosh
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg56288.html
