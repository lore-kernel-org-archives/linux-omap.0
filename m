From: NeilBrown <neilb@suse.de>
Subject: Help wanted with USB and OMAP3 off_mode
Date: Wed, 9 Jan 2013 09:29:15 +1100
Message-ID: <20130109092915.1c2077b5@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/i/wOCVT5oDITxlHN6o2OTNA"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48748 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156Ab3AHW3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 17:29:31 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CAD4EA4EB7
	for <linux-omap@vger.kernel.org>; Tue,  8 Jan 2013 23:29:29 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--Sig_/i/wOCVT5oDITxlHN6o2OTNA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi,
 I'm trying to get off_mode working reliably on my gta04 mobile phone.

My current stumbling block is USB.  The "Option" GSM module is attached via
USB (there is a separate transceiver chip attached to port 1 which is placed
in OMAP_EHCI_PORT_MODE_PHY).

After a suspend/resume cycle with off_mode enabled the GSM module disappear=
s.
i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices don't
exist.
Without off mode, the modem always appears after resume.

I discovered that the registers set by:

   drivers/mfd/omap-usb-host.c

are not maintained across as suspend/resume so I added the following patch
(which I can make a formal submission of if it looks right to others), but
that didn't help (or didn't help enough).

If I

  echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend

thus keeping just the USBHOST power domain out of off_mode, the GSM module
doesn't disappear.  So it seems that some context in the usbhost domain is
not being save and restored.

This is as far as I can get.  Can someone suggest where I should look to fi=
nd
out what is not being saved/restored properly, and how to go about saving a=
nd
restoring?

Thanks in advance,
NeilBrown



diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 23cec57..522405e 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -100,6 +100,10 @@ struct usbhs_hcd_omap {
=20
 	void __iomem			*uhh_base;
=20
+	struct {
+		unsigned		hostconfig;
+	} context;
+
 	struct usbhs_omap_platform_data	platdata;
=20
 	u32				usbhs_rev;
@@ -300,6 +304,10 @@ static int usbhs_runtime_resume(struct device *dev)
 	clk_enable(omap->utmi_p1_fck);
 	clk_enable(omap->utmi_p2_fck);
=20
+	usbhs_write(omap->uhh_base,
+		    OMAP_UHH_HOSTCONFIG,
+		    omap->context.hostconfig);
+
 	spin_unlock_irqrestore(&omap->lock, flags);
=20
 	return 0;
@@ -319,6 +327,8 @@ static int usbhs_runtime_suspend(struct device *dev)
 	}
=20
 	spin_lock_irqsave(&omap->lock, flags);
+	omap->context.hostconfig =3D usbhs_read(omap->uhh_base,
+					      OMAP_UHH_HOSTCONFIG);
=20
 	if (is_ehci_tll_mode(pdata->port_mode[0]))
 		clk_disable(omap->usbhost_p1_fck);

--Sig_/i/wOCVT5oDITxlHN6o2OTNA
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUOyduznsnt1WYoG5AQLKng/8DHtXvDOxJ1ErNlCfSJlHATmG1PUt40Qu
RLMpHidPHG/9VswNvxHQy8HM1WcZRSBz/FHW6S9x/imfBUue5r4WjE/L5wTGpr1G
wq97qUpD8MsqzCKXdPE6AlAObu4A2dwyWIt/RxuViPCmXWY77BCAdxmNOzM+RAZq
bUnal1gYHIuK8a84eoo+paS0R8WjLaIFomTofR7WF+HBe5SpZ/1PU2xxuS7Z8BZD
CpqYwsCDX+DHTYX/66BzqtiQ9Oic1GcJ/Iwggj8JLRqPnWvEd2nr+Jrf29eX/+CM
UtULg73leBg0d+NGrxyjoDCi4LqalswwIwWz27w85RlRu23NoVf7LYqdRhg8gW1X
GTy0BkmtcaXInVxZ2ZH8JUopWRYtx9JCZCUEOfAXg9wyaU6O04FbnMuX1tGO2d16
EEJQ4d+pmamnhtdndXds63JC5ii91uI/K0QdCPhmnNO0CgkPny61GKDBj7Xk3MF+
hi07/9BRhLDS3tyZ035QkJASZYrURjng05jrHg3l6i8vDF2w5tpElXRTebRuvQZr
FjhdaD+wpFxY1B2E81ceWqk7lNaRSYIaXNnw99DBXYtxTboNvwOy5UdUaVT/RN5U
dAQ8FcN5DOq4iVr/Ef6+y4lErqkOIJsi+JuZtwRYNQExFhEiSNGAo2Ny0nR1H5jU
DEZRbxMZKKk=
=VH8o
-----END PGP SIGNATURE-----

--Sig_/i/wOCVT5oDITxlHN6o2OTNA--
