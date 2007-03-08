From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] Move N800 specific OneNand setup to N800 platform file,
	was: Basic N800 support
Date: Thu, 8 Mar 2007 10:18:32 +0900
Message-ID: <004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070302164855.GA313@angel.research.nokia.com>
	<45EA99D0.8010103@googlemail.com>
	<20070307115754.GH21093@atomide.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0043_01C7616B.2ACCD390"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <20070307115754.GH21093@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, 'Dirk Behme' <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0043_01C7616B.2ACCD390
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit

Hi

> 
> * Dirk Behme <dirk.behme@googlemail.com> [070304 02:11]:
> > Jarkko Lavinen wrote:
> > >>If you don't need async mode settings, it also don't need it.
> > >
> > >Yes. It is obvious. Removed async part. New patch attached.
> > 
> > Are there any dependencies to apply this patch I missed? I tried to 
> > apply it on top of  01-onenand.patch posted by Tony [1] but got 
> > rejects.
> > 
> > If not, sligthly modified patch that cleanly applies on top 
> of [1] in 
> > attachment. I additionally removed duplication of 
> omap2_onenand_readw 
> > and writew. Can you please test if it is still okay? ;)
> 
> I've pushed Jarkko's onenand patches as two parts:
> 
> omap-drivers: onenand support for omap2 that can be sent to mtd list

I will push it mtd list

> omap-upstream: onenand board specific support for n800
> 
> Can you all please verify that they're OK?

There's one compiler bug related with interrupt handler.

> 
> Kyungmin & Dirk, do you have some additional patches on top 
> of Jarkko's patches?
> 

Please don't patch [1]. If this patch is applied, we have to add all
platform files to add onenand_readw, onenand_writew.

Now apollon board can use it without modification of omap2.c

Thank you,
Kyungmin Park

1. http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009210.
html

------=_NextPart_000_0043_01C7616B.2ACCD390
Content-Type: text/plain;
	name="ARM-OMAP-Fix-old-interrupt-handler-function-in-omap2-onenand.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ARM-OMAP-Fix-old-interrupt-handler-function-in-omap2-onenand.txt"

>From d4978e6cfbb4824391d568051bd0027622cac729 Mon Sep 17 00:00:00 2001=0A=
From: Kyungmin Park <kyungmin.park@samsung.com>=0A=
Date: Thu, 8 Mar 2007 10:05:01 +0900=0A=
Subject: [PATCH] ARM: OMAP: Fix old interrupt handler function in =
omap2-onenand=0A=
=0A=
Fix old interrupt handler function in omap2-onenand=0A=
=0A=
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>=0A=
---=0A=
 drivers/mtd/onenand/omap2.c |    3 +--=0A=
 1 files changed, 1 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c=0A=
index bbc9beb..96fcb5f 100644=0A=
--- a/drivers/mtd/onenand/omap2.c=0A=
+++ b/drivers/mtd/onenand/omap2.c=0A=
@@ -80,8 +80,7 @@ static void omap2_onenand_dma_cb(int lch, u16 =
ch_status, void *data)=0A=
 	complete(&info->dma_done);=0A=
 }=0A=
 =0A=
-static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id,=0A=
-					   struct pt_regs *regs)=0A=
+static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)=0A=
 {=0A=
 	struct omap2_onenand *info =3D dev_id;=0A=
 =0A=
-- =0A=
1.4.4.2=0A=
=0A=

------=_NextPart_000_0043_01C7616B.2ACCD390
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0043_01C7616B.2ACCD390--
