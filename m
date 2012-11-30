From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Fri, 30 Nov 2012 12:25:35 +0200
Message-ID: <50B8899F.3080904@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com> <50B74F98.2030108@ti.com> <50B8844E.2010903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9505916DAAC0D005FCE9530D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56852 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356Ab2K3KZm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Nov 2012 05:25:42 -0500
In-Reply-To: <50B8844E.2010903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig9505916DAAC0D005FCE9530D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-30 12:02, Chandrabhanu Mahapatra wrote:
> On Thursday 29 November 2012 05:35 PM, Tomi Valkeinen wrote:

>>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/=
dss.h
>>> index 84a7f6a..aa273d8 100644
>>> --- a/drivers/video/omap2/dss/dss.h
>>> +++ b/drivers/video/omap2/dss/dss.h
>>> @@ -143,6 +143,10 @@ struct reg_field {
>>>  	u8 low;
>>>  };
>>> =20
>>> +struct register_field {
>>> +	u8 start, end;
>>> +};
>>> +
>>
>> We already have the dss_reg_field struct. I think it's better to move
>> that to dss.h, and use it, instead of creating an exact duplicate.
>>
>>  Tomi
>>
>>
>=20
> register_field appears to be a more generic a name rather than
> dss_reg_field. Also I was thinking to initialise

Yes, register_field is a more generic name, and that's one reason I
don't suggest using it. There's a possibility of name clash if some
common linux framework would use a similar name. So dss_reg_field refers
to a register field, used by (omap)dss.

It could also be renamed to omapdss_reg_field, but that's a bit longer.
But perhaps naming it omapdss_reg_field would separate it better from
dss_reg_fields.

 Tomi



--------------enig9505916DAAC0D005FCE9530D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQuImjAAoJEPo9qoy8lh71cFgQAKa5tprsW2ATmSNZIKL32v+q
TxiqFNAyfHFuUN/9F9SLyuGFx7QYxawVasYNYNrVbHxwl82oC+4H3U6BmyhnnqlC
qCkq6V76jz8qxfjm5TVVLO14ed5SvQgJMXebEjWk/sOHlH5p1q7KYO47Bwbra3Mw
LRPeJzf29pOYKgd9OpPFpzUw25yXu9CtbJmAOoARYFQ1GV9Jy7XvVpvEq6SHoP7w
3yRl+GcA0jzMS3I9vo5AaWVSvTz5vSOYG2n2sUFimQKgiUK9L3dNqqFd8ZiUmXdW
RVAZnm2ppGsO/NN4qyWGvoG1RvUK1dY5wy5GXivnGVKvc4bKFEUMCe4Vbr7ncqKH
GpX+acArjO72KxRQMuN28xGITJCmr4LvP1st2zBaoMQZChmMt1kyh1PUTMZcSZbb
ZCN3Gtd27LyG30BuQOFjz6UGEi8yXAjVgZKGrhtHhcJDSUm7S+1rY25VQ2J/ghTs
Jgcgvi30cZwe+J8yKpHsTuKgBuOTy+vLzV/cBoz+Ua65WHvTBrb9SuhfdLBxkJqE
PgqQKJ0r5tbYQKN+TFOc0uIhBx1+x6LvJwj7Xpump/RtNwjfD3jtaWEErlaa0X6Z
e2lSFyjPk7oFzBVOxHnX+IdEoVLHSYSmmchPxZkJbbxePTgO6LcxFuqJ5VUeeqCr
ia7eLLnZZeEzd5EFJuPC
=Zcfd
-----END PGP SIGNATURE-----

--------------enig9505916DAAC0D005FCE9530D--
