From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/12] omap3evm: Add board revision function, v2
Date: Wed, 18 Nov 2009 14:47:47 -0800
Message-ID: <20091118224746.GU29266@atomide.com>
References: <20091116232435.24892.81547.stgit@localhost>
	<20091116232734.24892.33820.stgit@localhost>
	<19F8576C6E063C45BE387C64729E7394043702B5B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394043702B5B5@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Hiremath, Vaibhav <hvaibhav@ti.com> [091116 19:56]:
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Tuesday, November 17, 2009 4:58 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Gupta, Ajay Kumar; linux-omap@vger.kernel.org; Hiremath,
> > Vaibhav; Premi, Sanjeev
> > Subject: [PATCH 05/12] omap3evm: Add board revision function
> > 
> > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > 
> > Added function to differentiate between the OMAP3EVM revisions. The
> > chip-id of the ethernet PHY is being used for this purpose.
> > 
> > Rev A to D : 0x01150000
> > Rev >= E   : 0x92200000
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c    |   33
> > +++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/board.h |   18 +++++++++++++++++
> >  2 files changed, 51 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> > index 1edf06a..6bb9a37 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -46,9 +46,40 @@
> > 
> >  #define OMAP3EVM_ETHR_START	0x2c000000
> >  #define OMAP3EVM_ETHR_SIZE	1024
> > +#define OMAP3EVM_ETHR_ID_REV	0x50
> >  #define OMAP3EVM_ETHR_GPIO_IRQ	176
> >  #define OMAP3EVM_SMC911X_CS	5
> > 
> > +static u8 omap3_evm_version;
> > +
> > +u8 get_omap3_evm_rev(void)
> > +{
> > +	return omap3_evm_version;
> > +}
> > +EXPORT_SYMBOL(get_omap3_evm_rev);
> > +
> > +static void __init omap3_evm_get_revision(void)
> > +{
> > +	void __iomem *ioaddr;
> > +	unsigned int smsc_id;
> > +
> > +	/* Ethernet PHY ID is stored at ID_REV register */
> > +	ioaddr = ioremap_nocache(OMAP3EVM_ETHR_START, SZ_1K);
> [Hiremath, Vaibhav] I think we should check for the return value.

Good catch, updated version below.

Tony


--qDbXVdCdHGoSgWSk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap3evm-revision-v2.patch"

>From f62482b652928c06c9ecfe546f03532276a6f5e6 Mon Sep 17 00:00:00 2001
From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Date: Fri, 13 Nov 2009 17:37:30 -0800
Subject: [PATCH] omap3evm: Add board revision function

Added function to differentiate between the OMAP3EVM revisions. The
chip-id of the ethernet PHY is being used for this purpose.

Rev A to D : 0x01150000
Rev >= E   : 0x92200000

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1edf06a..149d45c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -46,9 +46,42 @@
 
 #define OMAP3EVM_ETHR_START	0x2c000000
 #define OMAP3EVM_ETHR_SIZE	1024
+#define OMAP3EVM_ETHR_ID_REV	0x50
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
 #define OMAP3EVM_SMC911X_CS	5
 
+static u8 omap3_evm_version;
+
+u8 get_omap3_evm_rev(void)
+{
+	return omap3_evm_version;
+}
+EXPORT_SYMBOL(get_omap3_evm_rev);
+
+static void __init omap3_evm_get_revision(void)
+{
+	void __iomem *ioaddr;
+	unsigned int smsc_id;
+
+	/* Ethernet PHY ID is stored at ID_REV register */
+	ioaddr = ioremap_nocache(OMAP3EVM_ETHR_START, SZ_1K);
+	if (!ioaddr)
+		return;
+	smsc_id = readl(ioaddr + OMAP3EVM_ETHR_ID_REV) & 0xFFFF0000;
+	iounmap(ioaddr);
+
+	switch (smsc_id) {
+	/*SMSC9115 chipset*/
+	case 0x01150000:
+		omap3_evm_version = OMAP3EVM_BOARD_GEN_1;
+		break;
+	/*SMSC 9220 chipset*/
+	case 0x92200000:
+	default:
+		omap3_evm_version = OMAP3EVM_BOARD_GEN_2;
+	}
+}
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start	= OMAP3EVM_ETHR_START,
@@ -321,6 +354,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap3_evm_init(void)
 {
+	omap3_evm_get_revision();
+
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index c4fc69f..abb17b6 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -14,6 +14,18 @@
 
 #include <plat/gpio-switch.h>
 
+/*
+ * OMAP35x EVM revision
+ * Run time detection of EVM revision is done by reading Ethernet
+ * PHY ID -
+ *	GEN_1	= 0x01150000
+ *	GEN_2	= 0x92200000
+ */
+enum {
+	OMAP3EVM_BOARD_GEN_1 = 0,	/* EVM Rev between  A - D */
+	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
+};
+
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_LCD		0x4f05
@@ -157,4 +169,10 @@ extern int omap_board_config_size;
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
+/* OMAP3EVM revision */
+#if defined(CONFIG_MACH_OMAP3EVM)
+u8 get_omap3_evm_rev(void);
+#else
+#define get_omap3_evm_rev() (-EINVAL)
+#endif
 #endif

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--qDbXVdCdHGoSgWSk--
