From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux-next: manual merge of the trivial tree with the omap
 tree
Date: Mon, 13 Dec 2010 11:01:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012131101140.15140@pobox.suse.cz>
References: <20101213134457.d0fb1e13.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101213134457.d0fb1e13.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Lionel Debroux <lionel_debroux@yahoo.fr>
List-Id: linux-omap@vger.kernel.org

On Mon, 13 Dec 2010, Stephen Rothwell wrote:

> Hi Jiri,
> 
> Today's linux-next merge of the trivial tree got a conflict in
> arch/arm/mach-omap2/pm24xx.c between commit
> e83df17f178360a8e7874441bca04a710c869e42 ("OMAP2+: PM/serial: fix console
> semaphore acquire during suspend") from the omap tree and commit
> 2f55ac072f5344519348c0c94b3d2f4cca46847b ("suspend: constify
> platform_suspend_ops") from the trivial tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Thank you Stephen. If you could carry this fixup patch, then it seems best 
option for me. This conflict is trivial enough to be resolved later during 
merge.

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --cc arch/arm/mach-omap2/pm24xx.c
> index aaeea49,aa9764e..0000000
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@@ -354,13 -326,7 +354,13 @@@ static void omap2_pm_finish(void
>   	enable_hlt();
>   }
>   
>  +static void omap2_pm_end(void)
>  +{
>  +	suspend_state = PM_SUSPEND_ON;
>  +}
>  +
> - static struct platform_suspend_ops omap_pm_ops = {
> + static const struct platform_suspend_ops omap_pm_ops = {
>  +	.begin		= omap2_pm_begin,
>   	.prepare	= omap2_pm_prepare,
>   	.enter		= omap2_pm_enter,
>   	.finish		= omap2_pm_finish,
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
