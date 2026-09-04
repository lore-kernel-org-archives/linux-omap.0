Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD874252D9
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511604; cv=none; b=DaKhy0oC0pqLAfecgGNxXJaaTJM7a+GnRuhqglzrxrMQhDJ2ijMf3twUCdYzc0YomeZcHKHJY6BV9bzOjyPzcbWO+aF4xRA+d6cTp1qmuUyZlJzveLHV4S5BD54eT3rw89j4Ca0p57jiZMTQ1g8SF2Zsuqkcec/XnW7yUwPtalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511604; c=relaxed/simple;
	bh=cK94IKlqhf+KSiXCOXmUUVYVH6V+FLjLnFGKVNUKndk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKOVucGIbmZw3zROpfIxp6xWaIYMeWsb6RGqgyp/6eEroXnLheDSDABngy1wc4AesbbUcNoSc+u42TCz7Rle/c98UeXvqdQsKdFfc5TUw1LbEeJp1EtXo5ML56HirkwaRoMwVaFSw//y6+QBwyeL1qFs2irDa43a6BqMkETzEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=erTyPlOa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=emUE2333; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="erTyPlOa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="emUE2333"
DKIM-Signature: a=rsa-sha256; b=erTyPlOadn2n5wEvJNmpHAX7iVnmfvhHd1xPvZUF200nqZM/8yLQDkemlNregyx1/gMRI9Mo+8L+pFOEsYmfbKuRVof3jMklf3cNP00e/hqCpwQ31p/4lIPCTzl4VuNwvdDiyUwB6ktccVJ2ir3APQ/9ize447ARNbCsWIZxZNS/tZ4kkSTxQkbb+XuSJU8EJZS2N8l0hLGQl6Axx0RB0g5pRt24UK77e5rBpROeEYhYGQUHlI+nrf8ife4P78zFwC8ykQSmGDNuuCA7SJLoxDZFdAoAoKkivTgLXae0PhJp59kQ5cB7srXHn6/ot97TBoHqm5E/nFtN6GYaeG6V1A==; s=purelymail3; d=sverdlin.org; v=1; bh=cK94IKlqhf+KSiXCOXmUUVYVH6V+FLjLnFGKVNUKndk=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=emUE2333r5d2p5UZBH/+657V56uf1YnQAwDZPws4BMgjuwENUlHtslIAsJ1RtpMJEK3/iMDg+vahp8O3cPvUJc6Z8zSRIjzaqyv2TeB/LdqJ3OTYi+aPumfxg8/KY4cTH5ttK53KEEhSPhBoyZAroMpjdeUpwN2WJVZr7+r5Zbpn9dw8JOwDOb1ouEOpe5mEluTiVgbiitD/UG2+EgX9i0Psz5dC2RHs8DHj457/7GUuOz/2LoOdlOxZbUmpfKvCfzk+xQlfDPzc+4CUoA2cnYy3KBYvCNcTzcaoFOrCJKXlLonSvsag+P+qfoqR4Iovronp6qLhByUIYOc2G8mQ5g==; s=purelymail3; d=purelymail.com; v=1; bh=cK94IKlqhf+KSiXCOXmUUVYVH6V+FLjLnFGKVNUKndk=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-omap@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1796872009;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:46:33 +0000 (UTC)
Message-ID: <0f63a2c13222d06ff059b6d2d0bd916b3fecb33e.camel@sverdlin.org>
Subject: Re: [PATCH net-next 26/33] net: ti: am65-cpsw-nuss: Remove comma
 after sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Date: Fri, 04 Sep 2026 10:46:34 +0200
In-Reply-To: <20260904043724.2955444-27-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-27-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-04 at 10:06 +0530, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ether=
net/ti/am65-cpsw-nuss.c
> index 6330540979d7..2551554add17 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -3506,7 +3506,7 @@ static const struct of_device_id am65_cpsw_nuss_of_=
mtable[] =3D {
> =C2=A0	{ .compatible =3D "ti,j7200-cpswxg-nuss", .data =3D &j7200_cpswxg_=
pdata},
> =C2=A0	{ .compatible =3D "ti,j721e-cpswxg-nuss", .data =3D &j721e_cpswxg_=
pdata},
> =C2=A0	{ .compatible =3D "ti,j784s4-cpswxg-nuss", .data =3D &j784s4_cpswx=
g_pdata},
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, am65_cpsw_nuss_of_mtable);
> =C2=A0
