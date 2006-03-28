From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH] fix MMC response types
Date: Tue, 28 Mar 2006 16:59:18 -0400
Message-ID: <4429A3A6.5000503@indt.org.br>
References: <fb249edb0603241237l5854cc04k@mail.gmail.com>	
	<4427DEA0.6050804@indt.org.br>
	<fb249edb0603271204o1d8df4oe636c1181362d740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030307070307020903040906"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0603271204o1d8df4oe636c1181362d740@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307070307020903040906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ext andrzej zaborowski wrote:

>On 27/03/06, Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
>  
>
>>ext andrzej zaborowski wrote:
>>
>>    
>>
>>>Previously the MMC/SD protocol layer didn't provide command and
>>>response types to mmc_omap_start_command(). In 2.6.16 it does and the
>>>hack that tries to find the correct command/response types based on
>>>flags is no longer needed.
>>>This matters particularly for response types because for command types
>>>this hack worked fine, while it failed to give correct response type
>>>for some SD commands such as CMD3 (in most cases this caused no big
>>>problems because the size of the response matched).
>>>Regards,
>>>Andrzej
>>>--
>>>balrog 2oo6
>>>
>>>Dear Outlook users: Please remove me from your address books
>>>http://www.newsforge.com/article.pl?sid=03/08/21/143258
>>>
>>>
>>>------------------------------------------------------------------------
>>>
>>>_______________________________________________
>>>Linux-omap-open-source mailing list
>>>Linux-omap-open-source@linux.omap.com
>>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>>
>>>
>>>      
>>>
>>Hi Andrzej and folks,
>>
>>Attached to this mail follow my propose of fixing MMC responde types in
>>mmc_omap_start_command().
>>
>>This is based on the patches of the thread '[RFC] mmc: add OMAP driver'
>>that I sent to LKML mailing-list in order to have integrated the MMC
>>OMAP driver on the mainline kernel.
>>
>>Comments and suggestions are welcome.
>>    
>>
>It looks fine except you forgot about the response type 6. With the
>current version of mmc_omap_start_command() the hack assumes response
>type 1 in place of 6 which merely causes the MMC/SD host controller to
>misinterpret the status flags in the response from the card, but the
>size of the response matches. However with your patch it would assume
>no response at all which would most probably cause breakage.
>
>  
>
>>BR,
>>
>>Carlos.
>>
>>--
>>Carlos Eduardo
>>Software Engineer
>>Nokia Institute of Technology - INdT
>>Embedded Linux Laboratory - 10LE
>>Phone: +55 92 2126-1079
>>Mobile: +55 92 8127-1797
>>E-mail: carlos.aguiar@indt.org.br
>>
>>
>>
>>
>>    
>>
>
>Regards,
>Andrew
>--
>balrog 2oo6
>
>Dear Outlook users: Please remove me from your address books
>http://www.newsforge.com/article.pl?sid=03/08/21/143258
>  
>
Hi Andrew and folks,

The response type 6 was included. Thanks for your observation.

BR,

Carlos.

-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------030307070307020903040906
Content-Type: text/x-patch;
 name="mmc_omap_rsp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_rsp.patch"

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-03-28 16:45:43.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-03-28 16:52:29.000000000 -0400
@@ -49,6 +49,7 @@
 #include "omap.h"
 
 #define DRIVER_NAME "mmci-omap"
+#define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...)	pr_debug(x)
@@ -185,36 +186,30 @@ mmc_omap_start_command(struct mmc_omap_h
 		host->hw_bus_mode = host->bus_mode;
 	}
 
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		resptype = 0;			/* Resp 0 */
-
-	if (cmd->flags & MMC_RSP_136)
-		resptype = 2;			/* Resp 2 */
-	else {
-		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
-			resptype = 3;		/* Resp 3 */
-		else
-			resptype = 1;		/* Resp 1, Resp 1b */
+	/* Our hardware needs to know exact type */
+	switch (RSP_TYPE(mmc_resp_type(cmd))) {
+	case RSP_TYPE(MMC_RSP_R1):
+		/* resp 1, resp 1b */
+		resptype = 1;
+		break;
+	case RSP_TYPE(MMC_RSP_R2):
+		resptype = 2;
+		break;
+	case RSP_TYPE(MMC_RSP_R3):
+		resptype = 3;
+		break;
+	case RSP_TYPE(MMC_RSP_R6):
+		resptype = 6;
+		break;
+	default:
+		break;
 	}
 
-	/* Protocol layer does not provide command type, but our hardware
-	 * needs it!
-	 * any data transfer means adtc type (but that information is not
-	 * in command structure, so we flagged it into host struct.)
-	 * However, telling bc, bcr and ac apart based on response is
-	 * not foolproof:
-	 * CMD0  = bc  = resp0  CMD15 = ac  = resp0
-	 * CMD2  = bcr = resp2  CMD10 = ac  = resp2
-	 *
-	 * Resolve to best guess with some exception testing:
-	 * resp0 -> bc, except CMD15 = ac
-	 * rest are ac, except if opendrain
-	 */
-	if (host->data) {
+	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC) {
 		cmdtype = OMAP_MMC_CMDTYPE_ADTC;
-	} else if (resptype == 0 && cmd->opcode != 15) {
+	} else if (mmc_cmd_type(cmd) == MMC_CMD_BC) {
 		cmdtype = OMAP_MMC_CMDTYPE_BC;
-	} else if (host->bus_mode == MMC_BUSMODE_OPENDRAIN) {
+	} else if (mmc_cmd_type(cmd) == MMC_CMD_BCR) {
 		cmdtype = OMAP_MMC_CMDTYPE_BCR;
 	} else {
 		cmdtype = OMAP_MMC_CMDTYPE_AC;

--------------030307070307020903040906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030307070307020903040906--
