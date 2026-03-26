Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BD3B7B75
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515766; cv=none; b=XUkQKdKQl8WLrNzWviKdruXzxvTZYuZSz1SgndGPa3uFLqm3U4cDb+68EXujknD/u79/gZNLKq+FbTMs98R/qfdKj2O64JSIhKm/GgmrXr0GW5U33d+0q77dVh+gMWFpOQJ1b7EmQHu/OLGxXcLHiSbra319I/JPjKFOrc2oVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515766; c=relaxed/simple;
	bh=kC4f8Hr+laqsiqLRNBlsElLNUuG/yDm7JSOtydy3Fyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rnJTtqr7U6QbjFqnA+RAhqWLCd3TYc1Ewt0lVtjg5tOKbvkOPsXj+l4nRSB40+Dp198arZNdJbfNpnIhS/XCxg32vLUo3zGLCa9hOneZLH0wowWMlY++9ZPxVnle1+6R53QZ86Wf6z/4lyn4PmID5CNzjzqQCIQBaSpbkroLCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nB79GShY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nB79GShY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso5484525e9.2
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515763; x=1775120563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO+1oE17hDIKR5mphj28NGtnxtIqXY3QHBAqdZU43PI=;
        b=nB79GShY8+M4ApzQ/gIYax9KrLl41Tman17FIQm/6ogi0mFEBGcNY8qsyB7zzvWivD
         sCGahLw05cPItJfjqoKhy/sKmVkKF9RRflqlfd8rUkNmhdgBylL8w9Qz9PILwmXCKH6p
         0gimI6wdama65I72t1Z6Sah0yWet3LL5xPQhvVaHQOt3B3FoaBmLDcle8zQ1zMictcik
         z0aQZtqfsJcB+DyuPfxLv740322QGkuKEhX2h9fqNC1i8wydS5l0uEGn6tg6o8iEOqPn
         EZIV3tNFoPGWGdQR3bG9SLOZ3WC3Qz7XVF3RgO0RqlI88hWLcqMPhnI3LuXUisA4btZ4
         p/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515763; x=1775120563;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SO+1oE17hDIKR5mphj28NGtnxtIqXY3QHBAqdZU43PI=;
        b=qzyVn/tT0XjbHayQNWVYCW7nw4Og5kf6A9cbvoNSZsJp6XobHTbw94YVRIdW2zWAmJ
         wlygqQhFZ6zUbSiZO11qvayS+iMsxEx0uLVQIJJfH/SEkXYSSD9HI/PyfoZhoEv4FmxI
         j0A8XL9DhpzoeWZncBgb9qVH9SWFrMbmy/9WkXWvWcMKYwa/rNxxAXnTnbQow3OJkCy1
         a+Qa+iezhJkIULKeszwyuKll0TxdqD0o42X6ErKVpCRZkXrWc0ghe8mc5NRX7miKWY7x
         5nW3G7us3436RLT9+mTFDW3QRlqb5nF2zUrJbW1kZ6H1uFI66hUtUXTbeYXnQDUOjeCq
         WooA==
X-Forwarded-Encrypted: i=1; AJvYcCVz0f8qF16wze2WrNGTaWVCKwmRP5UKEGhKoP/rzpvak1/8ZZtWS3Jvs4Ws23dGN1Ja5bCgkF8BA5JV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqtdjg71bp0RlJdjxt3xRs/gdMhC8O3bLuGIjAKDpq+q5RfJY
	sByJARm3CVBTBNCmZ+n+7XJ4WZvUWlMCyYxUSVwuQOtZiVb3dM/luol9MVp2Q409gOM=
X-Gm-Gg: ATEYQzxotuu8GwelSnCan+RlIb3CmfrAGoaxbLmHh3tAdpK9EjbR+nDPESqYzWWxZ3Q
	jjWeHVeQZ3tQYklXoUWOgCcOq4JCkGrEMzEFJaV/CjvkconAjGkqQdEuAwo2w9bWuxfynku8Fjb
	a8wrO5szheFAK66kvhwZYb7Brd9OQystQXKJqqWcCq8xwFyh4iKsBwvQeKiMAynN43RJHHKsI38
	6jBIWvuAcjS5Fwg15LEuEwl92sQqc0h1Y/Bi1+J469/EiluY5ZmdvmjenjleHE02DJoZA2lPgU0
	H9hXemOeuqrJXIpAGgnmtWi3pWEGH7xjxv7MeODEUpDJzzQGqkWoIxRHW5HA1n8Z4hznLjSriKj
	nEGWriZ7QRfff/Pak+u+e1oZXHbc1/LYsJ5z+aGGDc9OkCmCqPR+k66o8MxvRUZUjsoW3/6vY1l
	CDl9vBkctOjhYv9h5fO3UKnmALoDCuKv0dRFZlEEwVuVgh
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-487160aa232mr97071565e9.31.1774515763192;
        Thu, 26 Mar 2026 02:02:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:02:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: aaro.koskinen@iki.fi, airlied@gmail.com, andreas@kemnade.info, 
 conor+dt@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
 khilman@baylibre.com, krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, jesszhan0024@gmail.com, 
 rfoss@kernel.org, robh@kernel.org, rogerq@kernel.org, simona@ffwll.ch, 
 thierry.reding@gmail.com, tony@atomide.com, tzimmermann@suse.de, 
 andrzej.hajda@intel.com, Mithil Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260303203017.511-1-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
Subject: Re: (subset) [PATCH v9 0/8] Initial support for Samsung Galaxy Tab
 2 series
Message-Id: <177451576215.103892.12129135091369769725.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:42 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Tue, 03 Mar 2026 15:30:09 -0500, Mithil Bavishi wrote:
> This series adds initial support for the Samsung Galaxy Tab 2
> (samsung-espresso7/10) series of devices. It adds support for 6 variants
> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
> based on 3G and WiFi, but since they use different panel, touch
> controllers, batteries, I decided to categorise them based on screen
> size as espresso7 and espresso10.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d37690b5e02418a2365548300628ef3895a24ed2

-- 
Neil

