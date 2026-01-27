Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0F25CC6C
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498216; cv=none; b=DbcGOA9uQvegdkMvAQqORjqW/kTgd5x4eUjsdeF1uaKAdBWIzFGgTpXaudNGxB3SFLsLiAJ1K+U11z81EarsqUM5S/HgKdHolPbbVmaRSgkdnsfICdAP0BbQ90OiwjYGYljr2/6TWCVQKYtPexbUAJhL1/cmgBzILXSaEv5N8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498216; c=relaxed/simple;
	bh=O4lpA3jRQGFJYxvQ864WpAw3jPoN7vazpgZMK6tCcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk0BEbumsHMW0EVhHzqM4Cuqq6nmnnlcf6mTp+OxGWGDMAVsdu6AA84hCz5oQL3sGDTeSaC3Klg1NF6rx7zMOvhxexPgtUsHGVKECxk2FnSt7+iP+fW9yzsIXk9bFHNovPJprFTKifC22euMb2k6BagNmtP+NOB9U8pCa6XMY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uat+wywh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uat+wywh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8947e6ffd20so66923736d6.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2026 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769498214; x=1770103014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=Uat+wywh6aLRwm8ft90sDzzOzLf4S6Z8fc7BN0u/rjchl6joFaFsDg4fWkhWOzGRp2
         orgYgFo/oYpml7p/U5T2e6PVzFfDP8bmuEguEGA90bIshogjG9StvvAWhQTZAL9aA2nD
         LzJCgOVNEt1HerYKC5Rr+u4m6+DcRbyeFFRszk5+qMULGM3lB3DMDcVKOLIJeyXsqRDI
         TCl/Vvhc1p+Td2kw20RTYadDWeVhMVhcSxhpLjZOSchxBfJ4iZHAvxLTCVaZAwdtQ//r
         qZ8PnC2wtVcQpiMb7bQrrJnQkUNRip2Q1hih+7D4R1G8E/Kk3whCHJvQM7cz/Q2T3fa+
         p48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769498214; x=1770103014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=FZo2EioAqMuh0KB898zm3/vdEFOddKrQQ2pJV0SBBZ9DPBw6FBtyk7VCY4ijKY496W
         /tXMiEoomx0TruvBbkNfH1YgeJtao+mE9xuJuSQB6ndsVFjXeGxXnQKb//D16srTUtxQ
         7M7Rc+b5EQMEHxnhhCNDVCh0bhp4B9HIt9mVSe7BMIfeq/ALOqYDrT1H+PrXJsYCUHV7
         xglI6hj5OS+3d1b+lDKYJNOEiTemxpyKSNEIEyqJU6Pr2MHh+DEpmcCPeagMVoN/wF7P
         y9rGbk6pazXvkUqZnFfMW8JyWSZpcg2t27c11SX1G8A7VrfZd6fyQkV1a7up9PHD83L7
         ojfw==
X-Forwarded-Encrypted: i=1; AJvYcCWWWkwmza7kvT2gQHGIvUsYL2QisBZbyKJxcNX23N0CgX9gUPowC5FfnSc+/ZQgRhs4oOJoA6hxk3Vx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjURJ4Y9bjn3YDIZtPLiXYSiea5NodlIGOgjEcBicKvCTTB5N
	F1DfvUPW2WuvO9tSdV068Q4xCNN9FRV6uYXKxGrGALYjWWcyLF8oa9Sz
X-Gm-Gg: AZuq6aIfOkpCevg7YToLEoauXa3rSwjSg7l+QPehhEZ6532Yr8a207BdqRmAgz0Zqz/
	TP0/eiSLWb07sO3RDacQYETosols4lbhBoIdZXa7tZXUNG2MdLe/70Jz5ZZz/eUKP10zekcPKH6
	1/Y8Vxl+FKuo9PWxkBsiHKoiMImAICIzZTEGH4M23fglJXNjoKWqD2Z/D+81UWk0Jg8SvQARGfH
	5omfNGnc5cwAnjNLmTHy2kufz36aApYe8DS8jcag6VGt7gA67PbQyk6uMs97UNC9EURFiGId+Y4
	xVt5SmZizywtDji0oL1qNY38vPex3yJce/BHQ3T6H5nv0kQrKm2PjB4kt+XNxZ5iiV/1tC4t+Wf
	hdHMJiJIFlLZ8ytrct/JaUgxMtfAJzXYKIF/5V9lDz8ygH8cgw3fJrKm609J6hckldRc0ddUL2I
	F0zj/R21E=
X-Received: by 2002:ad4:5b89:0:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-894cc96202cmr9307226d6.61.1769498213952;
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c823bsm1221262185a.2.2026.01.26.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Date: Tue, 27 Jan 2026 15:16:46 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, andrew+netdev@lunn.ch, vladimir.oltean@nxp.com,
	s-vadapalli@ti.com, linux-omap@vger.kernel.org, rogerq@kernel.org,
	stable@vger.kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net
Subject: Re: [net,v2] net: cpsw_new: Execute ndo_set_rx_mode callback in a
 work queue
Message-ID: <aXhmXkWqrMOTCgnH@pek-khao-d3>
References: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
 <20260127030556.3839208-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HTNmXs20Xq35qd8U"
Content-Disposition: inline
In-Reply-To: <20260127030556.3839208-1-kuba@kernel.org>


--HTNmXs20Xq35qd8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 26, 2026 at 07:05:56PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thank you, Jakub. This is indeed a valid point, and I apologize for overlooking
this issue.  I will send a v3 to address it.

Thanks,
Kevin

--HTNmXs20Xq35qd8U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml4Zl4ACgkQk1jtMN6u
sXGOLAgAqOgEQOMZa8O38ImuMB1qyHJitTRzmWCu6eNKkTEuHm525osQVFQF8YJr
9sjzpJkJwYkpASyr0O15t5VQtwhbO43vU8HTS1JldIzSaDnQK9yDWO9cuqDhn6VP
aOp5aLuActYM6GfK8jqWQdgEn0Pz+xpBkryqR5/4IRWfJu5t738w/E0RBU7wEuZe
OM7Z+DIjEkwHea4Kijt+8vTPUhawi+cKoqibQRX/VRz5Pre6ujAdKk5WgZ842rsn
Sn37YqLLr65A5VPS3sR6bv3VkY3oT9RMVkckVJXlwllQp7VkDDlt7hD17d4yd07p
k6HK2+y0OqCJiowbPJGs32qiY7ow2w==
=v8L2
-----END PGP SIGNATURE-----

--HTNmXs20Xq35qd8U--
