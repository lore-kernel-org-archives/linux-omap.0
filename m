Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8C21D3D6
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081520; cv=none; b=O1sj/5lZdu6toG9gOWUZv90BVaMLEi7GPpOYs29nO3IXc0DEUK82gqNHgwdYhBthpTDM0MSezjTvU5yvmC2A//TCGqwxj8fzmVkDR62kpsAle3Me0gt1wUwHt/Jyw7UJlpmy5zYONypHKnmCFmDWBifxjgqLWNELG9h+nIiKsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081520; c=relaxed/simple;
	bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuRjfBVQ/LSfyOhPv7ZyeqDDX0ywE/YLzaeukTKQOLl1PtNyFSeRrpeUSJbka7HPc5IZFNi2soW4F2cHT6G18ZTzDcqFUft6avqjKhohLjVlIE5BLFuKhgz1hn79u8N493glO6RPV3h9d0QxNq1nwjscmoFd5ZVaM4jJGCTlUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcsWNEvi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcsWNEvi"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88ffcb14e11so70602056d6.0
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2026 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770081518; x=1770686318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
        b=BcsWNEvi8C4q4HxG/jdJRH5qkECUdovypl0yj1sm+OMHm3plkD3BXVD6WDxo/TOrw/
         5LAX1Cyh1VTzMMBZqbZmVak8cmTtvpxckaoq/mOFVateKUdZXY9OGGnN+g0uX3GXqtJw
         3qj7WkDecUH5R4/QYlb7tKn55uJBYfL/1ye3t5FGchmgnpxookoX3aOAdBfC5GZ8hRz2
         850sdt6ksKwttYmMLdrBENCneXbhzbQUgtAOwh0R1HkXlxPP71KKjKbThlEyqEwvr0Dp
         KDb4+yYraUp91J472JmlL1p4HVWPCQ3g0NPLf4RnaexUWc2iEak3jX4ISd6l2H/6mf2H
         Klew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770081518; x=1770686318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWut4A5EvZmuf8e29UygC5BAvfCGnf/3txOaKO7qA4s=;
        b=ASDc/hbT2hUy4oE7UiyFQ2eRfZnhK1bJXKA+cN/hl1R2jzyGGg6LBkm/+zUgBXRzKl
         4+W1MEYTdGNOYIaYnwktm7PPDXr8+yokHS76PrBpR51s23X1TJsiC+k2RTEEMdOYmMvI
         nbVZZCEhq27E7Ce5ait3J3fOphxj16UwAHjLPYOnIe2ZC3WyRDXxKgkw3exOhMGK3r9s
         1Cbd/Kjm2Jq6XGGXAccdx8N0xOrt+aomL1H5xXWhrs+Ug4DmTxOzQ7ZCY+pWSBvpVzeU
         TEw1Yc/v+kqM4t9BAQJNZt36oDKMkH1kXHP+dqzOsEFGWo7bNf0Wo19+dX7WeUuJKe+Z
         bO6A==
X-Forwarded-Encrypted: i=1; AJvYcCU94WkM9E3VDm1HCvJVObo1MUcjeBTouFYR4VQ8nnXnRr0PvAlDLCgAvS9faND7/g3dWaQqsQtVgjZU@vger.kernel.org
X-Gm-Message-State: AOJu0YxrorvFwWttHc/3Dsy5X/e9lM9CyHT7nCRCRlPGKl9aS7ZqF7I4
	Dh4zGhb7YxZgMbioL09NsQvqtBpj2gkHqoxicAsxSqFPs0+YF85820lz
X-Gm-Gg: AZuq6aL0q6KgdSunUEJv4+i2AOwYPWR/LV+zBzHpCJ8kutFSrRd+V+Un8SaFEyKi/fo
	QP2tRGY1jNT+GpL5cMwon5ufZIJJKsTWeDtrI4GyNKE+eE8hpGZrnF7XpIg3HeLc2iF0DDF32gS
	n3pBrt+VzYz/Ax5frhe7fSKVTI8AMn2jY5q20zt4pCVDYTKcmq+uDgBWVKev/6mcni2yNJ/42Um
	9Woz17rr38k5KyI+ksCpnJtmba6pl5pVCuCoFa9WUScegFFIApKfnuDa4ua2F45PBX05mr8Iy+J
	YBDascatHFD+4C6ulpzVuhPySt2ExMJWxBIl6GxZOKT5a55+QoivjsY2XE5xVmKiMFzbzmAvrK4
	xdz7+j7B2eGQKX5rPA4DHQyZgdiMR2HeQ89BBFG85C8hXr8v3ltQGmrhbzQKgapG+U4Cda2DR58
	+eSFLyGjM=
X-Received: by 2002:ad4:5ba2:0:b0:892:6f12:608d with SMTP id 6a1803df08f44-894ea0974e8mr209720416d6.57.1770081518206;
        Mon, 02 Feb 2026 17:18:38 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c789sm1347330885a.7.2026.02.02.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 17:18:37 -0800 (PST)
Date: Tue, 3 Feb 2026 09:18:31 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aYFM528IM43_fXwP@pek-khao-d3>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
 <20260131124120.744bd931@kernel.org>
 <aX6pHiB0tk6xvrCX@pek-khao-d3>
 <20260202161918.54be9315@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evuoqMsTIgoryhj6"
Content-Disposition: inline
In-Reply-To: <20260202161918.54be9315@kernel.org>


--evuoqMsTIgoryhj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2026 at 04:19:18PM -0800, Jakub Kicinski wrote:
> Unregistered device is not freed yet. The netdev is only freed after
> .remove routine returns. Passing unregistered netdev to netif_running()
> is safe and will return false.

Thank you for the clarification, Jakub. I will move the disable_work_sync() call
to after unregister_netdev().

Thanks,
Kevin

--evuoqMsTIgoryhj6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmBTOcACgkQk1jtMN6u
sXE5SAgAsRYktD91exFTnCzTnSMkl2UAj6TGHGQCuhocha2Imq4TEFNe2b1XLHjL
SPzZa6eCURAWHejBF596fz6WepH2a4RZKOj6DWudDj3QAAZA2gmGVSgDdVysjgC0
B+Ov/P2avXJWTKSrfTu7ZRNTuG1dfRHQ+x4cDfHHG5mRWxGIfafTYeRh/k7Zxt5T
lTuwy6+dECR1xM/H22hLhjxeLDUhIbXs1jrUgMLgJBG+ZTQWHAfnIRTF7iAbb0MG
T2y3955RkOSDMSVqjdn+56i2Algxme8f95Nl1iYgBz99DPaNIYTKsVxLj2ofET/K
oHnc/ESoacxGy9ssYMrpokOI7zH2EQ==
=Rrs5
-----END PGP SIGNATURE-----

--evuoqMsTIgoryhj6--
