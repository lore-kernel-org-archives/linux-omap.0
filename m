Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D152FD7BC;
	Thu, 23 Apr 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944762; cv=none; b=s2JmSeB0YcXuSpFdlXCuvweevGevqV4NNe8wRjnozpj3G8SsvEf2/HZKhNsjtAa47qCdKW8vB8PS5slrJhMNxZSFAL8Czh4F3rVcYWD5HmJ2S42bmlyOFQ/jETN4QxfibWyN+JWUxA0Vxya78vq3+erk5LqVc0Y8KnfNC4hjkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944762; c=relaxed/simple;
	bh=FlBRd76Wf4UdbkyU24qsKdC81AKW3AqatiosydymFOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwtqMLlaMymR6Ec1KaVn1tYDsFhHrT3lqusvyShuJvKVflyLH5b3w0vsef86GNlvuUv+LT9kguS4WXbrokzGfld1+MYy7PertLAgfIoWl5U1shtbLb4sNQJxguTLu1oMeoqyQ0Ff5Ec0hoELW0PJKH8VPnU8S280of6zRg6mdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REY8dtkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REY8dtkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0337FC2BCAF;
	Thu, 23 Apr 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776944762;
	bh=FlBRd76Wf4UdbkyU24qsKdC81AKW3AqatiosydymFOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=REY8dtkdaZxdUR6okwtIXOG/XGyWzPkGf0MYf3QwzfvxjV2kpDLd3Ro3+bQx+QQ3u
	 wy/JKltqE4FC61pI61fS2Hgb8wFuSuggGXnIr/GMsrMBtV8utMusBfLm+JEcnFJMSr
	 Lr7kiw0mRhlKf9NmNe5s01IF/iT+OIaCC0heBFuUPru0L7JXhSK9WtaAHdPjQqOmLI
	 f202blDCRAGwXIfdMZPJBdDEW5/yF0sF3elaXYS1g4Lhg2WUvqgKtD5+YTLxRVd7Du
	 YyFKyiSpiiDJAYEh+X0QG93OuXRpVXL6kUgU5Uwu/fGRsgYO/wdN0W03N2Kroml+0d
	 2m63MJmUmpwSw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, praneeth@ti.com, nm@ti.com, afd@ti.com, vigneshr@ti.com, 
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
 rogerq@kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, s-ramamoorthy@ti.com, 
 Akashdeep Kaur <a-kaur@ti.com>
Cc: vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, k-willis@ti.com
In-Reply-To: <20260401112257.1248437-3-a-kaur@ti.com>
References: <20260401112257.1248437-3-a-kaur@ti.com>
Subject: Re: (subset) [PATCH v3 2/2] mfd: tps65219: Make poweroff handler
 conditional on system-power-controller
Message-Id: <177694475669.204183.17654636429051313740.b4-ty@b4>
Date: Thu, 23 Apr 2026 12:45:56 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 01 Apr 2026 16:52:57 +0530, Akashdeep Kaur wrote:
> Currently, the TPS65219 driver unconditionally registers a poweroff
> handler. This causes issues on systems where a different component
> (such as TF-A firmware) should handle system poweroff instead.
> 
> Make the poweroff handler registration conditional based on the
> "system-power-controller" device tree property. This follows the
> standard kernel pattern where only the designated power controller
> registers for system poweroff operations.
> 
> [...]

Applied, thanks!

[2/2] mfd: tps65219: Make poweroff handler conditional on system-power-controller
      commit: 0af600b8e3bced37afa267ac9a7f68e15764f502

--
Lee Jones [李琼斯]

