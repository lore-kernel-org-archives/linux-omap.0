Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B64AA038
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006571; cv=none; b=lrbybSmyH6e/KgEtZTyDIIAzhwgmoDwb6t/V4K8BIqLh8pLhdzD14PcHao22PJGyObjHu9cNKzwR4MadGpeWHpZnYZOE9iSwvANLQtdZtnJrJ8ULvI1MWGBkjIq8L2F33Z58dZs0h1PmqkhNgeAiUl9AxW+7VOptuQECn1Uk7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006571; c=relaxed/simple;
	bh=Ryakvez2AuPrHsciT1nsS1VZjsANZaRlT0oLyFD9r08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NqpkjpNrXWqDomHLchl9pLlcEtFSi+bSL9PYnKRkZd3ZtBr5EC4x7/0nzMnYjkCTTGCCBaF5Epwoaa2qBGYZHRqACogsSAYC+mUYp9WNtVK+T3ZYKGMY0CbyStSDB3l/C2xPGsk2eNeWZP85lhg+VeNe2XsPkCuTbdX6nZovGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L7bllr18; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L7bllr18"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so3003297b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790006569; x=1790611369; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKFRVCGIKTeJtMXkPmTO6NVYkX101OwB/yBvUY5h+ko=;
        b=L7bllr180MY+bK204YggwMGeo8DS4KcWI3LbqjGLDBRtpJ3HSzqmoR9SVVFL8BQoj6
         NfNNLx3sc0brurecgqfH+5PjSpl+ZEeKxl2cLBunbDgvZGX9CpqNxlgz1lpWIUMEa0gU
         xFhQI2l3AS0p47kpFmENPmycx+a6DhJeP3HzDGltZ8w9JkVOHIyTG/9gf/a3xDSjYdWm
         0EwX8hGTVEp27I99tF2Y8ms+eO7YIHqXJLju5P9wFI+oXcAThL6ZaiB4PRHiI/BBfIWX
         kicu0fA7urX19da4rUzJs2JIFh9Q+xaaEN2x1pIc9wnRfeXufZtmLrGuUGSuzQe4GYG9
         3U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006569; x=1790611369;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKFRVCGIKTeJtMXkPmTO6NVYkX101OwB/yBvUY5h+ko=;
        b=lmycvCtyeaDzmshmA1/ZYmQtyToEkZvMaZtpRw8KH8aUriYJYknQpPBigEFTgYltvH
         sLEctRvYtpHO3N98PKzMfUxOQFd3mZneC3a9PL32MGOZve7x88bMPFqkDtPB3wXBLo2/
         jENG+4XcPAlN8M5JDi68Po5cAjj4zvMWXT45SRrxxXDZERz/FWkdJlsbdIKbk5oyrmKc
         T5B+GMNcMsUqm3lN8CXD3KG61hTA6gaxjiYeiaXBJr3rXcrJEhqZfcFRs432qMrn9BDI
         iqK/F8bDOT3uTJZ4RkFhl9dKSY129aiNGdTg2Mt5V+T/mWRrlmzFhsGmRLYul98SLoRo
         yiFQ==
X-Forwarded-Encrypted: i=1; AKwUvByLnf29ByJNSwPfgLskORNGG0Y+DASgmorCDFvDLaJXcZ0/a926qGcYt+V40DzcN0auBzsQTDg3Oi3O@vger.kernel.org
X-Gm-Message-State: AFuF++mCh6Tnv/iJLDVikw8hj4cmov51ohZLzekXoDvcyyOiHwlHTdmL
	2dNyq22aycqH+O9j7U9Qs7laCKfnd1KeEJ5CsOuB092rrJdpwVMAlFCADjTEbx+PkoM=
X-Gm-Gg: AYBFou1UYMHEEsNmyXrLdv1tDAksNynlKXBEhBMAtQNu1dn0F6XEzlzjSdfM/obl5fw
	1dqfTNk2mpua4QYLt3NqRJO91njiTjS94w+PrPXdVGt5IVMfpogMlHlrhYhYLtbjzfqv8E4TUzD
	8cRVHNN4bUlW27Qo02zJ2tv4ktiW1zJbdDkB1AJKLcSPaUFJxcIWVJF30MfRoto0y5bhqdm0lA9
	lZG3K5tA2BxRhtS9o70tZkndY00KEcNgKM1S+IEk0RqCUWb2+vsqHgtPblG7iaINKVGOUT9Reo5
	xxaFEvfvfvrPCz4aMH0iUjqilw1rLHdunbg3vBfMzlEdmSajgIEWGdMlYlBUnEjFKGUGVOd+Y86
	p0zlf8oo7u6LrmZkVqiQrjCgoZieXZBh5FbgsoseLho0ta6MSmo1Gtqtj2MfPTQ0xc33vp0OKTe
	v28OvPDKblsE2Atu1GmYKtg3CafIHSCLaAlmm4hYo+cweqc9K2xy3zj572CueIP/75fxw=
X-Received: by 2002:a05:6a00:7702:b0:877:b053:2e10 with SMTP id d2e1a72fcca58-877b053372dmr8630049b3a.9.1790006568844;
        Mon, 21 Sep 2026 09:02:48 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-877aa1099e5sm3480526b3a.49.2026.09.21.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:02:47 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones
 <lee@kernel.org>, Shree Ramamoorthy <s-ramamoorthy@ti.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Bajjuri Praneeth <praneeth@ti.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Kory Maincent
 (TI)" <kory.maincent@bootlin.com>
Subject: Re: [PATCH v6] ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by
 increasing vdd_mpu voltage
In-Reply-To: <20260917-fix_tps65219-v6-1-0544b735edb8@bootlin.com>
References: <20260917-fix_tps65219-v6-1-0544b735edb8@bootlin.com>
Date: Mon, 21 Sep 2026 09:02:47 -0700
Message-ID: <7hwlsed23c.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kory Maincent (TI.com)" <kory.maincent@bootlin.com> writes:

> The vdd_mpu regulator maximum voltage was previously limited to 1.2985V,
> which prevented the CPU from reaching the 1GHz operating point. This
> limitation was put in place because voltage changes were not working
> correctly, causing the board to stall when attempting higher frequencies.
>
> With the recent TPS65219 PMIC driver fixes that properly implement the
> LOCK register handling, voltage transitions now work reliably. Increase
> the maximum voltage to 1.3515V to allow the full 1GHz OPP to be used.
>
> Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
> ---
> I was pinged that the following series was not fully merged: the devicetree
> change did not land upstream.
> https://lore.kernel.org/r/20251218-fix_tps65219-v5-0-8bb511417f3a@bootlin.com

Thanks for the reminder.  Queuing for v7.4.

Kevin
