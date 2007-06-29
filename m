From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: Why does it increase the dsor value in MMC?
Date: Fri, 29 Jun 2007 18:52:19 +0900
Message-ID: <001401c7ba33$31339130$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: 'Linux OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

In mmc_omap_calc_divisor(). We calculate the dsor value.
In the code why does it increase the dsor at the end of code?

Now the Apollon board uses func_clk_rate as 95,000,000 and ios->clock is
20,000,000

	dsor = func_clk_rate / ios->clock;	=> 4
        if (dsor < 1)
                dsor = 1;

        if (func_clk_rate / dsor > ios->clock)	=> True
                dsor++;				=> 5

        if (dsor > 250)
                dsor = 250;
        dsor++;					=> 6

After the current calculation, we use the host clock as 15,833,333 (dsor 6). But
if it is not increased, we can use the 19,000,000 (dsor 5)

It there any reason to increase this value?

Thank you,
Kyungmin Park
