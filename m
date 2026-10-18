Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402022222C5
	for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290726; cv=none; b=Qkir2J3NRh/+vawhHlC9/6wjur/QrEkQjQdgehOajpwDHpXfbn8v+yLHFZC2FRgjFru4unGNLx4C/UI7O1CQrxEblRMIuuMlixextUeHg7FDv8mD1VN7nePVnukUPiAAI8a1Ss7ClbuzPKd1u/HEWXfqKWFjv8wCKwQykl0efjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290726; c=relaxed/simple;
	bh=SonTQqI1E4gmDWfoGEcsRKX7iGhRoCOiAf9Un14E/iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfJJ7khej11DghOn2JdDtGzgmqdjRZJzm/axNAdksyBDid2vsL5njvGPZ5ZOYGWH10T3I2uzfKJouOn3mc0/y7Na+FAUxhxYHaOFxC33jhEAasvUr9ePjwfb2exAr5vLkyoof1lxgYbSaDp2ZWYjBminBJ20SXyCiIgIA5LsepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=r6DC0X/y; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="r6DC0X/y"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-536605c4d8fso1110101cf.1
        for <linux-omap@vger.kernel.org>; Sat, 17 Oct 2026 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792290724; x=1792895524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SonTQqI1E4gmDWfoGEcsRKX7iGhRoCOiAf9Un14E/iE=;
        b=r6DC0X/y7++3e4i0SySll5DwBR80GzdpSX3Siw/t/ZJpwnhiZm0Ox4tAWVSz0YWNTs
         RIoP4k3Zl7CRhBR+eAOfgJDsoim8xdq8yvVgm+UoxGpgrJuawggf1l1XI3Gj0XeoJli/
         Dihhkt+tVK3Vapr/bryK9lnDg4lWXEGMCOTATOxqJgx1CNXgtiFuL9CohFKvxDKQNeEq
         b4tTE9lNKQoe4U93ya2hzplptV21yoqpx+5geamJ/n7qJiv3/63w1dhKA+HCoR2ge5G3
         snBnIZGFqut1etfqPJS6BX6c5PI78BKm5Vn7k23s17OvNLreEMSeQkv+6Nx9LkCxm5oW
         C1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792290724; x=1792895524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SonTQqI1E4gmDWfoGEcsRKX7iGhRoCOiAf9Un14E/iE=;
        b=tDps+NoXrL783jBuCsHSuZhNflnQDP533d1S2g5AOf9a0yX4IBnRQc2ylcuyfeX+qP
         J4oaasgmRhnZ9oYfIAP07RKTRgerfYg8UXu/uTgGoC4qCNPL5gfK9N6RPGddnJnEPhp6
         xtRN8T4joPvnXQUECfnhF6jcViylfEz8y+JHtMrpAihhGO36GEB86aCObRPriI0MS5Is
         cOF1zJKhG5N/Sv4SsyxRYDPE4m/ur+whAzLeQsofttedOo0OjmXuvkjnx9gwaEDdNjya
         pP+SuZdtcEZoKVjNTGDdwSOHwnfuxVJ/Km7S5O6bnoiQOdRA8/spQ3ZYVFP98GeB69TU
         h7ww==
X-Forwarded-Encrypted: i=1; AKwUvBxKgrDtEn9BqcYEgK3miaPpJBATKM5wuLBRBDe0XiTmRpp1RvfmEGRq/kuDZfElAbGKbTwmeIHWfX4B@vger.kernel.org
X-Gm-Message-State: AFq9FYJbpaDFRt4w/38R1bjaCFIrihXfGd+3fP5hgsfmfuCtP4vTiBCn
	TJPV4nGnktXWRFCfE9eJ/G8Pm1gjpVC+N+FyQmW7hwNQEc3UNOUuJR8Ro4t0tpcwFdtV18a0cCk
	9A33rfQ==
X-Gm-Gg: AYBFou2pmimZoLRko3Kz2tQlyKfxOFmAJ2lhb777iaqwti10AliMtyitGRPXCRhR7sX
	kZLrWE4zp18HeQjxCNf1sCnbHhDMaVKJEq+Ud2kZTv4v8G5hPpfGH8phL5jfyvewBkFO+SHs+XE
	TFUbUoogEMGdLrJ6C/F5TH/tx4+gDm6tc9ckQQQvToAbYO4aO3KuaThUbuHh+RH9fPCSFcXm+Ml
	gdS/MNeNUT0g538I/dBRJ3fKOV8Szz7WgwA3EViIn21pSrKWFq/mvvIjMl56Ovrwnpljjelk40B
	w5sq1RWa1NTXaRfnOOuv8OYYxFuFtfGQGNeFhg728XuPisDOrIvg8qyU9m+CBenbrgXK0C5fLfH
	ewM1vRJ8ItZRs8wdcF826xMy0d22a5WRKs5hK+XDDs3QhbTLMJIavVR05eb0V+5WsRMaXJmtr8j
	JB/IezBFhl00aoYzbh2VhrBd1dEpIwuq2D6KwpSWCtWTofUkSdsXzy9kq3F2+A2IY/j0ECRTM=
X-Received: by 2002:a05:622a:44e:b0:533:367b:3479 with SMTP id d75a77b69052e-53645faa298mr58825371cf.14.1792290724083;
        Sat, 17 Oct 2026 19:32:04 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a9bbad2sm63812751cf.18.2026.10.17.19.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:32:03 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:32:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: m-amirpour <ampr.mhd@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-omap: handle root hub overcurrent
Message-ID: <e9181871-e1d0-439e-9764-631581690ed4@rowland.harvard.edu>
References: <20261018015747.246611-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015747.246611-1-ampr.mhd@gmail.com>

On Sun, Oct 18, 2026 at 05:27:47AM +0330, m-amirpour wrote:
> Handle overcurrent GPIO interrupts, disable port power when
> overcurrent is detected, and report the status through the
> root hub port status.

How did you develop and test this?

Alan Stern
