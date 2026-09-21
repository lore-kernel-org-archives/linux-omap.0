Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EE4DAFAF
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008753; cv=none; b=RfwQbQsaH519MkQ2Y99AYu/r+5uTHol20hDMpWwlfSJp1BtBkKo667plY3uc3hi9UJvW3UgIMXZhmzQFPS+fo9j6omyvLlwdbrhXxNdMNsN8zz7AnOIUpAwFWBOhNkMPhZMc20+RIa1CK1HdZGF/XOdvtL9y1ZewwlViOCvEK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008753; c=relaxed/simple;
	bh=2Jep4U/sPa3ykAGrogeCpl6S6LPaIkL6Afy6zdvlRUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvc4xLVNgpGEJwg97iFtqXSY4n/AYpG1M1dpSCQBsCwHD+Tnr82gnDYeRiVq3WSDo67uQdU+ZIowHN6b3wY6g25tuYMY8KcN4o18f+fKkiTW7plHM2x6Tbfs+nOPnNEpcw5CRAA3aq8OlH0lDA2VM8bS+q5N6OvJUkSp+mh7G+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gGXqoWsp; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gGXqoWsp"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86efece610cso2304794b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790008750; x=1790613550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xoi+qAxbLbOdEbJC2ElBOo5ZUZgXdWhceK6CmEVeDBc=;
        b=gGXqoWspJA3ASz5f0OE4U8JmDpiddwbJD6U7p5EudrTnyMRdOk+EhntVu03b8MaVSd
         T/J/cFmEW7VLTigVGLfdpihIhd+jvNOvfQENqScdSFX5n6/1wvWiDvLrd5RUMTVELkEW
         jsL9GC6CmP8Ep78Nn3nbm9OGiKFs43DazdjTAfUcMn9B8MSnMofwWjGeDb6Nt4/HakNx
         Tj27i9+2ovtZ1tO/adEWajShmGhpu2q4cC5Uah3RunI7grQAoROpP83DhtXZh7X4qYaD
         h7D2+1uGGzbPYkwoGrqCPVb2VxWJsyGCt0X5YWdwXiBSxDIeca+DpeDIpsoaJ5PsG0yJ
         MqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008750; x=1790613550;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xoi+qAxbLbOdEbJC2ElBOo5ZUZgXdWhceK6CmEVeDBc=;
        b=OWdVMi7A+X/AJi0zy9w69b2r1dFZ4BbslAEf+LNjHie642Hln7lRBdXZosCyYStzr7
         ET05PMoPr/AhGI0F/mmq099k4olb3V18FVGYOzqpMABdkkq9enFEQ7JEtIClFeJuJepT
         SCbbDmZQBAW8aPaNoZWeNhTGbCd6chWUotQctzhKUEvII+toli6gULGQXoIFygayyhqv
         ezc3Q0JP1/he4ApEiOxvGql0IT0D90e8qeY/peRpuBk0RAmweAScahppuCd09TYydy9r
         j/nUpz/QSBhsd3oSlwn9WeT8GGBZJ4Efr90CSbyK03234G9Ss7FhCFXHmQn/VwNc033w
         INYQ==
X-Gm-Message-State: AFuF++mj+sDHzxLLiD5HYH09dHykeKV5aVxqBV/jsg1h356J3ZvdoQTA
	eRgGZrqDoW7qRNzKsKzKkLRUNqQSmSbYYuLfdAc8PdyGpm0apnuKNSU7gAvJgJNNv74JC9RKXYb
	mkzzZ
X-Gm-Gg: AYBFou21zXJKkilATOA1v54X5JM6zSn9JGXyTFF64K+3vpyXF9Kp6Gply+3jqnrN8qE
	+ZWVOgtFPT/l6upoCGNAN9m8eUyK0SBRhzY/8Z6iWNkpFZ8XvRDLdsSyRGG0Cc/Z8HYv4ixfrdu
	X9NvV23Od/BjWsoUKS8lU6/oiiz6J2yOyzfKk7OXChCH44a8b65Op/Ldxzr/RSBEGPqczyEMymP
	scCWzidzwMNZV5+IZ4PUv/NDNHhvcYrykGhuIc4+qXbsZDP3i9W0Ff93dKLw6UwzJ8VNkxZB9vB
	6CIqe5pMYhMntnVpVcKmLAwkRQDapVThm+MmPOm+EUQDPZPL8AEADWHtIFSl+y5QCBTdvzZ37LE
	3GUexN8rDGPmAKuJ98YBe9itnSaOhiA7tUQCrbRzy/ur7t/arxh//ZqZtnTYuyQLQwoJ9mJdrcH
	XI7CCmLl138yJ/ZfSU+ozSO03flQ9tA4EwGM0gCX1beDVb/TZqe9ejlO0ya+T6I0j+XPFo
X-Received: by 2002:a05:6a00:2daa:b0:874:708d:b635 with SMTP id d2e1a72fcca58-874df4049e0mr15317101b3a.33.1790008750156;
        Mon, 21 Sep 2026 09:39:10 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-877a6ae6f56sm3597430b3a.6.2026.09.21.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:39:09 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
To: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: remove unused ctrl_module_wkup_44xx.h header
Date: Mon, 21 Sep 2026 09:38:50 -0700
Message-ID: <179000865429.4136193.7908982571634163469.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918025316.375757-1-enelsonmoore@gmail.com>
References: <20260918025316.375757-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Sep 2026 19:53:13 -0700, Ethan Nelson-Moore wrote:
> The last use of ctrl_module_wkup_44xx.h was removed in
> commit 6bf588595913 ("ARM: OMAP4: Ctrl module register define diet"),
> but it was left behind. Remove it.

Applied, thanks!

[1/1] ARM: OMAP2+: remove unused ctrl_module_wkup_44xx.h header
      commit: d1e94aea2b15f076d3f95b309fbb372a8fe2e9f0

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>
