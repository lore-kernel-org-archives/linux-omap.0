From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Fri, 27 Nov 2009 15:02:36 +0300
Message-ID: <48239d390911270402u4fe05d96s4d2a05e39919cb75@mail.gmail.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <873a43wzfm.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
	 <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
	 <87iqcyh5p5.fsf@deeprootsystems.com>
	 <48239d390911270202s3f6fcdbchaa7053bace5c36@mail.gmail.com>
	 <48239d390911270248se826f84r84d6b42cbd69344@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9217@dbde02.ent.ti.com>
	 <48239d390911270332tdf05c1lb5014e56cd3aa18b@mail.gmail.com>
	 <48239d390911270336r37e3b127i409ea5927aa9c505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:6127 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZK0MCb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:02:31 -0500
Received: by ey-out-2122.google.com with SMTP id 4so402513eyf.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 04:02:36 -0800 (PST)
In-Reply-To: <48239d390911270336r37e3b127i409ea5927aa9c505@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 27, 2009 at 2:36 PM, Sergey Lapin <slapinid@gmail.com> wrote:
>>
>> Alas, that's not because omap_chip_is() function fails
>> on these structures.
>>
>
> I mean during registration of power domains.
>

int pwrdm_register(struct powerdomain *pwrdm)
{
        unsigned long flags;
        int ret = -EINVAL;

        if (!pwrdm)
                return -EINVAL;

        if (!omap_chip_is(pwrdm->omap_chip))
                return -EINVAL;
returns -EINVAL for pwrdm_core (both of them), so I get panic later.
Since OMAP2525 vs  3515 were messed-up, I think there could be more
problems there.

diff --git a/arch/arm/plat-omap/include/plat/cpu.h
b/arch/arm/plat-omap/include/plat/cpu.h
index 2e17890..8b15789 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -393,11 +393,11 @@ IS_OMAP_TYPE(3517, 0x3517)
                                                (!omap3_has_iva()) &&   \
                                                (!omap3_has_sgx()))
 # define cpu_is_omap3515()             (cpu_is_omap3430() &&           \
-                                               (omap3_has_iva()) &&    \
-                                               (!omap3_has_sgx()))
+                                               (!omap3_has_iva()) &&   \
+                                               (omap3_has_sgx()))
 # define cpu_is_omap3525()             (cpu_is_omap3430() &&           \
-                                               (omap3_has_sgx()) &&    \
-                                               (!omap3_has_iva()))
+                                               (!omap3_has_sgx()) &&   \
+                                               (omap3_has_iva()))
 # define cpu_is_omap3530()             (cpu_is_omap3430())
 # define cpu_is_omap3505()             is_omap3505()
 # define cpu_is_omap3517()             is_omap3517()

since OMAP3525 has iva but misses sgx, and vice versa 3515 has sgx but
has no iva.
I missed this piece before, but just accidentally found it now. I
don't know if these are
related, but this doesn't fix my problem with core_pwrdm.

S.
