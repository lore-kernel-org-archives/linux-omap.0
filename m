From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
Date: Tue, 11 Aug 2009 22:39:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8D9BD87@dbde02.ent.ti.com>
References: <1249554967-20394-1-git-send-email-premi@ti.com>
 <20090806110359.GD2358@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8C80741@dbde02.ent.ti.com>
 <20090806115025.GG2358@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8C80860@dbde02.ent.ti.com>
 <87fxc56lfz.fsf@deeprootsystems.com> <20090807082322.GZ2358@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8D27B50@dbde02.ent.ti.com>
 <20090811080241.GO1938@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8D28250@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbZHKRKM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 13:10:12 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D8D28250@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Tuesday, August 11, 2009 5:22 PM
> To: Tony Lindgren
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
>
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Tuesday, August 11, 2009 1:33 PM
> > To: Premi, Sanjeev
> > Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
> >
> > Hi,
> >
> > * Premi, Sanjeev <premi@ti.com> [090810 20:15]:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > > Sent: Friday, August 07, 2009 1:53 PM
> > > > To: Kevin Hilman
> > > > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
> > > >
> > >
> > > <snip>--<snip>
> > >
> > > > >
> > > > > Adding conditionals like
> > > > >
> > > > >   if (omap3_has_iva2())
> > > > >      ...
> > > > >
> > > > > and
> > > > >
> > > > >   if (omap3_has_sgx())
> > > > >      ...
> > > > >
> > > > > rather than having a long list of cpu_is checks that have
> > > > to be changed
> > > > > each time a new SoC comes out.
> > > >
> > > > Agreed.
> > > >
> > > > Tony
> > > >
> > > >
> > >
> > > Tony, Kevin,
> > >
> > > Here is a work in progress patch implementing the conditionals.
> > >
> > > I am looking for your suggestions on these:
> > > 1) The detection of ES2.0 is different between OMAP3530 and
> > OMAP3430.
> > >    For 3430 ES2.0, (idcode >> 28) == 0x0
> > >    For 3530 ES2.0, (idcode >> 28) == 0x1
> > >
> > >    What can be easy way to make this distinction?
> >
> > Hmm, looks like in switch (rev) case 1 is not used, so I guess you
> > can use that? Hmm, might be worth checking if the 3530
> ES2.0 is really
> > based on the 3430 ES2.1 core though..
> >
> [sp] Yes, it is.
>
> >
> > > 2) How do we handle the power domain differences between OMAP34x
> > >    and the new OMAP3517 and OMAP05 devices. The hawkeye is
> > different,
> > >    but, would it make sense to omap_revision to be like:
> > >    0x34050034, 0x34170034 - when we reuse the 34xx class.
> >
> > Can't you use the bits documented in cpu.h:
>
> [sp] I was trying to use these bit only; but was trying to avoid
>      multiple declarations for each silicon rev like this:
> #define OMAP3430_REV_ES1_0    0x34300034
> #define OMAP3430_REV_ES2_0    0x34301034
> #define OMAP3430_REV_ES2_1    0x34302034
> #define OMAP3430_REV_ES3_0    0x34303034
> #define OMAP3430_REV_ES3_1    0x34304034
>
>      In my earlier patches, I had tried using masks for the
> ES revision;
>      but the current code uses these values in direct assignment.
>
>       omap_revision = OMAP3430_REV_ES3_1;
>
>      If we could use a mask for omap_revision bits, I believe
>      we won't need to multiple definitions for each si revision
>      for all the variants - 3505, 3517, and so on.
> >
> > /*
> >  * omap_rev bits:
> >  * CPU id bits      (0730, 1510, 1710, 2422...)     [31:16]
> >  * CPU revision     (See _REV_ defined in cpu.h)    [15:08]
> >  * CPU class bits (15xx, 16xx, 24xx, 34xx...)       [07:00]
> >  */
> > unsigned int omap_rev(void);
> >
> > Basically 0x3505??34, 0x3517??34 and so on? The
> cpu_is_omap34xx() is
> > omap_rev() & 0xff.
> >
> >
> > > 3) Currently, the macros like OMAP3430_REV_ES1_0 are defined to
> > >    be whole numbers. I am trying to change them to something like:
> > >
> > > #define OMAP34XX_REV(type,rev)  (OMAP34XX_CLASS & (type <<
> > 16) & (rev << 12))
> > >
> > > And use as (if needed):
> > >
> > > #define OMAP3430_REV_ES3_1      OMAP34XX_REV(0x30, 0x4)
> > >
> > > #define OMAP3403_REV_ES3_1      OMAP34XX_REV(0x03, 0x4)
> > >
> > >    What is your view?
> > >
> > >    In fact, wouldn't it be better if we tested for si rev
> > independent
> > >    from si type?
> >
> > Well cpu_is_omap34xx() should be enough in most places, but I
> > guess here you'd
> > want to test for the exact revision, and just define:
> > #define OMAP3505_REV_ES?_?  0x3505??34
>
> [sp] This is the multiplicity on definitions I am trying to avoid
>      as same revision will be valid across OMAP3505 and OMAP3517
>      in this case. Holds good even for 3503, 3515, 3525 and 3530.
>
> >
> >
> > > 4) These macros are, possibly, duplicating the data in
> > omap_revision:
> > >
> > > #define CHIP_IS_OMAP3430ES3_0             (1 << 5)
> > > #define CHIP_IS_OMAP3430ES3_1             (1 << 6)
> > >
> > >    But, might be used for faster checking. Is this
> > duplication necessary?
> >
> > These are currently needed for the clock framework,
> > eventually we should
> > unify them..
> >
> >
> > > 5) Assuming that we are able to maintain current, macros,
> would this
> > >    help in reducing the duplication?
> > >
> > > struct omap_id {
> > >   u16     id;             /* e.g. 0x3430, 0x3517, ... */
> > >   u8      class;  /* 34x */
> > >   u8      subclass;   /* 0x30, 0x03, 0x05, 0x15, 0x17 ... */
> > >   u8      rev;        /* 0x10 (for ES 1.0), 0x21 (for
> > ES2.1) etc. */
> > >                           /* use nibble as decimal separator */
> > > }
> >
> > Yeah we could do something like that as a separate patch eventually.
> >
> > Few more comments inlined below.
> >
> > >
> > > I have tried many approaches, before sending this mail,
> > > so there might be few duplications in the code below.
> > > The cpu_is_35xx() macros are also incomplete for now.
> > >
> > > Best regards,
> > > Sanjeev
> > >
> > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > index a98201c..f17d4db 100644
> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -25,9 +25,47 @@
> > >  #include <mach/control.h>
> > >  #include <mach/cpu.h>
> > >
> > > +#define OMAP3_CONTROL_OMAP_STATUS        0x044c
> > > +
> > > +#define OMAP3_SGX_SHIFT                  13
> > > +#define OMAP3_SGX_MASK                   (3 << OMAP3_SGX_SHIFT)
> > > +#define          FEAT_SGX_FULL           0
> > > +#define          FEAT_SGX_HALF           1
> > > +#define          FEAT_SGX_NONE           2
> > > +
> > > +#define OMAP3_IVA_SHIFT                  12
> > > +#define OMAP3_IVA_MASK                   (1 << OMAP3_SGX_SHIFT)
> > > +#define          FEAT_IVA                0
> > > +#define          FEAT_IVA_NONE           1
> > > +
> > > +#define OMAP3_L2CACHE_SHIFT              10
> > > +#define OMAP3_L2CACHE_MASK               (3 <<
> OMAP3_L2CACHE_SHIFT)
> > > +#define          FEAT_L2CACHE_0KB        0
> > > +#define          FEAT_L2CACHE_64KB       1
> > > +#define          FEAT_L2CACHE_128KB      2
> > > +#define          FEAT_L2CACHE_256KB      3
> > > +
> > > +#define OMAP3_ISP_SHIFT                  5
> > > +#define OMAP3_ISP_MASK                   (1<< OMAP3_ISP_SHIFT)
> > > +#define          FEAT_ISP                0
> > > +#define          FEAT_ISP_NONE           1
> > > +
> > > +#define OMAP3_NEON_SHIFT         4
> > > +#define OMAP3_NEON_MASK                  (1<< OMAP3_NEON_SHIFT)
> > > +#define          FEAT_NEON               0
> > > +#define          FEAT_NEON_NONE          1
> > > +
> > >  static struct omap_chip_id omap_chip;
> > >  static unsigned int omap_revision;
> > >
> > > +struct omap_feature {
> > > + u8 avail;
> > > + u32 attrib;
> > > +};
> > > +
> > > +static struct omap_feature feat_sgx;
> > > +static struct omap_feature feat_iva;
> > > +static struct omap_feature feat_l2cache;
> >
> > We should probably just have static u32 omap_feat that is a bitmask
> > for the various features.
> >
> > Then that could be moved to live in struct omap_id eventually.
> >
> >
> > >  unsigned int omap_rev(void)
> > >  {
> > > @@ -35,6 +73,24 @@ unsigned int omap_rev(void)
> > >  }
> > >  EXPORT_SYMBOL(omap_rev);
> > >
> > > +unsigned int omap3_has_sgx(void)
> > > +{
> > > + return feat_sgx.avail;
> > > +}
> > > +EXPORT_SYMBOL(omap3_has_sgx);
> > > +
> > > +unsigned int omap3_has_iva(void)
> > > +{
> > > + return feat_iva.avail;
> > > +}
> > > +EXPORT_SYMBOL(omap3_has_iva);
> > > +
> > > +unsigned int omap3_has_l2cache(void)
> > > +{
> > > + return feat_l2cache.avail;
> > > +}
> > > +EXPORT_SYMBOL(omap3_has_l2cache);
> >
> > And then these become something like return omap_feat &
> OMAP_HAS_IVA2.
> >
>
> [sp] I will try to get an patch just for feature testing for review by
>      today evening. Based on the comments, I will make formal
> submission
>      tomorrow.
>
> Best regards,
> Sanjeev
>
> > You should make the feature checking a separate patch, then
> the second
> > patch becomes simple for adding support for detecting 34xx properly.
> >
> > Regards,
> >
> > Tony
> >
> >

