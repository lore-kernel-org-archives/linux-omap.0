Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A133EBF20;
	Tue,  3 Feb 2026 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077959; cv=none; b=B3MM2AhzhxHLIY79v0ot3UhMG61P8MkDvUiol7OuGB0D0DqWydausRue0ZD/0Iy0spt8ALAywcTA+WQEnXQbSrtB33DpgID14QUro8zJxtB6CYkyHULp+vBmhkJ3yqCtoaShrvFwjSFXeUaZQSHstclaWXaQUeHsw3MXkAEjWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077959; c=relaxed/simple;
	bh=YMNgpnEGjm+gg7Nz6teuJsSe1HjgDqcT2PQKZKmPfyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qK+n6O93Xt/DOwFCrvvZyyNyX0OAlBJ67m1OXvFTG3FPkxrVtCig4cHSO9nsKzztk3KI14lj2Yp2svVSshwqPXarFVfUI4der8HxJ2dLoce7ZjUz8HgZPLAP3EHyRc8y9xAt/YqqU7qp9YX2fCf8TSw8dk1LP/3S002KD2K6JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZABljukX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZABljukX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F787C19421;
	Tue,  3 Feb 2026 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077959;
	bh=YMNgpnEGjm+gg7Nz6teuJsSe1HjgDqcT2PQKZKmPfyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZABljukXIonFYNzVstgw96MQtBL1Ly/75a8BPgmqX3JA7Yw1sl/5FGwJygkia39Zp
	 nEsS0gkqlZXnLryeXps8HqV/KEGhI7+BnmOcG2aQpH2/6m8RnAYrhIa+Tj0WzKLe9v
	 lFrtSkqhnllbj8RyWL6WmbJBPPWuxq08YvYJgWWcdlxmv6q71Qwvq3zXQJzJcpCzex
	 G/JgrwFPl35pYyghUrlcLqDUXW87Bq5uEuZpZiL0fB60AO0JVtQrYGgeFgMQC33KoL
	 bqFQ92ZRFyWf5Cpj+/8ru9xClDjjLqxjfyLYis4h9wMZDIiqdmbOFtmpSpQnbJn9n4
	 R3cAcY2Isum2A==
Date: Mon, 2 Feb 2026 16:19:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <20260202161918.54be9315@kernel.org>
In-Reply-To: <aX6pHiB0tk6xvrCX@pek-khao-d3>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
	<20260131124120.744bd931@kernel.org>
	<aX6pHiB0tk6xvrCX@pek-khao-d3>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Feb 2026 09:15:10 +0800 Kevin Hao wrote:
> > > -		unregister_netdev(cpsw->slaves[i].ndev);
> > > +		priv =3D netdev_priv(ndev);
> > > +		disable_work_sync(&priv->rx_mode_work);
> > > +		unregister_netdev(ndev); =20
> >=20
> > I understand that this is safe but I think that more logical ordering
> > would be to shut things down _after_ object is unregistered. =20
>=20
> I'm a bit confused=E2=80=94are you suggesting that we move disable_work_s=
ync() after
> unregister_netdev()? If that's the case, the scheduled cpsw_ndo_set_rx_mo=
de_work()
> could potentially run after the network device has been unregistered, lea=
ding to
> a use-after-free issue. Or am I misunderstanding something here?

Unregistered device is not freed yet. The netdev is only freed after
.remove routine returns. Passing unregistered netdev to netif_running()
is safe and will return false.
