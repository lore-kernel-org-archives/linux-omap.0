Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8622D4D3
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892636; cv=none; b=n2OcvhIuJOZykXipiZBfkEIqLJYAuvPv436ozabapGp987NxQHMYMYvQIn1dmHiOfZ58eExQzv+iw6cFkhnFQcKwVbuODDkA5Iknu7WK6g6Zapfp9lKCUBZkGuEkrkr7A+Y6f5yZhTnrJDtokwJwtVqpkVqm3mmlQ1ptAQzpRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892636; c=relaxed/simple;
	bh=zeMiq8LCsSOygW+Zem1Qe54j8W/59jviilfX/GLsGxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SnqHuzTIDSpyBkROCepuw2uRKK1UQtoDCTeXSz6OMKm+Nc0+ccHxGGAfcFfsyuMdppSOi9RtjyEpNUMJoaj9my+GsPO50ipf9s5EiQfGp/3xc6T03wvl1v8HHSr3FWjjqpC4Ft5Mhe8H/ioyGLAmNDoudjgPjLMz1102jh467ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfqUA5FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfqUA5FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2771F000E9;
	Wed, 27 May 2026 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892635;
	bh=V6TOmeuXYoOdXvhx8Wvo+jrYnRIuUQdxifhJpW2L+4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bfqUA5FZuEH2mHoYlOZWGLsIUYDgNOQLXSd14jQ04m7DMJtZNRraScuSekj/vNZ+y
	 vhcEtBmLHw0hF9dKDQsS3yNJvgvaM8E0nw5iEiRQ6b4f2nKdNy11lG827npCtmSosU
	 Mn6YM+gUe88jnJLjZVYqQ5kOwiPYKQ5+uVMmnlSupkyTooNd0w08GS7GpFH7SVQdGC
	 IM7dtmC4VsU7kkmPU4XOk/l92IrmhA6t4iiunBQZJJfyCwDAJ//FG5xOdcifDleSUm
	 ZxXflIZ1JEHN+2QoYKYkU9eFQwQ0Dl8oAqzYmyz/+C1bRBPiaf63G05ndR6Mh/lzxm
	 OGvEJYG8VluqQ==
From: Lee Jones <lee@kernel.org>
To: linux-omap@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>
In-Reply-To: <20260517023723.92731-2-enelsonmoore@gmail.com>
References: <20260517023723.92731-2-enelsonmoore@gmail.com>
Subject: Re: (subset) [PATCH v3] mfd: twl4030-power: update checks for
 specific boards to use the DT
Message-Id: <177989263350.670887.333862947894690005.b4-ty@b4>
Date: Wed, 27 May 2026 15:37:13 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sat, 16 May 2026 19:37:21 -0700, Ethan Nelson-Moore wrote:
> The twl4030-power driver contains two checks for ARM machine IDs via
> machine_is_*() macros. The two boards concerned now support only FDT
> booting, which does not use machine IDs, and therefore the code should
> be updated to check the DT compatible property instead.
> The legacy board files for these machines were removed in
> commit 1b383f44aabc ("ARM: OMAP2+: Drop board file for 3430sdp") and
> commit e92fc4f04a34 ("ARM: OMAP2+: Drop legacy board file for LDP").
> The presence of these machine ID checks prevents the removal of machine
> IDs no longer used by the kernel from arch/arm/tools/mach-types,
> because the machine_is_*() macros are generated from mach-types. To
> resolve this issue, use of_machine_is_compatible() instead.
> 
> [...]

Applied, thanks!

[1/1] mfd: twl4030-power: update checks for specific boards to use the DT
      commit: 8fb42ee76f0fd5f7b8d4cf5146d8e12df42b19c4

--
Lee Jones [李琼斯]

