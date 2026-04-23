Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011824887E;
	Thu, 23 Apr 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942057; cv=none; b=cfDZD13difOPEYPbwhWf9OPscrwj5CfM7fE5B+d/fPJ8NcKNY6KNLv8uw/8zLh1n6GX6mqqM4viW7vnHVS3yuLKGqYmGO0Bx4x9IDOoQ9DKUz+WY29SvbfFVz+KFm/+A72teS0K7SWZ0FzMo0VfBSGk64rtFPOwKeVjdZuMU5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942057; c=relaxed/simple;
	bh=MVE9zUorvc4ZA409XQg1e/V1+5G5p3bF8zz1ZXYsasI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RTcDRAvaQghol3BSIQCycbH6YdJS/4lV/jV33CSFh3b+8sjYdX0Qj8AL2gJN+e+qzdWyUH3WA+BJ1SDOuKYMg6r0BXccDxgvWbDKdgy9/HZpqYVdnAP2XqbDyV8og6GQblW+f7q9hwaVYB0vb6FrC1LZ84TkIVk37+uA1D4usE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY9uvvW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY9uvvW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13951C2BCB2;
	Thu, 23 Apr 2026 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942056;
	bh=MVE9zUorvc4ZA409XQg1e/V1+5G5p3bF8zz1ZXYsasI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GY9uvvW3xZDwgKf/eTotsdDmTvDzi/MhLta1AWOxB+RjLEA2R5pNSgIQpSzyaBp7p
	 /z6J3MRAsgEjJBvbnaA7O5npFItL/TvLgCbGnlO/m7/by5Ta/neNzmtSmdzAiuZUGh
	 5bDMm0ISPVHYs5YJvraZaN3HnPuKWmBpAxfm+6x5/f9ibmmGlZxodoj9ij3r/QfgFW
	 nPWad742+Bu8fxZfVTKVZmCKxWkJkuef6UleZ9EG/8xo1JUEI5k5rQExYb3HaL+b7j
	 bHy2SKeQmEIw6/cED5MWkgVxJUaoaw6S7lBOIVw6X0FYEKKGlfSnN6yA/6TpRRzWX8
	 CNjS8DV+/hz7A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Wenyuan Li <2063309626@qq.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 
 23120469@bjtu.edu.cn
In-Reply-To: <tencent_01102156392EC89EDF2CA22A7C8B4ABB2509@qq.com>
References: <tencent_01102156392EC89EDF2CA22A7C8B4ABB2509@qq.com>
Subject: Re: (subset) [PATCH v2] mfd: tps65910: add error handling for
 dummy I2C transfer in probe
Message-Id: <177694205382.183694.13611567729306301994.b4-ty@b4>
Date: Thu, 23 Apr 2026 12:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 01 Apr 2026 13:09:31 +0800, Wenyuan Li wrote:
> In tps65910_i2c_probe(), a dummy I2C transfer is performed to work
> around silicon erratum SWCZ010. However, the return value of
> i2c_master_send() is not checked.
> 
> If this dummy transfer fails, the driver continues execution without
> detecting the error. This may lead to subsequent I2C operations also
> failing, but the driver would incorrectly report success.
> 
> [...]

Applied, thanks!

[1/1] mfd: tps65910: add error handling for dummy I2C transfer in probe
      commit: 8599ab7a56720047cdcb008024852c4f4fd9fd5a

--
Lee Jones [李琼斯]

