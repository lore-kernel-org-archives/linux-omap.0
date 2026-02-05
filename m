Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CB1DF258
	for <linux-omap@vger.kernel.org>; Thu,  5 Feb 2026 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318228; cv=none; b=KafIlPd1aPrYInQeTGPD+LAMsDlsohMP2vBCT5hOpLgkl168cr42NXAsMYbTbRi0WmDnjHwXG7evglr7hMfy8gmmCWYyYvlk5SmedLKkEAE5BdJYboGe6cxU85X81F9M3vHoKoueefmeH7FD7Thggm35J8gEgPk//YWrYiVaWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318228; c=relaxed/simple;
	bh=/wD2ni17a+X09DLamcGiBxtnqEVcXchS+9wo3LaM3xU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPfRuQlO0z56auSRJ18oR/KJEXuRlXqP4WdkE2KZ41Av/2E3Vy8K/Y1fItjPFNvgqIbW69Ir+RCWwEpJJBTGLTmEbO7X39EyOuU2yHfT9deP3axuHHlqZAgMCNsJkBGQQqEJ8azkzfi0Oi68eJeb/9gPhZVYRFjYymzoOapMkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw6I11wU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw6I11wU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so11935595e9.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2026 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318227; x=1770923027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=Vw6I11wUJ3Eeqrrfy2t1h+ZHAHQv8cWJ8syejGn4GrwNIaLYe6yjLPopKQUw7hMvN6
         6yei9QaaZhXp3TMBn0fx4v/9rGRdjw3r/ivhs7moo0BrxAv1BJ1R2YN71zVEIJJWJxKi
         ceNG1kR4zdVX/yCLnQKzc9wqOdZgvALsjd3j7rqkMD+tBdH9yToQevxwwn399wtjTRHA
         kjnIuzubD4jL/+QIcnVb1+pKKA8iu/SSackuOzJmZJFpHcE0BE0Yn7MJJmY7rCaodqis
         dqLoFrM+sG34k7lrYqKb+lMwLsZAGBVEX1T6IhQi2pwrCgInP/keTwieiwFXZKfpSvU+
         FO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318227; x=1770923027;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=P+7DovaQd+JhO6Pdj0keOES0/YSVw/SVlN9/DPGbb8O09FZsiRCVSSTiHzJNaVMacD
         SJG/a0g8SdgSZoj7+6v6JiL2h+hGeO9pqkXavxRlE4go+48c6Ml0vMhiq9yccL90s6Hu
         ahqI/lVnyrcgDRF6wJTyXt9jLpJ/moEc16NfII+PEgZmFK4ONvMtbNI5M0WXLtztRR1F
         SpOumvYmFTixvnd6RQ4MdbBVqwLDNJAWvv3PxGTrvjKweL+xJHl+9B2n4PCuA6pJANiW
         Kmc4B3r4zuKdWcDsmle44BuQP3CgxyRq1AG3wB8UmKmTeXU8dBn7Zc1YfjBOixO5p9D2
         ETlA==
X-Forwarded-Encrypted: i=1; AJvYcCWP/vJoJko0gvWXrxduh9SKfDRjRXzCFs67zkLurI5i5nfEz91ahSpzSXd/r8S8uW40+QU6q4MvyuIF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4onviDAqZbmukk2SnF/6N5Xm0wUb2rT+YnhvZ0hjj8BQELK1R
	YHoQexmmq7UmKfhBGijfcAmmksFGFqBIZmLVV9dz1be35nRw85wmtkkz
X-Gm-Gg: AZuq6aLI3cYK78/ecYjOdFS7Pepttv3f7xMnuef9VAFtq69DIMswh/UthXVDkqeCeFL
	M31urm7zka17+OCS8ZQ7e33LepukbU4PC+6Ra6T7h4cjCa9CQ2ucO4rAvBViLmXy5mHgbYpM1nj
	gXqVIlquCJaTOe9VYFWsHkUQ/eClhZe+GNwmDWx6zwFyZMUaaYPWV3Qh4dqqTNXg+W+V5jT6+we
	swVnYesRz5gjFYpKodVVOM43I46bS2zhpM1rvxC6zkvH1ug7pKZWWgXBEioDtR8jNV2ayoyXi36
	Y7W43XtYirMmvBkR4YtwtqNmb2TcUQsrEgYy/a6PbE51oY1g3xCjUAe6aYE+F+M7meIwmmUmwE3
	Bz96zB66MctBfDTzVZa5vRRQbBe18hfhgXc51BpbVBn9tes6e2uzRefR/1njcOCiUZk/hL3p7/2
	Fje2lY2jmnhJSDugu3Tchv3GiXY7MRgMJw1TtUyjHvrkinczn6am6juUs6GAf3chSUPRk=
X-Received: by 2002:a05:600c:8489:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-48320216cb8mr7006905e9.22.1770318226602;
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296c0f2esm235375f8f.19.2026.02.05.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Message-ID: <ddd1f32c073f155f61104ad92d4fe7de327ca11d.camel@gmail.com>
Subject: Re: [PATCH net 2/2] net: cpsw_new: Fix potential unregister of
 netdev that has not been registered yet
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed	 <saeedm@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Grygorii Strashko	
 <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 05 Feb 2026 20:03:45 +0100
In-Reply-To: <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
	 <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-05 at 10:47 +0800, Kevin Hao wrote:
> If an error occurs during register_netdev() for the first MAC in
> cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
> cpsw->slaves[1].ndev would remain unchanged. This could later cause
> cpsw_unregister_ports() to attempt unregistering the second MAC.
> To address this, add a check for ndev->reg_state before calling
> unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
> to NULL becomes unnecessary and can be removed accordingly.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index b9fc31eb06134dae33427eaba06341c39eb4b41c..7f42f58a4b031fab4c93680c1=
53383e8eeb8f7f8 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_commo=
n *cpsw)
> =C2=A0
> =C2=A0	for (i =3D 0; i < cpsw->data.slaves; i++) {
> =C2=A0		ndev =3D cpsw->slaves[i].ndev;
> -		if (!ndev)
> +		if (!ndev || ndev->reg_state !=3D NETREG_REGISTERED)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		priv =3D netdev_priv(ndev);
> @@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *=
cpsw)
> =C2=A0		if (ret) {
> =C2=A0			dev_err(cpsw->dev,
> =C2=A0				"cpsw: err registering net device%d\n", i);
> -			cpsw->slaves[i].ndev =3D NULL;
> =C2=A0			break;
> =C2=A0		}
> =C2=A0	}

--=20
Alexander Sverdlin.
