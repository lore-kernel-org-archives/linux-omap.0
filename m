From: "Veda N" <veda74@gmail.com>
Subject: stacked memories
Date: Sat, 4 Aug 2007 03:44:20 +0530
Message-ID: <a5eaedfa0708031514l5e467b50nf1c9a0af41445369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
   What are stacked memory schemes and POP memory schemes in OMAP2430.

   What is the difference?

   Does stacked mean - Multiple chips of DDR one above the other?.

   POP means one processor + one DDR + (nand/nor/one nand) ?

   I am not sure if this is correct.

   I came across these # defines in the x-loaders. Could anyone explain me
what it means.


 #define CFG_SDRAM_DDR         1 /* not tested */
#define CFG_SDRAM_COMBO       2 /* not tested */
#define CFG_2430SDRAM_DDR     3
#define CFG_SDRAM_STACKED       4 /* not tested */


If i have a POP DDR memory which one should i choose?.


Regards,
vedan