Tony,

Here are relevant sections from the feature patch for quick look:
(it is not a clean patch but just to highlight changes)

Best regard,
Sanjeev

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a98201c..907770d 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -25,9 +25,49 @@
 #include <mach/control.h>
 #include <mach/cpu.h>
 +/*
+ * OMAP3 features
+ */
+#define OMAP3_CONTROL_OMAP_STATUS      0x044c
+
+#define OMAP3_SGX_SHIFT                        13
+#define OMAP3_SGX_MASK                 (3 << OMAP3_SGX_SHIFT)
+#define                FEAT_SGX_FULL           0
+#define                FEAT_SGX_HALF           1
+#define                FEAT_SGX_NONE           2
+
+#define OMAP3_IVA_SHIFT                        12
+#define OMAP3_IVA_MASK                 (1 << OMAP3_SGX_SHIFT)
+#define                FEAT_IVA                0
+#define                FEAT_IVA_NONE           1
+
+#define OMAP3_L2CACHE_SHIFT            10
+#define OMAP3_L2CACHE_MASK             (3 << OMAP3_L2CACHE_SHIFT)
+#define                FEAT_L2CACHE_0KB        0
+#define                FEAT_L2CACHE_64KB       1
+#define                FEAT_L2CACHE_128KB      2
+#define                FEAT_L2CACHE_256KB      3
+
+#define OMAP3_ISP_SHIFT                        5
+#define OMAP3_ISP_MASK                 (1<< OMAP3_ISP_SHIFT)
+#define                FEAT_ISP                0
+#define                FEAT_ISP_NONE           1
+
+#define OMAP3_NEON_SHIFT               4
+#define OMAP3_NEON_MASK                        (1<< OMAP3_NEON_SHIFT)
+#define                FEAT_NEON               0
+#define                FEAT_NEON_NONE          1
+
+
+#define OMAP_HAS_L2CACHE               1
+#define OMAP_HAS_IVA                   (1 << 1)
+#define OMAP_HAS_SGX                   (1 << 2)
+#define OMAP_HAS_NEON                  (1 << 3)
+#define OMAP_HAS_ISP                   (1 << 4)
+
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
-
+static u32 omap_features ;

 unsigned int omap_rev(void)
 {
@@ -35,6 +75,37 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);

