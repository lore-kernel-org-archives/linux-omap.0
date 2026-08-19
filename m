Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD43AAF6B
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174497; cv=none; b=Iw73YrgvWdRlJ9VGM4XCMzcjZKPf8f2kVSVLe7o1rfcB9OJHv111kAN+WVK+QyEVWTMC43LErEzgQQdowMxDffH5XpwO8AfpNMJ3FktsRegfvRLQZSrBEwHL4QEiyMIR3t2QI6ToEsXPfCN2b3lvMk7q+c2V6RI9Qw9LFRtz77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174497; c=relaxed/simple;
	bh=iHrHqCAXnU6w0OS7DQt+y8wUDDdgUtnC3rGRDaExFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDoINHRIiIddt2TJB9OEZdRCVk1buYH3DgSHiJB/hoBgTSe47uNtKrdmVwklt9n3jC9yKZVS6qUGZT6GBVMuvkWhSe5EH12/n5Hu1BCXaTgboUsAjp5IIeDYODfmZLj0wv9vNGjJYPaBjg5K6hD4dnT7gwUgWE/VN4Qj9SXHZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+go3blv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ne0wFQWb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+go3blv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ne0wFQWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
	b=N+go3blv3GzyhCHCmjv+XOcrNvCPJp/1PY7q1nw3IfaAgDS4eVdwXNwD8yLX9HImRpSO/R
	xsDd/oBGnaB7pIVSYcW7OHPH/nnoUI+G81PcA8QJSkV0TKlzQcJODfpWHm7daiw4atM2St
	mDYpg+MOp1osOLWXSRrnvb2KZxoQEZ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-hH5lMzyzN2SMDFjkGUP9qw-1; Wed, 19 Aug 2026 17:21:33 -0400
X-MC-Unique: hH5lMzyzN2SMDFjkGUP9qw-1
X-Mimecast-MFC-AGG-ID: hH5lMzyzN2SMDFjkGUP9qw_1787174493
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ce64c41efso25193971cf.3
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174493; x=1787779293; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
        b=ne0wFQWbOks4TH9YSYxP+L3J61lBszhuVxir7D11tT2yHDCd0KwAlcruZTgW8M9CV9
         g3GBB99AlbsxTCrTSyNxMC7sq81OK/2j9HBqPFkEA7Cuc+SRoxWIoUe09KFa3ls7cVE9
         P+RNW3OGxVvIgGOlxLVTVZjGjPqu/CjF2fV6aqi9XZl5K+5uhNxFnIQPBYbGY2B2kKnz
         te/VlM8wPJD1u/COrI6v50PsCxFOEnFQNofjPV1yKklmYDspMn9Hcl6exxZ5hi0JajUr
         35pkqk0pvtYoNfc+ZU7Dz6RUMKXY7BLL/zftRRM/J782wUV7/0VArpnb747VybPxt9ra
         HboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174493; x=1787779293;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
        b=Ai/Ks28cOUqSJNJm7hH00neL9G1Ug2IRfHq0Wvn1Uj4e0xgkaoaMiZ3ADnYVtl5Lj4
         sFI5/+SjphWGsNmSGAP0e/3Du6Zi365bx1HKLmioocGnHS9c4vMItqbztBlYKCW67XJb
         5BQWIvJNtstz5r6UqEgGs9GLg8sybvMniV6ngmfMPwPNBeRVWVmJ9OpWrBymFr8b+hGi
         ENug/CYowVEjcxSQaSpf1mBVbWK0wy89FKRhktnfC7xyq/9G/hIb9QYZQZDAfjh1PgXT
         UHuXRKN1cihfhIONDKIb3ZmnYRft3YCnTXz8ueIwzU924dATeQNL++v59YZORFAkcl4+
         F8DA==
X-Forwarded-Encrypted: i=1; AHgh+RppPScxijWfghTrL4+jtHogPNBwr14N81jdozKhbQG2kJyKt9a51/mVYcfwcUxa7dCylgUpqq2OIO+D@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcb5wZl6uXcr9N2XhyBg2ak2JpdoBkxK++mB7M86UOXAsZbse
	/LUw+ecn3m4W9WTaCIGO3lzoPSm3IJhD+iNwFPaGFWwQFhgwotwBflr7zR6Fcf/JXKUL0AI23Po
	YFBzoMbLqo10b/f//gsYh4shXqb2FE8JAwBLWzorAe+mIyWdz0Aqn3FHp7CFcAKw=
X-Gm-Gg: AR+sD10yyzOVNByeGHHZp1iOy+Gdm+rk5NADqAQfOfW0O3fhsgid2vvJpKWYBp6Mndj
	ml1ldpWyxHd1TUWuim5yg0Wss6oK0eq7s5eSHbG/thm0/gHvI3TF3QtDdojEps3AtRb/5uXZ4fV
	TNXhx7KQubkB43nKAXMgGieTvxsg/Cq1GAtBJlbywNTKdmorHJkWGK1+WZwuAkLibfEhw9EpPE8
	u/msmgpBqeBDQKBGgyDYEtwUnXMVXaQ5tZQ4JnXQBxzuSvTZILS6pOYHnArx4R+JKV0MMKhILOu
	DNc/6Ri8KGZOY1T3lEDFwX9U6H/7eLg8Gha7zErATnPbTJfT2PwSLmXX/U81P4Ra0G5/GDXl9Ye
	ThfFKCmqQE7o9ofMZS5rqt/pI6huIwx5NNE4=
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425441cf.40.1787174492938;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425061cf.40.1787174492580;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd8598adcsm18745871cf.9.2026.08.19.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:21:29 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is
 fully initialized
Message-ID: <aoYeWR6H3q-d3yd3@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:16PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> visconti_clk_register_gate() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: b4cbe606dc3674b2 ("clk: visconti: Add support common clock driver and reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

