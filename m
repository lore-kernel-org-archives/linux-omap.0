From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 01/35] ARM: OMAP2+: Register SoC device attributes from
 machine .init()
Date: Wed, 9 Aug 2017 15:56:45 +0300
Message-ID: <201708091256.v79Culwe004765@dlelxv90.itg.ti.com>
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_e96212c2-e994-4c81-8d71-b9b9323a8f37_"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--_e96212c2-e994-4c81-8d71-b9b9323a8f37_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFThis message contains a digitally signed email which can be read b=
y opening the attachment.
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki



--_e96212c2-e994-4c81-8d71-b9b9323a8f37_
Content-Type: message/rfc822

Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.845.34; Wed, 9 Aug
 2017 07:56:47 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.845.34 via Frontend Transport;
 Wed, 9 Aug 2017 07:56:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
	by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id v79Cuj8Z026791;
	Wed, 9 Aug 2017 07:56:46 -0500
Subject: Re: [PATCH v3 01/35] ARM: OMAP2+: Register SoC device attributes from
 machine .init()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	<dri-devel@lists.freedesktop.org>, Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <66207d47-08bb-55bb-c50a-b4988af37481@ti.com>
Date: Wed, 9 Aug 2017 15:56:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="_c7cfe21e-952d-4b16-897a-5d102fda88e0_"
Return-Path: tomi.valkeinen@ti.com

--_c7cfe21e-952d-4b16-897a-5d102fda88e0_
Content-Type: multipart/mixed; boundary="0VpMo5p9879RKaBUPjEwFWneDHna22WsL";
	protected-headers=v1
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>
CC: linux-omap@vger.kernel.org
Message-ID: <66207d47-08bb-55bb-c50a-b4988af37481@ti.com>
Subject: Re: [PATCH v3 01/35] ARM: OMAP2+: Register SoC device attributes from
 machine .init()
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20170804224419.30758-2-laurent.pinchart@ideasonboard.com>

--0VpMo5p9879RKaBUPjEwFWneDHna22WsL
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 05/08/17 01:43, Laurent Pinchart wrote:
> SoC device attributes are registered with a call to
> soc_device_register() from the machine .init_late() operation, which is=

> called from the late initcall, after all drivers built-in drivers have
> been probed. This results in the impossibility for drivers to use SoC
> device matching in their probe function.
>=20
> The omap_soc_device_init() function is safe to call from the machine
> .init() operation, as all data it depends on is initialized from the
> .init_early() operation. Move SoC device attribute registration to
> machine .init() like on all other ARM platforms.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 1 +
>  arch/arm/mach-omap2/io.c            | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
> index dc9e34e670a2..5303402ed5c2 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -33,6 +33,7 @@ static void __init omap_generic_init(void)
>  	pdata_quirks_init(omap_dt_match_table);
> =20
>  	omapdss_init_of();
> +	omap_soc_device_init();
>  }
> =20
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 1d739d1a0a65..952e36b4c4d3 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -428,7 +428,6 @@ static void __init omap_hwmod_init_postsetup(void)
>  static void __init __maybe_unused omap_common_late_init(void)
>  {
>  	omap2_common_pm_late_init();
> -	omap_soc_device_init();
>  }
> =20
>  #ifdef CONFIG_SOC_OMAP2420
>=20

Tony, how does this look? Can I push it via the drm tree, along with the
series?

 Tomi


--0VpMo5p9879RKaBUPjEwFWneDHna22WsL--

--_c7cfe21e-952d-4b16-897a-5d102fda88e0_
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZiwaNAAoJEPo9qoy8lh71Mz8P/0HRAVaZAbXmCM/ku/OgQR35
ukdsfnVNm9ASRGDWnJqB0dHZRUMHIx9lylgISHvNkjney0d4lPAEY5Ubu3qeQMi8
0H+Q6gmeChoaV6a0U20gDmZDbX5EH84E+U/sxQcOFByV1vVZRpGJmCHWgNdX3QPX
dynPMGzvmHk3OxQdFCLxtVMmt88NfywrS6BtMmSWIsuHAcaK7tevenykvWKzgZ8Q
fyWCh5kelRKE3x17icK8IK2cqpCOxuboLWLtfY+NjKsPLeRlbEagEzquQADrROe5
QJe6tQG2z9XAoUEW4d9AZ9VtrxRp0v0UOirJznIIm1o48kIv5jzRldXDdWY6hDEx
zoT0JBvPrnyQT8EKClOBguR2A07VVOh3iA9tpvJbEHpSwYMd/hhHPOYH9sSKx5DE
G5Qc2vRFKF/mAx82/ioIHOaiDMFhF4qdu9QHGc6XdVAO3XLHqUcv2ojZJtmdulDx
Z0geMEwdaz7cLTe2d58xTQJ9PHV0bv0zk9VGaf8Agit73aglX2ypzzPzU1kC7bVJ
k2U/dEdRaQ4J2h/AfiYdtHV0ZhToWu75AasOGOTVf7q97B/sNUxA+SNB62qMBf2w
S6PBMAVRt0o8DiEsXBt1NGVyWtZNdC6mXN4wF8L1WTbdE0cJ4r/XtwUk8tWc47OS
/caZYegdjZGWNm1HcEoh
=NlHd
-----END PGP SIGNATURE-----

--_c7cfe21e-952d-4b16-897a-5d102fda88e0_--

--_e96212c2-e994-4c81-8d71-b9b9323a8f37_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--_e96212c2-e994-4c81-8d71-b9b9323a8f37_--
