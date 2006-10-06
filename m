From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Make OMAP1 work again
Date: Fri, 6 Oct 2006 15:49:00 +0300
Message-ID: <20061006124859.GJ32423@atomide.com>
References: <452628C9.1020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <452628C9.1020603@gmail.com>
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
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061006 12:58]:
> 
> In mach-omap1/mailbox.c the mailbox name is .name = "DSP"
> while in plat-omap/dsp/dsp_core.c function  dsp_mbox_init()
> asks for "dsp". This results in a strcmp() mismatch and then
> OMAP1 system crashes due to NULL pointer. OMAP2 is correct,
> there .name is "dsp". Correct OMAP1 name to "dsp" as well.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> --- ./arch/arm/mach-omap1/mailbox.c_orig	2006-10-06 11:08:50.000000000 +0200
> +++ ./arch/arm/mach-omap1/mailbox.c	2006-10-06 11:09:13.000000000 +0200
> @@ -136,7 +136,7 @@ static struct omap_mbox1_priv omap1_mbox
>  };
>  
>  struct omap_mbox mbox_dsp_info = {
> -	.name = "DSP",
> +	.name = "dsp",
>  	.ops  = &omap1_mbox_ops,
>  	.priv = &omap1_mbox_dsp_priv,
>  };
> 
> 

Great, I pushed it.

Regards,

Tony
