Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846A385519
	for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951941; cv=none; b=EVEfTaU2v9rFc8Btq1KtvhwsX8xSO48IJQzwllmW/AzuOpfONm6GCL7eDwFRSy2XJ85W1cnoOb7erojYK5hBa8KGqKuGsQGdYCKCBbGFs5GEt23U59EfJaEpJuw8qeny4dWCIe9E5iDMvs8rB6ILdoq14MIvlAHbVcGw8Tc5qYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951941; c=relaxed/simple;
	bh=bkfxEHVzEoYCowt9lwKhpqu6A9vt6KeYyyg5eW8TDQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFRoSOeTFk5DdfsAgmn4S131P0jFuU1RftX7Wo/9g49ai88/B+HUr3L9haqYII4ivAs7kdw+HH8gPx9fwe3WHgxxPtArw1bO40W4WMbJ/FYiDAOSXE3VPgnWJRGEtEF18WVAxB/Bf+MJ9nyJ1K6RwWxFzB1vHGFwfEfuHsu0rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2kO+TJq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2kO+TJq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2769114f8f.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2026 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951938; x=1784556738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YO4iO+4RoSYMeteNu9nUAyD/efKBamp9eHyouwcTSY0=;
        b=X2kO+TJqZaXwvK5rbcew6R/B1kR6MikwWFfSxMbEJa7Zl2W67Mq4DUBpDDuKuHZRR2
         mBSpRl/w0jJv8i6eejXEKrjlh+McKHtJXLP6jpGKf46Ll97VaBaF9CE/9wXFFqLYQxyg
         7ejyWoGxeAs8ziLsyso/jl1oT/Z4NEVRiMHrMEgVI559a4n9Fz+Ln/xCWNH08dJxIACg
         EZj1ZRHcAi2raLVIa1z71zkQF9CnFg2CtLr1EQi1RRnU0hHHdWTH9jTCMe9OWXLtvw5E
         OEd01Bpqasifn0mDefpBHAySucrN5123LGUENne0eLSiFvoCxcr5MTk7fCZwjmedyPhm
         AO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951938; x=1784556738;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YO4iO+4RoSYMeteNu9nUAyD/efKBamp9eHyouwcTSY0=;
        b=Tpw/cIJQkssKwNoil7+wl3E9JX5ifeak1aa38G/3LDy1MRz2gshmDhnIH4Gx1Edufk
         edv8ITbNOperxLT5nknNaSRocpo85D6e4QMojGLujWJUEUzkuXeP6r6u0p7yo1SUROHF
         hj4J9a/Vw8HQZshotwICWzj0eoWCUaUuxl7Pme2DYPHrYPJNwvqMHd1qPil7h1QYS3v3
         fxdzglQhDY+TC2DsBPxyndeBaqgdX5GLE809BPkq38x57KRx8DD8RppZK4OzHqzRw/Yg
         Qj3qpADvdBfnvTHQ+wXwne1/HwhAMkaMUOt9joaLpVfgV+kJyN2qQ29oe9FAnzI6HGGa
         Ho/g==
X-Forwarded-Encrypted: i=1; AHgh+RoDzP1gj7j8o4v+ruccLQ4a+C4g2uRqTPOwpBXUoATVK7qgljwlV3Qsj9mIS1hUapx2h3QurT7kJvOV@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDEbpsvttrCKP+Lf0jG1LqOmh8TdT9gktcKNbk+ZWa+62zD/4
	37+x90GcJzL8dOpCAYDygLmHBG3lpUnuL31+dwjwkoTK9UhOG6nSAy7e
X-Gm-Gg: AfdE7ck4XLN4AjFlpHwXsYyXpnu7vERQgiYK6oB58w9dJvPU67HWO4VeYuZPqECqQT9
	GWPhJZbqkT0bm21vvKn8CfAbBvo2fxX5T+9qNjJrReOP5nF2GfT8yMeJgr9gRC2EgJgiweSsUk3
	CohlHgMqs5+GsUE390JZP360IME1JZZmNmCccEQxpEVyN0MDBo0ZRW/lUg7r/gxAlXfKOz7cBrf
	2g5UlnZ4hUgcUy3g5DQ4P4ZfObMdU+1Zt13VBxbeW+AC850kFLMuNCDnI1g9g10pBxDGVj2myQH
	EkfwBdmvaiEnLpwhHjWRw5Dg/YMvGHBTKdJSgKv/PiBJP/EIUTAsZ387ZZBDDdwtkHspijWF+2T
	17HXL7K0J4HPcmqAvm+l0j4SJfM712O7gEgCxSjT6TBJCdZthnclRm5q1fLopa+1H2c7OOKXtbh
	zPzXnEjNUno5qA5OqlICOeNYKAc5zrTNQWo1GdzAwSIsa/z8o+DM1zo2A2q6O+LXpEgipUgDXqo
	Ck3VO1gTLKaVPR0lBmifxp1aCu/OexFgZUPZCBN0Wd5IrvWzIWZrktmeLA9tkvzNHnDas6Au+4C
	ksySmZAnMY5G3AI2N3fw8miMJnXsNfWdtHpDJkfIAAjrEr6Uz8iyz7lJqMlhqBTxtMZoaq+LUKf
	0x8KtZR5KnThItmDNnPQUfkFVH3wKs+qrVA==
X-Received: by 2002:a05:6000:400a:b0:477:3d23:f920 with SMTP id ffacd0b85a97d-47f2dcec627mr10652902f8f.26.1783951938155;
        Mon, 13 Jul 2026 07:12:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm84998163f8f.34.2026.07.13.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:12:18 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:12:15 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, William Breathitt Gray
 <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>, David Lechner
 <david@lechnology.com>, linux-iio@vger.kernel.org (open list:COUNTER
 SUBSYSTEM), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), linux-omap@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP)
 DRIVER)
Subject: Re: [PATCH] counter: Remove redundant dev_err()/dev_err_probe()
Message-ID: <20260713161215.00001cc3@gmail.com>
In-Reply-To: <20260713131005.306069-1-panchuang@vivo.com>
References: <20260713131005.306069-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 21:10:04 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove the
> now-redundant driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

I think you can drop the commit hash and title from the message.
Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
