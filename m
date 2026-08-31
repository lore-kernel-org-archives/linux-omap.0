Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406D3B71A3
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199873; cv=none; b=lsgl5rctm2nqDhvWZBhY+/UCJU8l4eCiQFtwX+4fZBeOtt2YmvfqeAXSauhG+Do6uwI74bEC6YiuVHVrtl28gCVWvr2H6Ke7/oSpka00HWvlY1JW85/SKD7RXSovl5toK/kaONBuLjm2zSCDHRq4gYOu7wdYy9MZevwZ2qPgW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199873; c=relaxed/simple;
	bh=YRdUvAeYdGRBs9Hw9METEgdNfX2XDDpkD3Fb6bsmtfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nSzDAoZvDgyyLBuGskJQqxup6Cp6JMPQpn5DSbz4q7QlS71P3447D7Vuh7KD3RV0grsTIAt3t2TUaQEAgjUeBH84aWA3Tqzs/Fh/2uUiR9cXdr7DQNUf5c7vcQOyVO7qdriHG7tEeCjjCsX5S20kdPIFgimyIdKaeZPhdjR848U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F9uJQNaU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F9uJQNaU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8541875f596so2057819b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199871; x=1788804671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bP3yBnej/1dS8o9eVuCwTXKp4H0+6SfILlIQPCeMips=;
        b=F9uJQNaUyDeyDf+bOOlBDqM6kEumRUD5874g29W8jtvO1hoXwGbalGuw62lGjfBt4H
         E+yANMorCkZ1rWZivRtufxuXka+HJZU+jUIOm5xexc1UGqxbTFMUXxOY8UIdnJ0t5BbV
         dpHPBCE60MbM0aNX+io5REMkT6jD3EIZ1nbiRDJyDkHtaO8Nm4g5uud4fI2IlAIPkatZ
         o4e7WW3EWIAFeaKE6eYem+BSwctYvp4i/41dzkwreaEvgWyPAU2MKyd6TA+hUv0o6PRL
         4DKbRqepd+ZbFOT5Tcyd4BHmI1BhlQQMhpHfUWjblMEUEUjXirHfOFYq56mPv3VxyOOJ
         /feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199871; x=1788804671;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bP3yBnej/1dS8o9eVuCwTXKp4H0+6SfILlIQPCeMips=;
        b=gMoM9964Wjj7nuS9c2PZl4KiSxE+gNmoA0MRz/yy6lNpb7J3qcm8bQI6VGOKJNsxGk
         8QAfMJJx8gtIPE0kaA24nByuXezhIsmdu8VDHyYjGoCC8OHa3GGo0WcPTBvxCEziWKOF
         KDMicyjfY4MPqaL1UwyIBdJZXSoOoRgyV78+BzcmtTZJVnNwZQ86LA4L/ivupD1NxoVH
         eF5Pnk4ym6Fi4HL86FDzHbZu9y8WcuZ1cn72cC7J61BBhxmas4lgmMmwBt6+zGiPa5SW
         2jqRMcc7cAvATqbAwOldaVL1g4qdN4dnZMMzmXneNvTEsJXRoc8uhH90HVIIPK8uUYPp
         mZzA==
X-Gm-Message-State: AFuF++lUGRESUtGtUD7vYcoSWzw42ct8OxvqsUaXUb3vn/5oFWg8Amc9
	TuHEksu4mbzpMBsecZ46qAgWpFAnRdWSwJaZKzBj8+2fi+6QSQQwaGo/l0ctVRWhs3t16Z3Yk9g
	/3uHl
X-Gm-Gg: AR+sD13Qqj63U6NM4k5mG2sZ3zD3Ln9ev6qesDoIuISeoZSxjmPRMv7HnSGqvldKrfr
	c6ZYhh2zSvy0B5/ado3mwzBNzucJXBqDx70aLYCemTaOHGWZmgZBvgjqv4m1vfI5NpbnBAy9K0L
	k3u3w5BAb2/oBbXbEuvF9C8mF133KD6fvR2GPVXp/8Pe4ddyi6yWu/lniCX0X5pizclI25187Jo
	dRr5N/g1ckh8uxqdBUnAmTD9Vl9Dzt2a9aiCm7aKAPXsqSEHqUC/X2/rjzB8Jhvb24JkahiTX0Q
	nhKC+0lNqODiNDS6S6utTjeB4sfUVsTHbN7kcZHBQ/FtdcYtejSYfwzJ4pKiAa+6OUo7mN9Mcjy
	JxnpMXqShS7N67TbTV6AZ5EB0CEpM+NDRuE1Axx0EkHyfeVrMO9xOkEeDa/lKZmQ7+MjOZ604ra
	9JS5RNk/f3URIFuA1qwYbSDofjqiA1HQUFoEPnR+VIwG2WSg2Wiq36bLd4/Fiqnqfg7gRc
X-Received: by 2002:a05:6a21:a8a:b0:3d3:ad3c:49a5 with SMTP id adf61e73a8af0-3d3ad3c6457mr32696645637.19.1788199871097;
        Mon, 31 Aug 2026 11:11:11 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cc1f36fb8e4sm4571178a12.32.2026.08.31.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, andreas@kemnade.info, rogerq@kernel.org, 
 tony@atomide.com, Can Peng <pengcan@kylinos.cn>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260728091859.150905-1-pengcan@kylinos.cn>
References: <20260728091859.150905-1-pengcan@kylinos.cn>
Subject: Re: [PATCH] bus: ti-sysc: unregister notifier on driver register
 failure
Message-Id: <178819987015.2869653.16458264341724910899.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:10 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Tue, 28 Jul 2026 17:18:58 +0800, Can Peng wrote:
> sysc_init() registers the platform bus notifier before registering the
> platform driver. If platform_driver_register() fails, the function returns
> the error directly and leaves the notifier registered.
> 
> Mirror the exit path on this failure by unregistering the notifier before
> returning the error. Also check and return the notifier registration error
> instead of continuing without the notifier installed.
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: unregister notifier on driver register failure
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

