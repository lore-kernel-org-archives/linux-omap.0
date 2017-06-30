From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Fri, 30 Jun 2017 11:47:55 +0300
Message-ID: <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0781498075=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

--===============0781498075==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FUhW0ROgS7Pa9LigfX2tLeIQNjqFNAs1Q"

--FUhW0ROgS7Pa9LigfX2tLeIQNjqFNAs1Q
Content-Type: multipart/mixed; boundary="KHNWc88iLPxKr91lnTL8AWl1b8CQThSka";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Message-ID: <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
In-Reply-To: <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>

--KHNWc88iLPxKr91lnTL8AWl1b8CQThSka
Content-Type: multipart/mixed;
 boundary="------------BF754C8B707760AB0EBBB91F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BF754C8B707760AB0EBBB91F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30/06/17 09:41, Tomi Valkeinen wrote:

> So, I don't know... I guess I need to try to invent some horrible hacks=

> around the driver to somehow manage the omap3 problems. Perhaps
> disabling/enabling the outputs when sync lost happens...

Well, I tried that (attached), but it didn't work either. For some
reason the error worker seems to stop after the disable. Possibly the
irq flood keeps it from running, so maybe it should catch all the errors
(I see underflows too).

Sorry, but I can't use more time on this today, and I'm leaving for
vacation today. I hope Laurent can help during my absence.

We could try reverting the patch you mention, but I think it doesn't
cause the problem.

Did you have CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled earlier when
things worked? If you didn't, and the dts did not contain display
aliases, I think the omapdrm may have started without TV. So maybe the
TV side is the culprit, somehow (I couldn't find anything when I looked
at that side either).

 Tomi

--------------BF754C8B707760AB0EBBB91F
Content-Type: text/x-patch;
 name="0001-drm-omap-hack-error-worker.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-drm-omap-hack-error-worker.patch"

=46rom c4ceb8934dbfa51bc966b927b17394c4b622712c Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jun 2017 11:39:53 +0300
Subject: [PATCH] drm/omap: hack error worker

---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 69 +++++++++++++++++++++++++++++++=
+-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdr=
m/omap_crtc.c
index dccd03726796..eb36b35f5eb8 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -36,12 +36,15 @@ struct omap_crtc {
=20
 	struct videomode vm;
=20
-	bool ignore_digit_sync_lost;
+	bool ignore_sync_lost;
=20
 	bool enabled;
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+
+	struct work_struct error_work;
+	u32 error_channels;
 };
=20
 /* ---------------------------------------------------------------------=
--------
@@ -157,7 +160,7 @@ static void omap_crtc_set_enabled(struct drm_crtc *cr=
tc, bool enable)
 		 * Digit output produces some sync lost interrupts during the
 		 * first frame when enabling, so we need to ignore those.
 		 */
-		omap_crtc->ignore_digit_sync_lost =3D true;
+		omap_crtc->ignore_sync_lost =3D true;
 	}
=20
 	framedone_irq =3D priv->dispc_ops->mgr_get_framedone_irq(channel);
@@ -191,7 +194,7 @@ static void omap_crtc_set_enabled(struct drm_crtc *cr=
tc, bool enable)
 	}
=20
 	if (omap_crtc->channel =3D=3D OMAP_DSS_CHANNEL_DIGIT) {
-		omap_crtc->ignore_digit_sync_lost =3D false;
+		omap_crtc->ignore_sync_lost =3D false;
 		/* make sure the irq handler sees the value above */
 		mb();
 	}
