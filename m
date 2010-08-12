From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
Date: Thu, 12 Aug 2010 20:21:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E814726F@dbde02.ent.ti.com>
References: <1279725163-3481-1-git-send-email-premi@ti.com>
 <4C4710DB.6060901@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323B40084@dbde02.ent.ti.com>
 <4C481185.3090005@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7C764FD@dbde02.ent.ti.com>
 <4C4821E9.6030405@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7D0A002@dbde02.ent.ti.com>
 <4C482F8F.1090401@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7DA1AB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0HLOvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:51:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7CEpC27026745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 09:51:15 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7CEpBP1028891
	for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 20:21:12 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA1AB2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Monday, July 26, 2010 8:57 PM
> To: Menon, Nishanth
> Cc: Gadiyar, Anand; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
>
 
[snip] [snip]

> > >>>>>>> +#define ES_2_0		OMAP_REVBITS_10
> > >>>>>>> +#define ES_2_1		OMAP_REVBITS_20
> > >>>>>> makes sense to go to 2_2
> > >>>>>>> +#define ES_3_0		OMAP_REVBITS_30
> > >>>>>>> +#define ES_3_1		OMAP_REVBITS_40
> > >>>>>>> +#define ES_3_1_2	OMAP_REVBITS_50
> > >>>>>> 3_2?
> > >>>>> This may not make sense to add now as there are no
> > >>>>> 2.2 or 3.2 revisions of any OMAP3/4 silicon?
> > >>>>>
> > >>>> Agreed for 3 and 4, but considering this is 
> > >>>> arch/arm/plat-omap/include/plat/cpu.h, does it make sense in 
> > >>>> looking all 
> > >>>> OMAPs?
> > >>> In this case, the best option would be to prefix 
> > OMAP34X_/ OMAP36X_
> > >>> OMAP44X_ etc and define the ES revisions for each context.
> > >> doing that is gonna make the code real dirty looking. at the 
> > > 
> > > dirty?? How come? The intent is to increase readability.
> > > 
> > huh? should we start the old debate again?
> > Read this thread
> > http://marc.info/?l=linux-omap&m=127903615629407&w=2
> > 
> > >> very least 
> > >> mebbe bracket it in with #ifdef  with CONFIG_OMAP2PLUS?
> > > 
> > > What purpose does this #ifdef. The macro should/could be used
> > > quite generically.
> > 
> > Now we are back in a full circle -> if you would like to 
> > introduce the 
> > patch for ALL omap silicon, you might want to consider 2420 
> > and so on.. 
> > at the very least.
> > 
> > introducing this for OMAP3 and 4 alone does not allow logic 
> > to scale up.
> 
> [sp] The logic is only in the macros viz. cpu_rev_ge(), cpu_rev_le,
>      etc. The support for other omap silicons means having the
>      mapping of the revision bits to actual silicon version.
> 

[snip] [snip]

> > > 
> > > Here is a sample usage from one of the patch I am reworking
> > > for submission here:
> > > 
> > > @@ -488,7 +494,9 @@ void omap_sram_idle(void)
> > >         * of AUTO_CNT = 1 enabled. This takes care of 
> errata 1.142.
> > >         * Hence store/restore the SDRC_POWER register here.
> > >         */
> > > -       if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> > > +       if ((cpu_is_omap3630()
> > > +               || cpu_is_omap3505() || cpu_is_omap3517()
> > > +               || cpu_rev_ge(34xx, OMAP34XX_ES_3_0)) &&
> > cpu_rev_ge(34xx, OMAP34XX_ES_3_0) -> this is the cause of my 
> > comment on 
> > dirty code - redundant OMAP34XX_ in the macro when I do say 
> > it is 34xx 
> > in the first parameter!
> > 
> 
> [sp] Dirtiness is in eye of beholder :)
>      I did say earlier, that the patch is meant for increasing
>      readability. I could have overcome this by using lowercase
>      for revision macros.
> 
>      I did think of "exploiting" enums; but had been avoiding
>      the need for adding new data structures. It, however, can
>      be ugly!
> 

[snip] [snip]

Below is an attempt to introduce enums to take care of uppercase
bit definitions vs lowercase function definitions. Of course it
is not a formal patch and I have tried to limit the patch only
for additions; not for deletions that can result due from the
enums declares below.

The revisions can now be done as:
 - cpu_rev_ge(omap34xx, es3_0)
 - cpu_rev_eq(am3505, es1_0)
 - etc.

