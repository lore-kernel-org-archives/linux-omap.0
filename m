From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Wed, 27 Jun 2012 20:33:05 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com> <20120627161745.GO3483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab2F0UdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:33:15 -0400
In-Reply-To: <20120627161745.GO3483@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 27, 2012 at 21:47:45, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120627 06:44]:
> > * Hiremath, Vaibhav <hvaibhav@ti.com> [120614 07:37]:
> > > On Mon, Jun 11, 2012 at 18:52:54, Hiremath, Vaibhav wrote:
> > > > As omap1 and omap2 will never be compiled together, due to
> > > > different compiler flags, so we can simply make
> > > > cpu_class_is_omap2() = true, for all non-omap1 platforms.
> > > > 
> > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > ---
> > > >  arch/arm/plat-omap/include/plat/cpu.h |    3 +--
> > > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > > 
> > > 
> > > Tony,
> > > 
> > > Ping???
> > 
> > Thanks applying into devel-am33xx branch.
> 
> Actually looks like this fails for the dynamic detection
> case with omap1_defconfig.. Looks like you did not build
> test your patch with omap1_defconfig? Please do it for
> every patch!
> 
> It seems we need something better though for multi zImage
> too, we can't really rely on CONFIG_ARCH_OMAP1 or
> CONFIG_ARCH_OMAP2PLUS here to determine anything.
> 
> Anyways, dropping this for now, let's try to come up
> with something better.
> 

Yes Tony, you are right I did not test omap1 for this patch. My bad...

How about something like, considering the fact that, omap_type() is the 
culprit here and is not applicable to omap1 at all. In case of omap1, we 
don't use omap_type() function.


diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 6a42558..5900a3d 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -42,7 +42,14 @@
 #define OMAP2_DEVICE_TYPE_GP           3
 #define OMAP2_DEVICE_TYPE_BAD          4

+#ifdef CONFIG_ARCH_OMAP2PLUS
 int omap_type(void);
+#else
+inline static int omap_type(void)
+{
+	/* Always return GP, since it is not being used anyway for omap1 */
+	return OMAP2_DEVICE_TYPE_GP;
+}
+#endif

 /*
  * omap_rev bits:


Thanks,
Vaibhav

