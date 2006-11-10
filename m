From: Frantisek Dufka <dufkaf@seznam.cz>
Subject: clock divisor in  mmc_omap_set_ios in drivers/mmc/omap.c wrong
Date: Fri, 10 Nov 2006 10:54:25 +0100
Message-ID: <45544C51.1050106@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

anyone knows real reason why the divisor is intentionally lowered in
mmc_omap_set_ios so the result frequency is _not_ near the one requested?

First there is a code which tries hard to select the divisor that
produces highest possible frequency which is lower or equal to the
requested one

        fclk_rate = clk_get_rate(host->fclk);
        dsor = fclk_rate / freq;
        if (dsor < 1)
                dsor = 1;
        if (fclk_rate / dsor > freq)
                dsor++;

        if (dsor > 250)
                dsor = 250;

and then there is additional

        dsor++;

which intentionally makes resulting frequency lower by unknown factor.

If this is some workaround for specific cards maybe it should be solved
in different place like blacklisting offending cards and actually
requesting lower frequency for them. Or is  there some real reason?

For requested 20Mhz MMC bus speed and 48Mhz omap clock current code
results in 12Mhz instead of 16Mhz.

Frantisek
