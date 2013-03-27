From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 02/14] ARM: OMAP2+: add omapdss_init_of()
Date: Wed, 27 Mar 2013 12:09:12 +0200
Message-ID: <5152C548.9030500@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com> <1364373921-7599-3-git-send-email-tomi.valkeinen@ti.com> <5152BBD3.9070202@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF94C5C548F92B7548B4235DC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39885 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab3C0KJZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 06:09:25 -0400
In-Reply-To: <5152BBD3.9070202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--------------enigF94C5C548F92B7548B4235DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-27 11:28, Benoit Cousson wrote:
> Hi Tomi,

Hi Benoit. Thanks for your comments!

> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
>> omapdss driver uses a omapdss platform device to pass platform specifi=
c
>> function pointers and DSS hardware version from the arch code to the
>> driver. This device is needed also when booting with DT.
>>
>> This patch adds omapdss_init_of() function, called from board-generic =
at
>> init time, which creates the omapdss device.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c |    1 +
>>  arch/arm/mach-omap2/common.h        |    2 ++
>>  arch/arm/mach-omap2/display.c       |   34 ++++++++++++++++++++++++++=
++++++++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2=
/board-generic.c
>> index a61544b..29eb085 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -41,6 +41,7 @@ static void __init omap_generic_init(void)
>> =20
>>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>> =20
>> +	omapdss_init_of();
>=20
> Mmm, you should not have to call that explicitly. It looks like a hack
> to me. Everything in theory should be initialized during
> of_platform_populate / driver probe.

All the "real" devices are initialized properly. However, we still have
a "virtual" omapdss device, which does not represent a particular HW
block as such, and is not represented in the DT data. It's a legacy
thing, and slowly on its way out.

However, it still helps us to pass the platform callbacks via platform
data even in DT call, so we have this (hacky) omapdss_init_of() call.

And we also pass the OMAP revision information via the platform data, as
we need to know the DSS HW version. The only way to get that is to know
the OMAP version and revision. If we would set the DSS HW version
information into DT data, we could need separate dts files for each OMAP
revision.

>> +
>> +int __init omapdss_init_of(void)
>> +{
>> +	int r;
>> +	enum omapdss_version ver;
>> +
>> +	static struct omap_dss_board_info board_data =3D {
>> +		.dsi_enable_pads =3D omap_dsi_enable_pads,
>> +		.dsi_disable_pads =3D omap_dsi_disable_pads,
>=20
> Pads config should be handle by pinmux framework is possible. Otherwise=

> a dedicated driver will be required.

Hmm. These functions touch the OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY
(CONTROL_DSIPHY in the TRM) register. It's not a normal padconfig thing
(like, selecting between GPIO and some other function).

Can they be handled by the pinmux framework? I'm not familiar with it.
What do you mean with dedicated driver? Dedicated pinmux driver, or
something else?

>> +		.get_context_loss_count =3D omap_pm_get_dev_context_loss_count,
>> +		.set_min_bus_tput =3D omap_dss_set_min_bus_tput,
>=20
>=20
> All that code should disappear with DT. hacking a platform device with
> pdata is the old way of initializing a device.
>=20
> I know that you do have some omap_pm callback, but you'd better get rid=

> of them in case of DT boot.
> Fixing that is a generic issue, and as soon as a solution will be done
> to handle these specific hooks, every drivers will be able to use that.=


So, what you're saying is that this is not the correct way, but there's
no other way to handle it currently? If so, yes, I know that, but, well,
there's no other way to handle it currently.

I could leave them out, but in that case when booting with DT there must
be no DSS context loss, and OPP must be at OPP100 all the time.

 Tomi



--------------enigF94C5C548F92B7548B4235DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUsVIAAoJEPo9qoy8lh71E88P/3FdcC5kqgumiFNb3dJ50lxE
CmS/vdD+kJvofm4dEcyBHgwlskDca7058iMNX3KRLoJA6xp53C5yFRt/zRwQEd5w
TAygqbizVSZT91Ig8h0rhXMgdU0ayPW2eIscEcNmK1JdIr45KchtHY89325uDcxX
C+jChXnbwaaDZFgPXrn+o25rf5CGn1QNXlZXkLrI82bK6UcH+L47kaMVyS2tM1V0
LF2ndg+igNHs8RGyYyQHSLMBH6Asp1pMmTJDZsN2hvAi2AOQ2fpPB1GBqKa3U5tA
fbXFiB3bFjeazgJOO2yo6Nk8aYLGQM//eeY6GqbwKEsTvwdu1dyGU9/VPl+Snf5q
eAGdYUqxWN2oThQpqQqUCm5FaiEL/yCXnN4AWix2Tj2G0c+6ZvqQ8Ru7xPaLS7ix
GAwaBIiCzWt3aNW/QUBrqSXsYYu86cAoiD5jYqDQbgqAKqeV1DngD2mneO4cfHpn
icxTBBMvKPo8LJpYVVSI4FAIy+HD/gk7j8y0Gc5ySSDFo5OqDYA/aReUsmONffts
57vrBQDBB1flOpk/t5d3AKjXF2hAVh49V2Vf99WT+16AyfTFfP71c1pQWVQGlD6f
XgXqc/RGFuf+pYW8nxHQ1GMCU6FxrVJii3GUIEbmVYBSRfF9/EEueaio9RUvBsGm
VAmPtggvgH96nHl2Lkll
=Vj1V
-----END PGP SIGNATURE-----

--------------enigF94C5C548F92B7548B4235DC--
