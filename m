From: Tony Lindgren <tony@atomide.com>
Subject: Re: clock divisor in  mmc_omap_set_ios in drivers/mmc/omap.c wrong
Date: Thu, 16 Nov 2006 03:05:27 +0200
Message-ID: <20061116010527.GM21064@atomide.com>
References: <45544C51.1050106@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45544C51.1050106@seznam.cz>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Frantisek Dufka <dufkaf@seznam.cz>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Frantisek Dufka <dufkaf@seznam.cz> [061110 11:55]:
> Hello,
> 
> anyone knows real reason why the divisor is intentionally lowered in
> mmc_omap_set_ios so the result frequency is _not_ near the one requested?
> 
> First there is a code which tries hard to select the divisor that
> produces highest possible frequency which is lower or equal to the
> requested one
> 
>        fclk_rate = clk_get_rate(host->fclk);
>        dsor = fclk_rate / freq;
>        if (dsor < 1)
>                dsor = 1;
>        if (fclk_rate / dsor > freq)
>                dsor++;
> 
>        if (dsor > 250)
>                dsor = 250;
> 
> and then there is additional
> 
>        dsor++;
> 
> which intentionally makes resulting frequency lower by unknown factor.
> 
> If this is some workaround for specific cards maybe it should be solved
> in different place like blacklisting offending cards and actually
> requesting lower frequency for them. Or is  there some real reason?
> 
> For requested 20Mhz MMC bus speed and 48Mhz omap clock current code
> results in 12Mhz instead of 16Mhz.

This seems like a bug to me (or else the TRMs have a typo). Let's patch
it out and see if it still works.

Regards,

Tony
