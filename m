From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Mon, 26 Jan 2009 15:23:42 -0800
Message-ID: <200901261523.42769.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901161431.00469.david-b@pacbell.net> <20090118113324.GC7976@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:38372 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752303AbZAZXXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jan 2009 18:23:45 -0500
In-Reply-To: <20090118113324.GC7976@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: me@felipebalbi.com, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sunday 18 January 2009, Tony Lindgren wrote:
>=20
> > > #if =A0 =A0 !defined(CONFIG_ARCH_OMAP730) && \
> > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP15XX) && \
> > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP16XX) && \
> > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP24XX) && \
> > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP34XX)
> > > #error "Power management for this processor not implemented yet"
> > > #endif
> >=20
> > I didn't realize anyone outside of TI had their hands
> > on OMAP4 chips yet. =A0:)
>=20
> Might be worth looking what it would take to make dummy CONFIG_PM
> compile in mainline for mach-omap2.

This (against mainline) makes build+link work ...


---
 arch/arm/plat-omap/include/mach/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -108,7 +108,7 @@
 	!defined(CONFIG_ARCH_OMAP15XX) && \
 	!defined(CONFIG_ARCH_OMAP16XX) && \
 	!defined(CONFIG_ARCH_OMAP24XX)
-#error "Power management for this processor not implemented yet"
+#warning "Power management for this processor not implemented yet"
 #endif
=20
 #ifndef __ASSEMBLER__

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
