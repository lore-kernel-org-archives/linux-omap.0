From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Mon, 16 Dec 2013 14:55:25 +0100
Message-ID: <1771228.vtXv3vOBGI@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <14299863.f0rzOyPfdL@avalon> <52AEDA9F.2020609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2035858.VLNuJbXenk"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52AEDA9F.2020609-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nextPart2035858.VLNuJbXenk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Monday 16 December 2013 12:49:03 Tomi Valkeinen wrote:
> On 2013-12-13 05:24, Laurent Pinchart wrote:
> >> Then DPI, which I think is mostly just level shifters. It's really just
> >> a port, as you say.
> >> 
> >> SDI is a bit unclear to me. The registers for it are in the dss_core.
> >> There's only a few registers, but it does have a PHY and a PLL. But I
> >> guess it's also more of a port than a separate module.
> > 
> > After a quick look at the documentation I would say so. I would be tempted
> > to consider RFBI as part of the DSS core, but that's less clear.
> 
> I had a look at this, mainly the DPI side so far. There's one extra
> complication, which actually affects all other outputs also (and CDF):
> pinctrl.
> 
> In the current series, I just have pinctrl for each device, with
> "default" name, which ends up being used by default without any code on
> my part.
> 
> However, if DPI is no longer a device, it can't have pinctrl entry. But
> this is a wider issue, as the pinctrl should really be per endpoint, not
> per device. When an endpoint is selected to be used, a particular
> pinmuxing should be taken into use.
> 
> I'm not sure what would be the cleanest solution to this. I currently
> have this working:
> 
> &dss {
> 	pinctrl-names = "default-0-0";
> 	pinctrl-0 = <&dss_dpi_pins>;
> 
> 	port@0 {
> 		dpi_out: endpoint {
> 			remote-endpoint = <&tfp410_in>;
> 			data-lines = <24>;
> 		};
> 	};
> };
> 
> So here I have 'port@0' for DSS, which is the DPI output, and it has a
> single endpoint. For DSS device, I have pinctrl data.
> 
> When the DPI endpoint is initialized, the code looks for pinctrl with
> name "default-<portnum>-<endpointnum>". As the DPI is port 0, and just
> one endpoint, the code looks for "default-0-0".
> 
> For omap3 board with both DPI and SDI as options (they can't be used at
> the same time, though), I imagine it'd be like:
> 
> &dss {
> 	vdds_dsi-supply = <&vpll2>;
> 	vdds_sdi-supply = <&vpll2>;
> 
> 	pinctrl-names = "default-0-0", "default-1-0";
> 	pinctrl-0 = <&dss_dpi_pins>;
> 	pinctrl-1 = <&dss_sdi_pins>;
> 
> 	ports {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		port@0 {
> 			reg = <0>;
> 			dpi_out: endpoint {
> 			};
> 		};
> 
> 		port@1 {
> 			reg = <1>;
> 			sdi_out: endpoint {
> 			};
> 		};
> 	};
> };
> 
> Any thoughts?

Would it be feasible to put the pinctrl properties in the port or endpoint 
nodes ? That could require changes to the pinctrl core, most probably just 
exporting a few internal functions (possibly requiring a bit of refactoring), 
but it might make the result simpler.

> Every time I work with ports/endpoints, I feel that this is needlessly
> complex. But I have never come up with any cleaner or simpler way to
> handle this.
>
> I also think this multiple-peripherals-per-single-port is not really
> display related, although, for some reason, it seems like display is the
> most abused hardware. Maybe ports/endpoints or similar should be in the
> common driver framework?

Ports and endpoints is the way we have come up with to describe a graph in DT. 
I wouldn't call it needlessly complex, as I believe it's both generic and 
simple, but I agree it's a bit on the verbose side. Omitting the ports and 
port nodes as a shortcut might be a good way to reduce the verbosity.

Regarding moving this to the device core, I'm not opposed to it, but I'd like 
to see interest from other users first.

-- 
Regards,

Laurent Pinchart

--nextPart2035858.VLNuJbXenk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSrwZVAAoJEIkPb2GL7hl1ckIH/jOzmaV71ewRvqQXDTnnJ24g
qPYW4bBVuxcGyz9YrX819RY8JArt1qZNlYlQWisHoq7cLwAD5YuQRYnWVVebBUJo
uqlYlC2Kb4IuYY88pY2Ib+ocl/CSRMQpfmSjxj6BvOcfSSFZen6nxT0YPP21HeG1
KKcHMxTIt8SlzmxLQ0eCmrW6IfFjz42NZIWZZJtbSbdewdqDz5aETwiVtL+kyuHB
bk7cd1/nbZRmWCpuhW9Z5KZ2sdrPVZwEhQskB/oVX+pneBRhYqC2cykAnhBvRCF8
EnVBHAJCIOjq/LvC/9ZTKcRgfBmTxC5GLeu0J4xYY/f1o81QlqXF2oceyDTlV74=
=voBw
-----END PGP SIGNATURE-----

--nextPart2035858.VLNuJbXenk--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