@@ -263,17 +266,65 @@ static const struct dss_mgr_ops mgr_ops =3D {
  * Setup, Flush and Page Flip
  */
=20
+static void omap_crtc_error_worker(struct work_struct *work)
+{
+	struct omap_crtc *omap_crtc =3D container_of(work, struct omap_crtc, er=
ror_work);
+	struct drm_crtc *crtc =3D &omap_crtc->base;
+	struct drm_device *dev =3D omap_crtc->base.dev;
+	struct omap_drm_private *priv =3D dev->dev_private;
+
+	drm_modeset_lock(&crtc->mutex, NULL);
+
+	dev_warn(dev->dev, "sync lost on %s, enabling & disabling...\n",
+		omap_crtc->name);
+
+	priv->dispc_ops->mgr_enable(omap_crtc->channel, false);
+
+	msleep(50);
+	dev_warn(dev->dev, "sync lost enabling %s\n",
+			omap_crtc->name);
+
+	priv->dispc_ops->mgr_enable(omap_crtc->channel, true);
+
+	msleep(50);
+
+	dev_warn(dev->dev, "sync lost recovery done on on %s\n",
+		omap_crtc->name);
+
+	omap_crtc->ignore_sync_lost =3D false;
+	/* make sure the irq handler sees the value above */
+	mb();
+
+	drm_modeset_unlock(&crtc->mutex);
+}
+
 void omap_crtc_error_irq(struct drm_crtc *crtc, uint32_t irqstatus)
 {
 	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
+	struct drm_device *dev =3D omap_crtc->base.dev;
+	struct omap_drm_private *priv =3D dev->dev_private;
+	enum omap_channel channel =3D omap_crtc_channel(crtc);
+	u32 sync_lost_irq;
+	bool sync_lost;
+
+	sync_lost_irq =3D priv->dispc_ops->mgr_get_sync_lost_irq(channel);
=20
-	if (omap_crtc->ignore_digit_sync_lost) {
-		irqstatus &=3D ~DISPC_IRQ_SYNC_LOST_DIGIT;
-		if (!irqstatus)
-			return;
+	sync_lost =3D irqstatus & sync_lost_irq;
+
+	if (sync_lost) {
+		if (omap_crtc->ignore_sync_lost) {
+			irqstatus &=3D ~sync_lost_irq;
+		} else {
+			/* error worker will set this to false */
+			omap_crtc->ignore_sync_lost =3D true;
+			schedule_work(&omap_crtc->error_work);
+		}
 	}
=20
-	DRM_ERROR_RATELIMITED("%s: errors: %08x\n", omap_crtc->name, irqstatus)=
;
+	if (!irqstatus)
+		return;
+
+	printk("%s: errors: %08x\n", omap_crtc->name, irqstatus);
 }
=20
 void omap_crtc_vblank_irq(struct drm_crtc *crtc)
@@ -612,6 +663,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *de=
v,
=20
 	init_waitqueue_head(&omap_crtc->pending_wait);
=20
+	INIT_WORK(&omap_crtc->error_work, omap_crtc_error_worker);
+
 	omap_crtc->channel =3D channel;
 	omap_crtc->name =3D channel_names[channel];
=20
--=20
2.7.4


--------------BF754C8B707760AB0EBBB91F--

--KHNWc88iLPxKr91lnTL8AWl1b8CQThSka--

--FUhW0ROgS7Pa9LigfX2tLeIQNjqFNAs1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVhA7AAoJEPo9qoy8lh71MUcP/20nZSVAjQc3atz6KWGPZbpt
UpfFK4uuAIBkLz8VAFOe2UesvD1GY13mR+mpbRFfYzsGn9Q8aEIjsEy14u/R1Vwu
JnBLgiWeL3ASW9SrUjZhHoweIPWfveLm6xgLPFt7TJLPZDZCXI97CDCRkz0uz3jD
ZA3u6Dsp1y7qIUEnhzY2vG+XTcWWFIiraYK7iMZSydtds4dql0oJGciqhxPtnndu
LCRH7wcmOTqIBjD7lbUVlf/zjN2DnoV4dxk1I+YyBzS+Ac4lN0HrWSa2e8YMXMYk
9Qj/0ppUTXhgUcfwytkPRKHiD9TdGwc73pannqpAgX7RcldGBtR1xfEnKe5V3t93
aFRZVGpv9yYFwh4TlC+c8Te+7AixdYh8PHXinCy2z9ntfMBISE3HrPrw5Sctdwrp
dlkVP+PeM4G9njThohue3LuRqMyDFDSQOHhiFCspu4IDJLYYPM+ldu9eJd7xPMNd
m6jZ341gwkEvSEGc+7+sozenFjkWB+OFYPAzEo8aWDfA1fTHcMvyTHoPsDN5i/Kd
IjNPlDZiJnZGKPOI203IBPG7ESXusafhanyaP5SwuFFNee9W9+xRkCN52FnYqe4+
yMumlKiRka6t1K5nEpILeDQ3DV7xk92QMTrUcD8NnrQEU+aY+301aKkCSlxOb30d
mOxl48VAXw2pkAdyGh3p
=HX1K
-----END PGP SIGNATURE-----

--FUhW0ROgS7Pa9LigfX2tLeIQNjqFNAs1Q--

--===============0781498075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0781498075==--
