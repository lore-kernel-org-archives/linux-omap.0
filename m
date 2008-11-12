From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] omap: get rid of OMAP_TAG_USB
Date: Tue, 11 Nov 2008 22:20:33 -0800
Message-ID: <200811112220.33960.david-b@pacbell.net>
References: <1222352531-30796-1-git-send-email-felipe.balbi@nokia.com> <1222352531-30796-2-git-send-email-felipe.balbi@nokia.com> <20081024215805.GD10733@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:33007 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750956AbYKLGUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 01:20:36 -0500
In-Reply-To: <20081024215805.GD10733@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Friday 24 October 2008, Felipe Balbi wrote:
> > --- a/arch/arm/plat-omap/include/mach/usb.h
> > +++ b/arch/arm/plat-omap/include/mach/usb.h
> > @@ -29,6 +29,7 @@
> > =A0
> > =A0void __init usb_musb_init(void);
> > =A0void __init usb_ehci_init(void);
> > +void omap_usb_init(struct omap_usb_config *pdata);
> > =A0
> > =A0#endif
> > =A0

That "#endif" is for the !OMAP1 branch ... so this patch
couldn't built on on any OMAP1 platform at all.  And for
OSK, you put the USB init in with the Mistral-specific
init ... but most OSKs don't connect to a Mistral.

The following patch gets it to build OK for my OSK, but
then omap_udc hit some new locking bug.  Sigh.

- Dave


--- osk.orig/arch/arm/mach-omap1/board-osk.c	2008-11-11 20:32:50.000000=
000 -0800
+++ osk/arch/arm/mach-omap1/board-osk.c	2008-11-11 20:19:33.000000000 -=
0800
@@ -544,7 +544,6 @@ static void __init osk_mistral_init(void
 	i2c_register_board_info(1, mistral_i2c_board_info,
 			ARRAY_SIZE(mistral_i2c_board_info));
=20
-	omap_usb_init(&osk_usb_config);
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
@@ -584,6 +583,7 @@ static void __init osk_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
+	omap_usb_init(&osk_usb_config);
 	osk_mistral_init();
 }
=20
--- osk.orig/arch/arm/plat-omap/include/mach/usb.h	2008-11-11 20:32:50.=
000000000 -0800
+++ osk/arch/arm/plat-omap/include/mach/usb.h	2008-11-11 20:27:06.00000=
0000 -0800
@@ -29,10 +29,10 @@
=20
 void __init usb_musb_init(void);
 void __init usb_ehci_init(void);
-void omap_usb_init(struct omap_usb_config *pdata);
-
 #endif
=20
+void omap_usb_init(struct omap_usb_config *pdata);
+
 /*--------------------------------------------------------------------=
-----*/
=20
 /*
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
