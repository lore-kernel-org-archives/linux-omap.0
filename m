From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] arm: smp-twd: check for uninitialized clock in
 twd_cpufreq_init
Date: Sat, 18 Feb 2012 19:56:30 +0400
Message-ID: <4F3FCA2E.3000804@ru.mvista.com>
References: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 17-02-2012 14:34, Tero Kristo wrote:

> Non-smp platforms don't have local timer support, but the twd_cpufreq_init
> only checks for IS_ERR during init. Check against null also, to avoid
> crashes during cpufreq transitions on non-smp platforms.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/kernel/smp_twd.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..dae8902 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
>
>   static int twd_cpufreq_init(void)
>   {
> -	if (!IS_ERR(twd_clk))
> +	if (twd_clk&&  !IS_ERR(twd_clk))

    Why not !IS_ERR_OR_NULL(twd_clk)?

WBR, Sergei