Also, I am using revision bit values instead of another macro
representing them (e.g. OMAP_REVISION_BITS_10). Given the
structure below, I felt use of actual bit values is better.

Nishanth:
There may be copy-paste errors in the actual revision definitions
(let us not deviate into those for now).

~sanjeev


diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e2ae53..36a7047
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -467,4 +469,103 @@ OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 
+/*
+ * Enumerate the CPU revisions for easy comparison against the
+ * revision bits specific for each processor family.
+ */
+#define DECLARE_CPU_REV(cpu)	enum revs_ ##cpu
+#define CPU_REV(cpu,rev,bits)	cpu## _ ##rev = bits
+
+DECLARE_CPU_REV(omap242x) {
+	CPU_REV(omap242x, es1_0, 0x00),
+	CPU_REV(omap242x, es2_0, 0x01),
+} ;
+
+DECLARE_CPU_REV(omap243x) {
+	CPU_REV(omap243x, es1_0, 0x00),
+} ;
+
+DECLARE_CPU_REV(omap34xx) {
+	CPU_REV(omap34xx, es1_0, 0x00),
+	CPU_REV(omap34xx, es2_0, 0x01),
+	CPU_REV(omap34xx, es2_1, 0x02),
+	CPU_REV(omap34xx, es3_0, 0x03),
+	CPU_REV(omap34xx, es3_1, 0x04),
+	CPU_REV(omap34xx, es3_1_2, 0x05),
+} ;
+
+DECLARE_CPU_REV(omap36xx) {
+	CPU_REV(omap36xx, es1_0, 0x00),
+	CPU_REV(omap36xx, es1_1, 0x01),
+} ;
+
+DECLARE_CPU_REV(omap3503) {
+	CPU_REV(omap3503, es1_0, 0x00),
+	CPU_REV(omap3503, es2_0, 0x01),
+	CPU_REV(omap3503, es2_1, 0x02),
+	CPU_REV(omap3503, es3_0, 0x03),
+	CPU_REV(omap3503, es3_1, 0x04),
+} ;
+
+DECLARE_CPU_REV(omap3515) {
+	CPU_REV(omap3515, es1_0, 0x00),
+	CPU_REV(omap3515, es2_0, 0x01),
+	CPU_REV(omap3515, es2_1, 0x02),
+	CPU_REV(omap3515, es3_0, 0x03),
+	CPU_REV(omap3515, es3_1, 0x04),
+} ;
+
+DECLARE_CPU_REV(omap3525) {
+	CPU_REV(omap3525, es1_0, 0x00),
+	CPU_REV(omap3525, es2_0, 0x01),
+	CPU_REV(omap3525, es2_1, 0x02),
+	CPU_REV(omap3525, es3_0, 0x03),
+	CPU_REV(omap3525, es3_1, 0x04),
+} ;
+
+DECLARE_CPU_REV(omap3530) {
+	CPU_REV(omap3530, es1_0, 0x00),
+	CPU_REV(omap3530, es2_0, 0x01),
+	CPU_REV(omap3530, es2_1, 0x02),
+	CPU_REV(omap3530, es3_0, 0x03),
+	CPU_REV(omap3530, es3_1, 0x04),
+} ;
+
+DECLARE_CPU_REV(am3505) {
+	CPU_REV(am3505, es1_0, 0x00),
+	CPU_REV(am3505, es1_1, 0x01),
+} ;
+
+DECLARE_CPU_REV(am3517) {
+	CPU_REV(am3517, es1_0, 0x00),
+	CPU_REV(am3517, es1_1, 0x01),
+} ;
+
+/*
+ * Macros to evaluate CPU revision
+ */
+#define cpu_rev_lt(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() < cpu## _ ##rev)) ? 1 : 0)
+
+#define cpu_rev_le(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() <= cpu## _ ##rev)) ? 1 : 0)
+
+#define cpu_rev_eq(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() == cpu## _ ##rev)) ? 1 : 0)
+
+#define cpu_rev_ne(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() != cpu## _ ##rev)) ? 1 : 0)
+
+#define cpu_rev_ge(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() >= cpu## _ ##rev)) ? 1 : 0)
+
+#define cpu_rev_gt(cpu,rev)	\
+	((cpu_is_omap ##cpu()	\
+		&& (GET_OMAP_REVISION() > cpu## _ ##rev)) ? 1 : 0)
+
 #endif