+unsigned int omap3_has_l2cache(void)
+{
+       return (omap_features & OMAP_HAS_L2CACHE);
+}
+EXPORT_SYMBOL(omap3_has_l2cache);
+
+unsigned int omap3_has_sgx(void)
+{
+       return (omap_features & OMAP_HAS_SGX);
+}
+EXPORT_SYMBOL(omap3_has_sgx);
+
+unsigned int omap3_has_iva(void)
+{
+       return (omap_features & OMAP_HAS_IVA);
+}
+EXPORT_SYMBOL(omap3_has_iva);
+
+unsigned int omap3_has_neon(void)
+{
+       return (omap_features & OMAP_HAS_NEON);
+}
+EXPORT_SYMBOL(omap3_has_neon);
+
+unsigned int omap3_has_isp(void)
+{
+       return (omap_features & OMAP_HAS_ISP);
+}
+EXPORT_SYMBOL(omap3_has_isp);
+
+
 /**
  * omap_chip_is - test whether currently running OMAP matches a chip type
  * @oc: omap_chip_t to test against


..... And later on....

+void __init omap3_check_features(void)
+{
+       u32 status, temp;
+
+       omap_features = 0;
+
+       status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
+
+     /* TBD: Make these checks as macro as SHOW_FEATURE below */
+
+       /* Check for L2 Cache */
+       temp = ((status & OMAP3_L2CACHE_MASK) >> OMAP3_L2CACHE_SHIFT) ;
+       if (temp != FEAT_L2CACHE_0KB)
+               omap_features |= OMAP_HAS_L2CACHE;
+
+       temp = ((status & OMAP3_IVA_MASK) >> OMAP3_IVA_SHIFT) ;
+       if (temp != FEAT_IVA_NONE)
+               omap_features |= OMAP_HAS_IVA;
+
+       temp = ((status & OMAP3_SGX_MASK) >> OMAP3_SGX_SHIFT) ;
+       if (temp != FEAT_SGX_NONE) {
+               omap_features |= OMAP_HAS_SGX;
+
+       temp = ((status & OMAP3_NEON_MASK) >> OMAP3_NEON_SHIFT) ;
+       if (temp != FEAT_NEON_NONE) {
+               omap_features |= OMAP_HAS_NEON;
+
+       temp = ((status & OMAP3_ISP_MASK) >> OMAP3_ISP_SHIFT) ;
+       if (temp != FEAT_ISP_NONE)
+               omap_features |= OMAP_HAS_NEON;
+}
+
+/* In few cases, the identification of the silicon depends upon the
+ * features available. So, omap3_check_features() will need to be
+ * called before omap3_check_revision().
+ *
+ * If the information on the silicon, its revision and features are
+ * printed in the current flow, the features will be printed before
+ * the Si id. Ideally, it should be other way around.
+ *
+ * This function has been created only to get the prints in right order.
+ * Additional info eg. Size of l2cache etc can be added later as well.
+ *
+ * THIS COMMENT IS ONLY FOR EXPLANATION. WILL NOT BE ADDED IN ACTUAL PATCH
+ *
+ */
+#define SHOW_FEATURE(feat)     \
+       if (omap3_has_ ##feat()) {              \
+               pr_info (" - "#feat" : Y");             \
+       } else {                                        \
+               pr_info (" - "#feat" : N");             \
+       }
+
+void __init omap3_cpuinfo(void)
+{
+       pr_info("OMAP%x", (omap_revision >> 16));
+
+       SHOW_FEATURE(l2cache);
+       SHOW_FEATURE(iva);
+       SHOW_FEATURE(sgx);
+       SHOW_FEATURE(neon);
+       SHOW_FEATURE(isp);
 }

..... Further down....

@@ -223,8 +408,12 @@ void __init omap2_check_revision(void)
         */
        if (cpu_is_omap24xx())
                omap24xx_check_revision();
-       else if (cpu_is_omap34xx())
-               omap34xx_check_revision();
+       else if (cpu_is_omap34xx()) {
+               omap3_check_features();
+               omap3_check_revision();
+               omap3_cpuinfo();
+       }


> > > +
> > >  /**
> > >   * omap_chip_is - test whether currently running OMAP
> > matches a chip type
> > >   * @oc: omap_chip_t to test against
> > > @@ -155,12 +211,32 @@ void __init omap24xx_check_revision(void)
> > >   pr_info("\n");
> > >  }
> > >
> > > -void __init omap34xx_check_revision(void)
> > > +void __init omap3_check_features(void)
> > > +{
> > > + u32 status;
> > > +
> > > + status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
> > > +
> > > + /* Check for SGX */
> > > + feat_sgx.attrib = ((status & OMAP3_SGX_MASK) >>
> > OMAP3_SGX_SHIFT) ;
> > > + feat_sgx.avail  = (feat_sgx.attrib == FEAT_SGX_NONE) ? 0 : 1 ;
> > > +
> > > + /* Check for IVA */
> > > + feat_iva.attrib = ((status & OMAP3_IVA_MASK) >>
> > OMAP3_IVA_SHIFT) ;
> > > + feat_iva.avail = (feat_iva.attrib == FEAT_IVA_NONE) ? 0 : 1 ;
> > > +
> > > + /* Check for L2 Cache */
> > > + feat_l2cache.attrib = ((status & OMAP3_L2CACHE_MASK) >> \
> > > +                                 OMAP3_L2CACHE_SHIFT) ;
> > > + feat_l2cache.avail = (feat_l2cache.attrib ==
> > FEAT_L2CACHE_0KB) ? 0 : 1 ;
> > > +}
> > > +
> > > +void __init omap3_check_revision(void)
> > >  {
> > >   u32 cpuid, idcode;
> > >   u16 hawkeye;
> > >   u8 rev;
> > > - char *rev_name = "ES1.0";
> > > + char cpu_name[16]= "", rev_name[16] = "", feat_name[32] = "";
> > >
> > >   /*
> > >    * We cannot access revision registers on ES1.0.
> > > @@ -187,29 +263,50 @@ void __init omap34xx_check_revision(void)
> > >           switch (rev) {
> > >           case 0:
> > >                   omap_revision = OMAP3430_REV_ES2_0;
> > > -                 rev_name = "ES2.0";
> > > +                 strcat (rev_name, "ES2.0");
> > >                   break;
> > >           case 2:
> > >                   omap_revision = OMAP3430_REV_ES2_1;
> > > -                 rev_name = "ES2.1";
> > > +                 strcat (rev_name, "ES2.1");
> > >                   break;
> > >           case 3:
> > >                   omap_revision = OMAP3430_REV_ES3_0;
> > > -                 rev_name = "ES3.0";
> > > +                 strcat (rev_name, "ES3.0");
> > >                   break;
> > >           case 4:
> > >                   omap_revision = OMAP3430_REV_ES3_1;
> > > -                 rev_name = "ES3.1";
> > > +                 strcat (rev_name, "ES3.1");
> > >                   break;
> > >           default:
> > >                   /* Use the latest known revision as default */
> > >                   omap_revision = OMAP3430_REV_ES3_1;
> > > -                 rev_name = "Unknown revision\n";
> > > +                 strcat (rev_name, "Unknown revision");
> > > +         }
> > > + }
> > > + else if (hawkeye == 0xb868) {
> > > +         if (omap3_has_sgx()) {
> > > +                 omap_revision = OMAP35XX_REV(0x17, 0x0);
> > > +         }
> > > +         else {
> > > +                 omap_revision = OMAP35XX_REV(0x05, 0x0);
> > >           }
> > >   }
> > >
> > >  out:
> > > - pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> > > + if (omap3_has_iva() && omap3_has_sgx()) {
> > > +         strcat(cpu_name, "3430/3530");
> > > + }
> > > + else if (omap3_has_sgx()) {
> > > +         strcat(cpu_name, "3525");
> > > + }
> > > + else if (omap3_has_iva()) {
> > > +         strcat(cpu_name, "3515");
> > > + }
> > > + else {
> > > +         strcat(cpu_name, "3505");
> > > + }
> > > +
> > > + pr_info("OMAP%s %s\n", cpu_name, rev_name);
> > >  }
> > >
> > >  /*
> > > @@ -223,8 +320,10 @@ void __init omap2_check_revision(void)
> > >    */
> > >   if (cpu_is_omap24xx())
> > >           omap24xx_check_revision();
> > > - else if (cpu_is_omap34xx())
> > > -         omap34xx_check_revision();
> > > + else if (cpu_is_omap34xx()) {
> > > +         omap3_check_features();
> > > +         omap3_check_revision();
> > > + }
> > >   else if (cpu_is_omap44xx()) {
> > >           printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
> > >           return;
> > > diff --git a/arch/arm/plat-omap/include/mach/cpu.h
> > b/arch/arm/plat-omap/include/mach/cpu.h
> > > index 285eaa3..e9d6bc2 100644
> > > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > > @@ -363,6 +363,23 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #if defined(CONFIG_ARCH_OMAP34XX)
> > >  # undef cpu_is_omap3430
> > >  # define cpu_is_omap3430()               is_omap3430()
> > > +
> > > +# undef cpu_is_omap3503
> > > +# undef cpu_is_omap3515
> > > +# undef cpu_is_omap3525
> > > +# undef cpu_is_omap3530
> > > +
> > > +# undef cpu_is_omap3505
> > > +# undef cpu_is_omap3517
> > > +
> > > +# define cpu_is_omap3503()               (!omap3_has_iva() &&
> > !omap3_has_sgx())
> > > +# define cpu_is_omap3515()               (!omap3_has_iva() &&
> > !omap3_has_sgx())
> > > +# define cpu_is_omap3525()               (!omap3_has_iva() &&
> > !omap3_has_sgx())
> > > +# define cpu_is_omap3530()               (omap3_has_iva() &&
> > omap3_has_sgx())
> > > +/* How to make these different from the ones above */
> > > +# define cpu_is_omap3505()               (!omap3_has_iva() &&
> > !omap3_has_sgx())
> > > +# define cpu_is_omap3517()               (!omap3_has_iva() &&
> > omap3_has_sgx())
> > > +
> > >  #endif
> > >
> > >  # if defined(CONFIG_ARCH_OMAP4)
> > > @@ -396,6 +413,12 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #define OMAP3430_REV_ES3_0       0x34303034
> > >  #define OMAP3430_REV_ES3_1       0x34304034
> > >
> > > +
> > > +#define OMAP35XX_CLASS           0x35000035
> > > +
> > > +
> > > +#define OMAP35XX_REV(type,rev)   (OMAP35XX_CLASS & (type
> > << 16) & (rev << 12))
> > > +
> > >  #define OMAP443X_CLASS           0x44300034
> > >
> > >  /*
> >
> > --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
