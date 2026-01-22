Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7D32B989;
	Thu, 22 Jan 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070963; cv=none; b=lgJl7ooq00aCjX7g/frAleFcgSQhuTLCFgpcZ71ZTNEVBVonOMnYCW5luKjmol/VRQVnoGoC2BlpDRQ9mV4SbNI+jJbexzUq4LMgcjMJMPAvI8YJFXHZSVveS/yhw769vr67FetEnp2mlSQOLDUcJFXwlMIEE3pOh+/rr7pYmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070963; c=relaxed/simple;
	bh=Ih5VK0llCIIo1wWnCgn/idvKk3teLaQ38xVomYRRVLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6QvWq9f+QQDA1y9xXMpV+L7PvVaTsI41JR3HlBMiBKsLuiBcQcqJktKidtN+eW11HP75+dadg1qWF7PWVtPiec+KTHpA7fjzKjbX/Mow/mVLpII69OvUeR/eL7sRwds0JAzMDDC1ZGkCffCZuKKt15boKzOW59EE0E7dfawIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=YOFj+6AF; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YOFj+6AF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rkGkEQ5UYyIH3nl6X1hT91gZ7OBhIhoGTUbfAZlazJ4=; b=YOFj+6AF+5isK1qXeZldHph4bT
	UeiLKM/nAPcB8IIU9zeCqOFiKEU/6wfPcF/yFMu6lpFZxIn6pxjLvgwGatQHv5zs5bEFq5sBiJpV3
	maieDmpRdTzhZljtWnyBCHE8RzevGR7ZpMWIcVP0bptH5ozkG4p81AXd93yCouw2LT34aIT/8+rSg
	L394L+H6fMBXgCtZmYouTGCxLwo1LnVBP7ZKR+X9a05llT8lt9uqwZRqQFPIoujlr4roN+eIHiy5e
	OebKxYXh8Q+xx7C/+86yOl/3Hu+RjIwVH3AVg5A3v1I8I+tR1SGwxiJhc2hqOoegAGXHX+5ikTy6U
	eILP8Cag==;
Date: Thu, 22 Jan 2026 09:35:37 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, khilman@baylibre.com,
 rogerq@kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bus: ti-sysc: fix reference count leak in
 sysc_init_static_data()
Message-ID: <20260122093537.253592e9@kemnade.info>
In-Reply-To: <20260117062235.435174-1-geoffreyhe2@gmail.com>
References: <20260117062235.435174-1-geoffreyhe2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 06:22:35 +0000
Weigang He <geoffreyhe2@gmail.com> wrote:

> of_find_node_by_path() returns a device_node with refcount incremented.
> The reference to the "/ocp" node is acquired for a WARN_ONCE check but
> is never released with of_node_put(), causing a reference count leak.
> 
> Add of_node_put(np) after the WARN_ONCE check to properly release the
> "/ocp" node reference.
> 
> Fixes: 5f7259a578e9 ("bus: ti-sysc: Check for old incomplete dtb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
