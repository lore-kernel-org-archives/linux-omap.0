From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Tue, 4 Dec 2012 10:16:28 +0200
Message-ID: <50BDB15C.9040406@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com> <50B7528C.1090507@ti.com> <50BC46C6.3050707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig128A40B9E2E9FB3CC5D53A09"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab2LDIQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Dec 2012 03:16:30 -0500
In-Reply-To: <50BC46C6.3050707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig128A40B9E2E9FB3CC5D53A09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-03 08:29, Chandrabhanu Mahapatra wrote:
> On Thursday 29 November 2012 05:48 PM, Tomi Valkeinen wrote:
>> On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
>>> The register fields in dss_reg_fields specific to DISPC are moved fro=
m struct
>>> omap_dss_features to corresponding dispc_reg_fields, initialized in s=
truct
>>> dispc_features, thereby enabling local access.
>>>
>>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>>> ---
>>>  drivers/video/omap2/dss/dispc.c        |   87 ++++++++++++++++++++++=
++++++----
>>>  drivers/video/omap2/dss/dss.h          |    4 ++
>>>  drivers/video/omap2/dss/dss_features.c |   28 ----------
>>>  drivers/video/omap2/dss/dss_features.h |    7 ---
>>>  4 files changed, 80 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/ds=
s/dispc.c
>>> index 9f259ba..21fc522 100644
>>> --- a/drivers/video/omap2/dss/dispc.c
>>> +++ b/drivers/video/omap2/dss/dispc.c
>>> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>>>  	unsigned irqs[32];
>>>  };
>>> =20
>>> +enum dispc_feat_reg_field {
>>> +	FEAT_REG_FIRHINC,
>>> +	FEAT_REG_FIRVINC,
>>> +	FEAT_REG_FIFOLOWTHRESHOLD,
>>> +	FEAT_REG_FIFOHIGHTHRESHOLD,
>>> +	FEAT_REG_FIFOSIZE,
>>> +	FEAT_REG_HORIZONTALACCU,
>>> +	FEAT_REG_VERTICALACCU,
>>> +};
>>> +
>>>  struct dispc_features {
>>>  	u8 sw_start;
>>>  	u8 fp_start;
>>> @@ -107,6 +117,8 @@ struct dispc_features {
>>> =20
>>>  	u32 buffer_size_unit;
>>>  	u32 burst_size_unit;
>>> +
>>> +	struct register_field *reg_fields;
>>>  };
>>
>> Hmm, would it be simpler to have an explicit struct for the reg fields=
=2E
>> I mean something like:
>>
>> struct dispc_reg_fields {
>> 	struct register_field firhinc;
>> 	struct register_field firvinc;
>> 	struct register_field fifo_low_threshold;
>> 	...
>> };
>>
>> Then accessing it would be
>>
>> dispc.feat->reg_fields.firhinc.start;
>>
>> instead of
>>
>> dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;
>>
>> Not a big difference, but I don't see any benefit in having an array o=
f
>> reg fields here.
>>
>>  Tomi
>>
>>
>=20
> I was thinking to move reg_fields into the dispc_feats structure as
>=20
> 	.burst_size_unit	=3D	8,
> 	.reg_fields		=3D	{
> 		.firhinc			=3D { 12,  0 },
> 		.firvinc			=3D { 28, 16 },
> 		.fifo_low_thresh		=3D { 11,  0 },
> 		.fifo_high_thresh		=3D { 27, 16 },
> 		.fifosize			=3D { 10,  0 },
> 		.hori_accu			=3D {  9,  0 },
> 		.vert_accu			=3D { 25, 16 },
> 	},
>=20
> This would give us dispc.feat->reg_fields.firhinc.start;
> but at the same time would create duplicate information for
> omap34xx_rev1_0_dispc_feats and omap34xx_rev3_0_dispc_feats. However,
> this duplication never occurs anywhere else in dss.c or dsi.c.
>=20
> If we still go with the older approach of having dispc_reg_fields
> outside dispc_feats the only way  it works is
>=20
> .reg_fields		=3D	&omap2_dispc_reg_fields
>=20
> which changes as dispc.feat->reg_fields->firhinc.start;
>=20
> but avoids duplicate information. Both approaches seem good enough to m=
e.

I would keep the pointer approach. We may add support for new DSS
versions, for AM3xxx or AM4xxx SoCs, which possibly may have the same
register fields as some other DSS versions.

 Tomi



--------------enig128A40B9E2E9FB3CC5D53A09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQvbFcAAoJEPo9qoy8lh71xTYP/ilYaTEqtaTh6nVczJyA1NDo
ju1xyI6Nb+ufknh2scs67Fl+Uccpu0Dg8w94qRhUtAf4Gf/J7vBAn9kLGrhBuOxu
1qdolV6sdiEKdl0W3pKNo2XX26FJ5wcQQhAy/ghSj0aSR1A1nRhIsb7DDfIczbjG
oFtoOEH274BrHOWZnx65Q0HaNBBdW7H5EGJbPXMJnueNmh/vDMWhzc7LkEBhf7Pz
Iy7GAp7nhtlOKKGiaHcw8HlD38/39ZfyAxbVSM6ZCMY9C4Rbdx3wtVIfMIPDCXPq
DSw1K2oA5osXQzeo0D6r3ikI80X9uJ6+h+Y0s3jAtoyUltDbg5bnecRAvGP/3MCU
lcD53/QRkiValS4eNFST8d1CqTiDz8AlzVsFL+eQ1ssUV3xyMBWTTH6pA3NAkool
N7x+GY/qtgPlcQgcCvJ79FiaszmQ4tT9vSQ3rTQxL5V246IEXwRrhCS5hw3ZBSWy
hR2BRtQM4lxi2/s+fjq8u742DlhdRQa8f6QMLlUtEgYdPFVuAPyezhkJnNnW6dxq
G810PEFP0QhwcTd3dmZVy3xPBAixAJul/MPruw0RPUU2KvI2ohZB98iU2rLNR4Bv
8in838RGE7kQ3+ZXQiJ47Mk4VnrLv9BF3DvrOgmLHDqcHTSfGp77vrepzJnTCVEd
PcYtOlEtdiK0i84Hq+ki
=ul8N
-----END PGP SIGNATURE-----

--------------enig128A40B9E2E9FB3CC5D53A09--
