From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH] SD working on OMAP platforms
Date: Sat, 31 Mar 2007 18:07:40 -0400
Message-ID: <460EDBAC.9050301@indt.org.br>
References: <460D72E0.7050206@indt.org.br> <460DFCB9.4070102@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000900050700070303010708"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <460DFCB9.4070102@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>, ext Philip Langdale <philipl@overt.org>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900050700070303010708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ext Pierre Ossman wrote:
> Carlos Aguiar wrote:
>   
>> On CMD3, response type is R6 to SD cards and R1 to MMC cards.
>> This fix ignores the buggy SD handling on CMD3.
>>
>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>>
>>   
>>     
>
> NAK. Includes opcodes.
>
> I assume 0x4000 is that darn CERR, so have the if-statement test just
> (status == 0x4000).
>
> Rgds
>
>   
Ok,

Now, without opcodes and if-statement test just
(status == 0x4000).

BR,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------000900050700070303010708
Content-Type: text/plain;
 name="sd_buggy_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sd_buggy_handling.diff"

On CMD3, response type is R6 to SD cards and R1 to MMC cards.
This fix ignores the buggy SD handling on CMD3.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2007-03-30 09:39:08.000000000 -0400
+++ linux-omap/drivers/mmc/omap.c	2007-03-31 18:03:49.000000000 -0400
@@ -462,6 +462,12 @@ static irqreturn_t mmc_omap_irq(int irq,
 		mmc_omap_report_irq(status);
 		printk("\n");
 #endif
+		if (status == 0x4000) {
+			dev_dbg(mmc_dev(host->mmc),
+				"buggy SD handling, ignoring it\n");
+			status = 0x0001;
+		}
+
 		if (host->total_bytes_left) {
 			if ((status & OMAP_MMC_STAT_A_FULL) ||
 			    (status & OMAP_MMC_STAT_END_OF_DATA))

--------------000900050700070303010708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000900050700070303010708--
