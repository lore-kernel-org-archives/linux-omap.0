Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0853F99EA
	for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974936; cv=none; b=QM74b1/OVYL5DtCZgGXhB2vnQKr6JgnNp/5NU+kV1zw4TFbp7fncxgmnQS/99yjuNamsW8T5JEDmUaeFzfvNssveOuMKfZkRdGnjfiwsWP9mdNC2eD6YESo7ETQZe9WTemnuE3sxB2Ye1g4NKDMhlyuxhjEDhCMAKCVepGYCU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974936; c=relaxed/simple;
	bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO5Glh1056v/ERGX8gz4JcrlUu8ChamtwrzlNhR7qAL6WSuEreybeGBzZbOE+hTZQ0GJWsaLSppW1naBB9uEGUGkersl0QYJ8qPpaHo77QaXt/oRAv2SBP9WpiEhHkR52nIbE6EoV1IWu9yKYhD6vtLMjGiep2N32pi8r0OTOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZDUEejj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZDUEejj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb439299so55456325e9.0
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774974932; x=1775579732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
        b=WZDUEejjZTpysUBuNNYi6pcxa12xcPmm0szUvXOrIkeJPS1C0a5e6ve8JZtJUg+ENH
         CjEefej8+ntVZIdeWFvQ17sfBa2bf1qrt4KAlEc2JNI7I9HVeqhOMiZ9hEhr6AgVHsc5
         6G92LzW+Ow3FsBOuaN9FfQU/DUi6PMPfE/MU0kD2KxywqoxXgSDYanhQNFdIr2IOZp8b
         MR5wyXM4oup2JnmEDNAe5qi+9nbniUqir6KS5WXdSqiSgCGVc3tFdyUmsmXEMPP7A9gj
         itRIPFMS2jiLIgOoN0MeH0FPJ76dob9RXRub/Ld23tefw6f1EfuSnJUcjPCCWtJayfi3
         C5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974932; x=1775579732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
        b=IxHKQUBFJkjp0Fys5K4Tu6qhes37/k720ovKiyp/e8evoFuwk9wXXSawTtlOMbEZQd
         Ps53NDhF87xnOL1mQp5st6QIuX+6d0vg9EEuyYElSeR+VUltpchAjXTEinrpYL8dN/o7
         lIlI5/XV3kkcaXKH/n3RG17e0VQ7cyKWqWE7Yf8Bsi+7UjZEqWZachEboPThOdJ9VTWk
         WlsjUYULvP5vGCyCpKtAtlapgkQedOWVIkxG925W+9gs+6YBm7zd3Hd7N01hmZ6Yn4fB
         YC5anh/pOl3bUQFesb7+6jdSBaUEGfYjp/3UwB36ppVfj95jlIW1Z6+vtb9znxRfdjBE
         cmSg==
X-Forwarded-Encrypted: i=1; AJvYcCUgebkIGc8egaxM9A2T8n/W9WfO1pU5x6KimDJID7Jqj4M6imrrm2qwAiuzoYB2Nnnzn1M7Xv3DRGQy@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzAiGWSRQm4tYc2JaVjdhdjWM6qQmCdeuYAjChPf6P+uUIoB7
	3ElL80oZG3ElmAEmzvj1iaP7FWf9IUtBDB/1IEgGje1gx0+znZmYz9Y+
X-Gm-Gg: ATEYQzytXyM4L/WlhEtD+b5wrWtFH6cZ+nGyJwoYUGRynuE4KoYVcm4EgX/8khqZFSj
	15kCKF9pKEJIrdpd3Dn/vdCzdEmSFfzjStccW2EBfY3+4fFxDZaWXsiVBUWuBTR/PIfbP7CZdRB
	jaGpSBhDwTwDIlbO5zaJkBIUXxZJ3eg42AF/ohJCRm5Wlss5xkvLABsLfTtBj8I86a9/nkyh4q0
	nOcwECPmSj6vZndN87psJhPyKxvZrAfMgmLthvwSr5af4ZeVRIcT+ZCoSaaIP7fDccGJqws3L64
	PHSu0AmZqtXKRGogeolBffmpU8gVVUZaG82Qtu9UZfNi0Ws5E2QeYWsMmi+4anLncv/AURYIlUv
	QgW6L+UV5VQuaxA23kzCajSb6H1znUGtwUHQ6qllRV7m46647Rnjoz4JVPCj+VY2Rm/SDVsuq9m
	/0A408hwF0X03uUuK+rGNX/jb7k7G7qGSNoLQAFR54ZAG89Iovk1kT8NIK7VveynQWY2rXWQXQW
	IJTxtE=
X-Received: by 2002:a05:600c:8b08:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-48883572159mr594795e9.9.1774974932061;
        Tue, 31 Mar 2026 09:35:32 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc5690sm34964075e9.2.2026.03.31.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:35:30 -0700 (PDT)
Message-ID: <db75d50bc333635e3db07a2ce0f3e23a5f62c3d8.camel@gmail.com>
Subject: Re: [PATCH] [RESEND, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Murali
 Karicheri	 <m-karicheri2@ti.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Siddharth Vadapalli <s-vadapalli@ti.com>,
  Roger Quadros <rogerq@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kevin Hao <haokexin@gmail.com>,  Saeed Mahameed
 <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 linux-omap@vger.kernel.org, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 18:35:33 +0200
In-Reply-To: <20260331161814.3725730-1-arnd@kernel.org>
References: <20260331161254.3450606-1-arnd@kernel.org>
	 <20260331161814.3725730-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 18:17 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> While looking at the glob symbols shared between the cpsw drivers,
> I noticed that soft_reset() is the only one that is missing a proper
> namespace prefix, and will pollute the kernel namespace, so rename
> it to be consistent with the other symbols.
>=20
> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functi=
ons in cpsw_priv")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> I just realized that this patch needs to come before
> https://lore.kernel.org/netdev/20260331161254.3450606-1-arnd@kernel.org/T=
/#u
>=20
> The change itself is not important, but it renames a symbol that
> gets exported under the new name by the other patch, so either
> this gets applied first, or the other one needs a trivial change
> to fix the export.
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c=C2=A0 | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_priv.h | 2 +-
> =C2=A04 files changed, 4 insertions(+), 4 deletions(-)

--=20
Alexander Sverdlin.
