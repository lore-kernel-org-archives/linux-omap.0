From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Wed, 22 Feb 2006 09:18:32 -0400
Message-ID: <9268368b0602220518r20ea5269k36432777acbf75b2@mail.gmail.com>
References: <20060221212838.67357.qmail@web32905.mail.mud.yahoo.com>
	<20060221215426.68231.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5573_6691821.1140614312726"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060221215426.68231.qmail@web32903.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_5573_6691821.1140614312726
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On 2/21/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> --- Komal Shah <komal_shah802003@yahoo.com> wrote:
>
> >
> > True, the warning will be generated, but I added that check
> > considering
> > that transceiver_mode function will be active only if we are
> > successfully able to request that GPIO. So, I am _not_ sure, but it
> > is
> > better to #ifdef around the h2_transceiver_mode(...) function. What
> > do
> > you think?
> >
>
> And here comes the patch.
>
> OMAP: Irda: Remove warning
> arch/arm/mach-omap1/board-h2.c:244: warning: 'h2_transceiver_mode'
> defined but not used.
>
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
>
> ---Komal Shah
> http://komalshah.blogspot.com/

Humm, my first idea was exactly like this but I tried to avoid another #ifd=
ef..
So what about this new approach, which still avoids #ifdefs although
with expense of one flag ?

--

The board file for H2 is generating a warning if compiled without
InfraRed selection.

This patch changes the location where the function h2_transceiver_mode
is assigned to structure h2_irda_data, thereby preventing the warning
and also creates a flag variable telling when is safe to use h2
platform function for IR.

Signed-off-by Daniel Petrini <d.pensator_at_gmail.com>

Daniel
--
INdT - Manaus - Brazil

------=_Part_5573_6691821.1140614312726
Content-Type: text/x-patch; name=h2-irda-compile.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejzo3w8b
Content-Disposition: attachment; filename="h2-irda-compile.patch"

Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c
===================================================================
--- linux-omap-2.6.git-q.orig/arch/arm/mach-omap1/board-h2.c	2006-02-21 10:11:01.000000000 -0400
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c	2006-02-22 08:54:16.000000000 -0400
@@ -252,6 +252,8 @@ static int h2_transceiver_mode(struct de
 
 static struct omap_irda_config h2_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.transceiver_mode	= h2_transceiver_mode,
+	.irda_capable		= 0,
 };
 
 static struct resource h2_irda_resources[] = {
@@ -379,7 +381,7 @@ static void __init h2_init(void)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
 	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
 		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
-		h2_irda_data.transceiver_mode = h2_transceiver_mode;
+		h2_irda_data.irda_capable = 1;
 	}
 #endif
 
Index: linux-omap-2.6.git-q/include/asm-arm/arch-omap/irda.h
===================================================================
--- linux-omap-2.6.git-q.orig/include/asm-arm/arch-omap/irda.h	2006-02-22 09:00:30.000000000 -0400
+++ linux-omap-2.6.git-q/include/asm-arm/arch-omap/irda.h	2006-02-22 09:01:02.000000000 -0400
@@ -25,6 +25,8 @@ struct omap_irda_config {
 	 * having calls which can sleep in irda_set_speed.
 	 */
 	struct work_struct gpio_expa;
+	/* Very specific to H2 - success in obtain gpio */
+	int irda_capable;
 };
 
 #endif


------=_Part_5573_6691821.1140614312726
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_5573_6691821.1140614312726--
