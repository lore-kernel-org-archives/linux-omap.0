From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display kconfig options changing
Date: Tue, 29 Dec 2015 12:23:58 +0200
Message-ID: <56825F3E.5070602@ti.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
 <567430DB.4000507@ti.com>
 <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8916737297943615776=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8916737297943615776==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8mk3jNSRMklVsOWVlwWsdJqQvwXvvw7hU"

--8mk3jNSRMklVsOWVlwWsdJqQvwXvvw7hU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Javier, Tony,

On 22/12/15 23:18, Javier Martinez Canillas wrote:

>> But if the userspace is using any omapfb specific apps, then yes, upda=
te
>> is necessary.
>>
>=20
> Yes but these people should have a migration plan anyways since omapfb
> (and fbdev in general) is going away right?

Well, I would guess most people don't know/care about that.

>> Ok. I think it's then best that I just update the defconfig to enable
>> omapfb as modules, as it is currently.
>>
>=20
> In that case I think you should squash the defconfig changes with
> commit ("70ba4e05531f omapfb/displays: change CONFIG_DISPLAY_* to
> CONFIG_FB_OMAP2_*") to maintain bisectability.

Here's the diff to change the defconfig to enable the same items as befor=
e:

diff --git a/arch/arm/configs/omap2plus_defconfig
b/arch/arm/configs/omap2plus_defconfig
index c5e1943e5427..b9581f1f0536 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -290,24 +290,23 @@ CONFIG_FB=3Dy
 CONFIG_FIRMWARE_EDID=3Dy
 CONFIG_FB_MODE_HELPERS=3Dy
 CONFIG_FB_TILEBLITTING=3Dy
-CONFIG_OMAP2_DSS=3Dm
-CONFIG_OMAP5_DSS_HDMI=3Dy
-CONFIG_OMAP2_DSS_SDI=3Dy
-CONFIG_OMAP2_DSS_DSI=3Dy
+CONFIG_FB_OMAP5_DSS_HDMI=3Dy
+CONFIG_FB_OMAP2_DSS_SDI=3Dy
+CONFIG_FB_OMAP2_DSS_DSI=3Dy
 CONFIG_FB_OMAP2=3Dm
-CONFIG_DISPLAY_ENCODER_TFP410=3Dm
-CONFIG_DISPLAY_ENCODER_TPD12S015=3Dm
-CONFIG_DISPLAY_CONNECTOR_DVI=3Dm
-CONFIG_DISPLAY_CONNECTOR_HDMI=3Dm
-CONFIG_DISPLAY_CONNECTOR_ANALOG_TV=3Dm
-CONFIG_DISPLAY_PANEL_DPI=3Dm
-CONFIG_DISPLAY_PANEL_DSI_CM=3Dm
-CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=3Dm
-CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02=3Dm
-CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=3Dm
-CONFIG_DISPLAY_PANEL_TPO_TD028TTEC1=3Dm
-CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1=3Dm
-CONFIG_DISPLAY_PANEL_NEC_NL8048HL11=3Dm
+CONFIG_FB_OMAP2_ENCODER_TFP410=3Dm
+CONFIG_FB_OMAP2_ENCODER_TPD12S015=3Dm
+CONFIG_FB_OMAP2_CONNECTOR_DVI=3Dm
+CONFIG_FB_OMAP2_CONNECTOR_HDMI=3Dm
+CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=3Dm
+CONFIG_FB_OMAP2_PANEL_DPI=3Dm
+CONFIG_FB_OMAP2_PANEL_DSI_CM=3Dm
+CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM=3Dm
+CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=3Dm
+CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=3Dm
+CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1=3Dm
+CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1=3Dm
+CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11=3Dm
 CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
 CONFIG_LCD_CLASS_DEVICE=3Dy
 CONFIG_LCD_PLATFORM=3Dy

Tony, the diff above looks like something that's safe to merge via fbdev
tree. The context contains only display related configs. Is it ok if I
squash the above change to my series to keep bisectability?

> Alternatively, the current panel and encoders Kconfig symbols could
> remain for omapfb since that's the current ones used in
> omap2plus_defconfig where omapfb is the default and have new Kconfig
> symbols for omapdrm (i.e: CONFIG_DRM_OMAP_ENCODER_TFP410).

I want to change the config symbols, as the current ones are too generic
(e.g. CONFIG_DISPLAY_PANEL_DPI doesn't mention OMAP anywhere). I think
this is a good time to change them for omapfb. But this is probably a
good time to change them for omapdrm also, so I think I'll add that chang=
e.

 Tomi


--8mk3jNSRMklVsOWVlwWsdJqQvwXvvw7hU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWgl8+AAoJEPo9qoy8lh71lwAP/1K0IhT/t12uvmozC1hvmFAN
XfG2Y0fBmGyeNQkFxdu19Lf2hC0yUrqapRZHiUZvxjO+5dREbvDL4E8g7PhNAoQ6
eh8bhYR5OI3YNc0dnvDlPCQfj9WMLiwk7XgPAP4c1o7Y7RZQpvz167P1Ur+7ezrW
epJyjaDwt6Tjz4xXgp7PM/lY89AVX7JVBB7rheMI3GTea8ofGan9+WrlMqmT7j8X
wENbIC0HqZvec1eIxqgwBrxO/aBjqg5Ca+i7hvr94wwH+nXLfnrT/i0WME2sKYuX
xCncazZuF21+3qJK7UMYeP//5M2kvgAcSN6QwYFp+IDMbDSAGe8jHfojecQ2O+dr
wllru1bAXyubZCOTS1EkMy/qqZ0BZHu1zr8qmYz148TCpuluEOvHa2AVkLueaObB
Ya0qtm9I3ayIbLhTzpqyYundvooQa4iSMcLZrrWcoHVI6End93/K6+dXOOGUHvOT
yqL6Aewrbi0+V0zx3P8bgYUWGtv7hf11XcVZrQQpmO1SQHAeRsdV1PRnDdGQrSdu
sPQUyGUE7JT7HWxIeKUr9b2MWo3L71QnK+hxn1gSyODTNok8TSd4xW+GOrut9LZi
SUp4r6Z0yTSKEwe6x0gWbB4Uhtv+1iEJY9PObvDvhwoi9ISiJWLRuJam6Bq6nQBw
xZeEIXgDhQNa8jJvaIf5
=yND0
-----END PGP SIGNATURE-----

--8mk3jNSRMklVsOWVlwWsdJqQvwXvvw7hU--


--===============8916737297943615776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8916737297943615776==--
