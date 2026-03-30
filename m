Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6D3A1682
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905248; cv=none; b=I/NYKJbqkLhwGvzsXSWawOjyqF9w4A+DAFHOOgbnZPR+8VTJdPZh9AbUmhfbPFWqO6lsqcky+fAiHF6WZPH9YIchDaDUPJ/3/6qDIYv7DmTPZa8RYg+y9SSSkafPt1q9Q8N72qUPej6lBsjhkBQ3NUW5nNtnhlYR7nTfDhT6w0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905248; c=relaxed/simple;
	bh=5pooe8akLgHWo88qYtDDC/7ED3+Zasl35vKrSAKLMUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BaN/JGv/xLyd+j9akpfxPsTodEpaL+GnYWUS7z2jOI2yqe2cVg9V8LnntBIgnLoMMuNKaF1A9HWN28YRDcFiCemTO5Gki7UNPDl5N1+MwHAJqcQtKiJcffTuYWef/LLcN1UUyd/KCNNZCL+fJFVaCbqUeZVoW+EgkNSrSPk+AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e8PkOwLD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e8PkOwLD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab232cc803so23744275ad.3
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774905245; x=1775510045; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=itki3S53hN5ghJ+TbLPQdNLhKu/I8y2gwGAHgQqiXFA=;
        b=e8PkOwLDSZGU6YRo5IrvgqWM9KONmv5IER/GNo22e4IQE2ZHZ6yd8LkwVoXCeUhfSE
         2EwrN+9lockx5OQpt17JzdXscXDSEzaZy0pDDGWmV5NrMMP5Y4hRTLAP4Pz/zHCV/Hj0
         4uFPOfrxU3pbUyAmaQmodIwv7sPJ8dhvtO/iRP3yltYMtBX21Ce/bnJdPvJm2LG0JpkC
         OqtUKKpk+xmYIK/CcXqaJEPmvjuuty/TN/cXNrRX6U/xKLT0MjHf5LrxzeDAImrpi893
         HLYWDsUZ+ImOPwt8d5j0LJnjEKS1nTBQCh8KR+C+Xtq26hrROzuYmME+wgvkanxT44qj
         XUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905245; x=1775510045;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itki3S53hN5ghJ+TbLPQdNLhKu/I8y2gwGAHgQqiXFA=;
        b=hL1jZe58J5bulaCF65dbe0qjjnqOwi1n8s9e7A6ZBHQTcYadf59FJqPbD9isN8vrdQ
         z68u95hxRqjBWK4WaYLeGcbwQ2eXKcNMxME7So0SHPNy6izIyG8h84JqnT18tHILsfiO
         I9ceaDYFNow6spltf8tzhamJhp8GQehpxnXMlEMMKmkawzhKa3SkY0ouatP/K2JjovDJ
         p3hU8/JqteuEwMgg9cDFOWT4dKNXWsVc0sg/cReDQPuZnhY47P6HN9MDF0LJ2VfqEh+W
         OgJ52mJ2WIvhKmmKzyGgN1GCyL3izjZnJfnZR2WsdCF3MU6XTcjbPUbiXqgEdQqoxZ6l
         H2wg==
X-Forwarded-Encrypted: i=1; AJvYcCVrDeWCbJIOEZiFglQ8BmmD3yOuJ3xL3vVd08CQ8V7e49H1bJZWFvLPLBiuWFVOnFAD+oTXBDztyEZt@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpSAojRjPUF9g7R7EcBV7JpfsLJ8z0oVafmDDuUkiNv5oiuJu
	ykh/TM4f80RoeIVefORvGA7pu5NDe01CSFj9cGVRtnQMa47lz/53TvSEJeWyO/VgD2A=
X-Gm-Gg: ATEYQzy+lCfm6XoJY2sFipe3VhJfi9KSahWraicR7g9A+PXQK+9ejM4kWH/4JrNcQ/n
	XfJCW5btKUfM+FpyBFQpBmcGbh2GCHBG2c+pCe+2ysWpO7DoKnMqE7WfmbkpcyIzn420McnMsFy
	SyFGoXcpJQmZQIIlHXfY0DpEsHkdMUmfaFAZglQzbFTDtURAi3x66y5GxEY3sdsi9j7kWg4kZSd
	Wn798Addx4bZWrTR5Lo/1VsP74jSt0vHuEOll4g7TOtXRvQ5AjP770pctRkosI0BRnJRohaqWmf
	J1rgTaU/mhkeFuSic+jXTMipayNX5tRq66rv6aJi/xhDO4JSC6vPqtlTmsT31DRm85uTl3enqtc
	NwO5KaN1JnxaFO3fcFQo0y4CREkmonhl7MUN+Rpv2UE+vFprt6jbPnlNlvQw/FPu5b8nLrkBx/P
	S1lUB8bjfjhZgYbEkU1PI=
X-Received: by 2002:a17:902:d541:b0:2ae:c981:2a29 with SMTP id d9443c01a7336-2b0cdbf7bddmr141880015ad.2.1774905245314;
        Mon, 30 Mar 2026 14:14:05 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm93479195ad.28.2026.03.30.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:14:04 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
In-Reply-To: <20260324103934.7d259008@kmaincent-XPS-13-7390>
References: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
 <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
 <20260324103934.7d259008@kmaincent-XPS-13-7390>
Date: Mon, 30 Mar 2026 14:14:04 -0700
Message-ID: <7h341hvx43.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> Hello Kevin,
>
> On Thu, 05 Mar 2026 17:07:23 -0800
> Kevin Hilman <khilman@baylibre.com> wrote:
>
>> On Mon, 16 Feb 2026 17:55:52 +0100, Kory Maincent (TI) wrote:
>> > Allow overlays to be applied to am335x BeagleBoard boards. This adds
>> > around ~40% to the total size of the DTB files on average.
>> > 
>> >   
>> 
>> Applied, thanks!
>> 
>> [1/3] ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
>>       commit: 18161bb01ede109fed41c66efa2624a4c27377f7
>> 
>> Best regards,
>
> Thanks for merging it.
> I see that you have merged patch 1 and 2 in your for-next branch.
> Is there a reason to not merge the patch 3? Are you waiting for a dts
> maintainer ack?
>
> Maybe I can resend only the 3rd patch to ping the dts maintainers.

Not necessary.  I'm not sure how/why I missed patch 3.  It's now queued
in my tree.

Thanks for letting me know,

Kevin
