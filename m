From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: catch pending imprecise abort on unmask
Date: Thu, 15 Oct 2015 08:21:49 +0100
Message-ID: <20151015072149.GG32536@n2100.arm.linux.org.uk>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444834113-18122-2-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 14, 2015 at 04:48:30PM +0200, Lucas Stach wrote:
> Install a non-faulting handler just before unmasking imprecise aborts
> and switch back to the regular one after unmasking is done.
> 
> This catches any pending imprecise abort that the firmware/bootloader
> may have left behind that would normally crash the kernel at that point.
> As there are apparently a lot of bootlaoders out there that do such a
> thing it makes sense to handle it in the common startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mm/fault.c | 15 +++++++++++++++
>  arch/arm/mm/fault.h |  2 ++
>  arch/arm/mm/mmu.c   | 19 ++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 0d629b8f973f..519f694ec9db 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -538,6 +538,21 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>  	fsr_info[nr].name = name;
>  }
>  
> +void * __init
> +swap_fault_function(int nr,
> +		    int (*fn)(unsigned long, unsigned int, struct pt_regs *))
> +{
> +	void *old_fn;
> +
> +	if (nr < 0 || nr >= ARRAY_SIZE(fsr_info))
> +		BUG();
> +
> +	old_fn = fsr_info[nr].fn;
> +	fsr_info[nr].fn = fn;
> +
> +	return old_fn;
> +}
> +

Please move the abort enable and handler into fault.c - I don't want this
exposed to the rest of the kernel as people will get the impression that
they can make use of this, even though it's not in arch/arm/include/, as
a way to hook and then subsequently unhook a handler.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
