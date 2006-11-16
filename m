From: Frantisek Dufka <dufkaf@seznam.cz>
Subject: Re: clock divisor in mmc_omap_set_ios in drivers/mmc/omap.c wrong
Date: Thu, 16 Nov 2006 09:15:14 +0100
Message-ID: <455C1E12.2010403@seznam.cz>
References: <45544C51.1050106@seznam.cz> <20061116010527.GM21064@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061116010527.GM21064@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> 
> This seems like a bug to me (or else the TRMs have a typo). Let's patch
> it out and see if it still works.
> 

Yes, that's what I did on Nokia 770 and have mixed results. Most MMC 
cards around me work with this line removed (at 16Mhz) and there is some 
speedup (~1.8MB/s@16Mhz vs ~1.4MB/s@12Mhz) but the 64 MB one shipped 
with Nokia (plain MMC, 7 pins) give me I/O error when inserted. Even 
partition table is not read. Other cards that work are 128MB noname 
RS-MMC, 1GB Sandisk RS-MMC, 2GB Kingston MMCmobile (13 pins).

Also interesting is that after I posted my question to this list few 
days later Nokia released newer kernel source for newer N770 firmware 
and this dsor++ line is removed there, but there is board specific code 
that limits MMC speed on Nokia N770 to 12Mhz. So there seems to be 
something fishy with MMC speeds over 12Mhz (on N770). Either there are 
known cards on market which fail or Nokia shipped buggy cards with 
devices and limited MMC interface speed due to this. Or can this limit 
be matter of wiring/shielding of specific device? Their newer kernel 
have also support for newer device with miniSD slot with speed limited 
to 24Mhz in same omap driver.

I'm digging into in this because the MMC speed on N770 is pathetic and 
newer MMCmobile cards can operate up to 52Mhz. And it looks like with 
high speed MMC v4.1 patches MMC interface in OMAP1710 inside N770 can 
run at 48Mhz (divisor=1) giving me ~6MB/s@48Mhz when reading. Every 
MMCmobile/plus card can do at least 26Mhz so even 24Mhz is good speedup 
(over original 12Mhz).

See also http://fanoush.webpark.cz/maemo/#mmcplus
Some people tried it on their N770 and I got few successful reports and 
no unsuccesful ones. Such speed is quite useful when booting from MMC 
and having swap on MMC too. I'm running my N770 in this setup for more 
than month with Kingston 2GB card @ 48Mhz and had no problems so far 
(i/o error, data corruption).

So my next related question is whether OMAP 1710 MMC interface is 
designed to run with divisor set to 1 with 48Mhz clock. It seems to work 
fine and give nice speed boost with newer MMCmobile cards on market. 
There is no limit mentioned in spru765a.pdf so I don't know whether I'm 
in fact overclocking something or not.

Regards,
Frantisek
