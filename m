From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Update recent gpio-keys changes in apollon
	board
Date: Wed, 16 May 2007 10:52:38 -0700
Message-ID: <20070516175237.GI20297@atomide.com>
References: <001101c796ac$ed7aae50$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <001101c796ac$ed7aae50$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kmpark@infradead.org> [070514 21:58]:
> [PATCH] ARM: OMAP: Update recent gpio-keys changes in apollon board
> 
> - Also fix section mismatch: reference to .init.text: from .text in apollon
> board

Pushing today.

> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -270,7 +270,7 @@ static struct omap_lcd_config apollon_lcd_config __initdata
> = {
>  	.ctrl_name	= "internal",
>  };

Next time, can you please try the Outlook trick Khasim posted few weeks
ago to this mailing list to avoid wrapping of the patches?

Regards,

Tony
