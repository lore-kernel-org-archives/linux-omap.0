From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 18:55:03 +0000
Message-ID: <20140113185503.GE27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <20140108012110.GL5074@atomide.com> <20140109152437.GB27282@n2100.arm.linux.org.uk> <20140113141811.GD27282@n2100.arm.linux.org.uk> <20140113173744.GA7746@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35887 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751024AbaAMSzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 13:55:19 -0500
Content-Disposition: inline
In-Reply-To: <20140113173744.GA7746@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 13, 2014 at 09:37:45AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 08:48]:
> > Any news on this?
>=20
> Sorry for the delay, now getting this:
>=20
> arch/arm/mach-omap1/dma.c: In function =E2=80=98omap1_system_dma_init=
=E2=80=99:
> arch/arm/mach-omap1/dma.c:368: error: =E2=80=98struct omap_dma_dev_at=
tr=E2=80=99 has no member named =E2=80=98chan=E2=80=99

Gah.  Next incremental patch:

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 404f89e3eeb8..1b1b64647def 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -344,14 +344,14 @@ static int __init omap1_system_dma_init(void)
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
=20
 	ret =3D platform_device_add(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
=20
 	dma_pdev =3D platform_device_register_full(&omap_dma_dev_info);
@@ -364,8 +364,6 @@ static int __init omap1_system_dma_init(void)
=20
 exit_release_pdev:
 	platform_device_del(pdev);
-exit_release_chan:
-	kfree(d->chan);
 exit_release_d:
 	kfree(d);
 exit_iounmap:


--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
