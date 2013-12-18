From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Wed, 18 Dec 2013 16:02:28 +0200
Message-ID: <52B1AAF4.3020509@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <20131217070551.GR24559@pengutronix.de> <52AFFA2E.5050702@ti.com> <1651476.iaILztiDEi@avalon> <52B17BBF.8090003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DjNsiUb5Mm2cRkPMn7ljkAwtB4p2p3Glh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B17BBF.8090003-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--DjNsiUb5Mm2cRkPMn7ljkAwtB4p2p3Glh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 12:41, Tomi Valkeinen wrote:

> 3. Have correct DT data, but at init time, in omap arch code, go throug=
h
> the DT data and change the compat strings for the display nodes to
> include "omapdss,". This way the drivers would only work for omap
> platforms. Like a combination of 1. and 2. I'm not sure if the DT-code
> allows this at the moment, though.

This wasn't actually too hard. It says "hack" all over it, but the code
was quite compact. I call the omapdss_early_init_of() as the first thing
in omap_generic_init(), before the devices are created:

+static const char* const dss_compat_conv_list[] =3D {
+       "hdmi-connector",
+       "dvi-connector",
+       "ti,tpd12s015",
+       "panel-dsi-cm",
+};
+
+static void omapdss_omapify_node(struct device_node *node, const char
*compat)
+{
+       char *new_compat;
+       struct property *prop;
+
+       new_compat =3D kasprintf(GFP_KERNEL, "omapdss,%s", compat);
+
+       prop =3D kzalloc(sizeof(*prop), GFP_KERNEL);
+       prop->name =3D "compatible";
+       prop->value =3D new_compat;
+       prop->length =3D strlen(new_compat) + 1;
+
+       of_update_property(node, prop);
+}
+
+void __init omapdss_early_init_of(void)
+{
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(dss_compat_conv_list); ++i) {
+               const char *compat =3D dss_compat_conv_list[i];
+               struct device_node *node =3D NULL;
+
+               while ((node =3D of_find_compatible_node(node, NULL,
compat))) {
+                       if (!of_device_is_available(node))
+                               continue;
+
+                       omapdss_omapify_node(node, compat);
+               }
+       }
+}

The list has just part of the devices, and I've so far only tested on
OMAP 4430sdp board, but it seemed to work fine.

So with this, I can have "hdmi-connector" in the .dts file, and
"omapdss,hdmi-connector" as a compat string in the omap specific driver.

Does it make your eyes bleed, or is it maybe something that could be
fine for the time being?

 Tomi



--DjNsiUb5Mm2cRkPMn7ljkAwtB4p2p3Glh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsar0AAoJEPo9qoy8lh71m8IP/jEk/2ZRxHpiBknUc6b1LW0p
g0UwpT1orlzdUjqFD1JBvXaZ0F63gPlwZO4DSVeIhTSuXt1/9i/uYytevwMwa29A
3I1hEiE6e1Ajt73hzyZgzPmzzhXriyZe7sj9mNfNZ09B5KVtLKOJQ88EMcBzSfbs
spBYUXpFZ8EKWj8Q9MXyXyvPj23bPXN0Ph/R+BItN7LOD5t1/39H6KYu3Xz07N9A
jK2DzHjr2dnlcKfxHInlyHBQDuOpQt0Esj3NOCEbZVGHUR3uXXb/lBduQdfna3GF
uW3blTV/Yh05Ie7wUrY1n4iNHoSuMcLG6iVS7VxRm6PPRiOzY/Ea+5V4R5XEH/Qi
n//mfAHxKHGpCtcwdzPOvjYxJjXQhbbo2wAk2HvuX9x4zKGUaRMtzN1aDExuFVqm
507HMbq5BZSBwlkuQsoqRrkVrmYA6xYljcrK8VTlyxT5N3tJIZmWEHJHXOOVhRc2
WAWAEWXdvE5BoRsPJCuFkj4rsNwjVYQUsGc1ZKMt+hF/TfY/aylN6vObGJiNqrYL
+YpPTq76Rn+s97YW38Lx99l+Fr2XBDP5ESsIpnCg3z5LQcViMsZXS4nEHuOo1eqv
N2KKx6UFjacLkITc6B5zPqtlQQ2ziKeCji8HWJLvQIAOOkwLHWFSywyWd14ECIAm
Zmruw2mQpTIndZm2OVZo
=nv1o
-----END PGP SIGNATURE-----

--DjNsiUb5Mm2cRkPMn7ljkAwtB4p2p3Glh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
