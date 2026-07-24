Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAD44331C
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936577; cv=none; b=Xm1nfUH9tuEnyvhVXAvXOSoN7x9+1tKXIHgK1TimcwypVy2hGF3DGBVwki/ZWqtBh6YDQkBszuGOj3liUhmlwh/kwdOaeN9W2Flqu9VqmN7JVlG25f61RcL7FGSE9K7IlrAzdREtA61T4rsZ8GifapZ77z7H4EeohRDr2nk4nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936577; c=relaxed/simple;
	bh=zq1/aw2rzNVAiRX3dG7S0FIaSXrYCkGPyRirT0DKjo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ron1G/lWSpUNQ46MM7G5MYJ+SbZH/mbgQx5pGMZnhEkDVJsrd3YVE9+OA4nNIQZaaPrbR45mKUoL+j+h4+NUdyFplDI56nOT4FZ867VfaOlHoW8LJyUrFv+jdm5alqdcyLHUrOAtriVY4MYP9JTUaEwjMbBmpZjSj5UAqFm/sNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYlKKMrt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYlKKMrt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so999094b3a.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936571; x=1785541371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
        b=SYlKKMrt2HJ55cCy7poivcZI4+TaYB7DOm9qFL8eX1GXIiFar2HDA3LdoAL2jBOPRO
         Zt76s4YDb1Swf8TfMLtkuwKbunz7yl+TxxpYo+ehTYcfdjMIiFWsoJ4dff4FKNP//DqV
         gyi0m7EoHaB1i0eVMBk6yZboHaMm2ogcqYqx6CykGVq04EC2B1xzgK3/WOGlzOx50+up
         XNy8ckT5oS0YK5Q480Um/gkUnyJAw6SZY2CtfHegc5Fr/WtPYkEDyu0G9PBJeprgUK7x
         4jP515go5S+R6o3gYlJk0UBH9cO/cvaWtIIZMFMQ250UNBHvZrA1w4EIYQCKXFt/G/u4
         +PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936571; x=1785541371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
        b=k1u44RUgi05mG/bujTRwPsKdvsv9VG31gSNRuCsCA9sFxkRob+v0U6ktqsBemnkPwY
         CvXWG2aLMKINbnYlBDbN5uwT2SW249cix/qOAswYBKxKmHjPhBWi17xGufh/qnB4MeK/
         XZ3qtx1akoinoAXle/HJN8AJlBP/uwqBORmCrNi3ihHhNge7hEw1bRASi+JOGcNH3wks
         KQyOWN/3Q8tbbX0wrrdi+6+9WKCQ9VF3TtDdFKUAVwHhEcVbJXSGKX2Phn1I0xan8aUW
         slndTOUk7/5KzFMM3iUio3lxuaud8O1xlJsv14kXkE2elmR2eT/Ycuk4yvOSg1vbIYWF
         CxsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4j2nNC4sGEPdOSbA45TdA3YO4zor1D8ijSBa/bTf+ylbl9V9S+ceXnM0CIJ8QvRI/cunOXLIr2CgN@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQFdkoTorv/cCJ2zML+0mdG/pLSnCpqV0F1JynFs6/nmfDOD/
	I++ME4Z1I/Zj+O6l6NO09UrIF6ywl8q8IN1J87jyNwvkn2czupgpVdbk
X-Gm-Gg: AR+sD10GwvfKBbI/wYHRRNXMA/d12As7CeliGKo42E7llDVmIWqu836+488lL+vEnEL
	tfHRnL60iZ0M4RiCWydsvdNhqPdbsBh3JlR1U0X4I3czm2z2GDQmXzTqK7Y4vzHiBv2ZgUW1xX6
	IXsTaBXV6/RTn57vPKG3w6uCxxh17Exiyt84+5uMQ+/cYur5jTN06YVIe7Ek7cr5hNwB79aC898
	y8hPjSE+ns4t+abbJuM68816Htw5MYIO8qb5FLZcdf7Vl/Tvjc/cVbr5+9Kujd+UY1V/cwOoPQ5
	wjoUr7qAg22Fyckgf+/ydg6Xg0h6zhg0J2i09LvhJzesw+Kbb4PbP5pSf4KbNZI2wf/7OMyqt5g
	SKBRXi492MsQD5gu2KZYdzyzq1KbJmKTcA6gVLAhyMJNSm1eMFGEBmNjvwz6yY0WsGfRlrnbAg8
	eSGVHbpM1yuM0+jRYcs/ja+uZhI0FfgS5ZYNVcXhAEeLw=
X-Received: by 2002:a05:6300:2287:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c67236feb3mr2624676637.1.1784936571055;
        Fri, 24 Jul 2026 16:42:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc4164ddsm3312255eec.9.2026.07.24.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:42:50 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:42:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <amP4csGgdg51VRZw@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>

On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Applied, thank you.

-- 
Dmitry
