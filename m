Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791368;
	b=IlI4V8sYW2U2U8TNKa54P9M9PvA/6QJeN5NYkrbDQy7gRYdg/u5KBkJrQBDfZ3R+xi2N
	 6LEDo9SURrvnrB3ssl3yI/9+HXYyCZy/di1zynqN9wNdfBlww0FmnyhBGH3/seFHj4eHx
	 2SxeXt178Iqx2g/OF6AwPQcDv/45G2TIDET6GxTe/2XKJTdQ2XpiS39YuxlBP2bXKAi6Q
	 y51lsqt1/alnJRxjrkBzPZaKFd+Lkxa+he/HVYLa2NHb3Qz0Kz7IumLzOAagJUSwp5Nvj
	 rWVLUng2eTakKWf38i7ASz3KD/I/vdMgw9z8idw4LxKHOunS7tf86IbzkshRG7V5lCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791368;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=azj6je3Tauy8PqvAOV9GF0M1ghGb3gi86TBsOZQKuHI=;
	b=smA8py+LBVnuZDfzeo7uEatXlB0MQylTOH8TksP1nq+wDBqs2SInVyFDRHWhl0SykOo4
	 p8JuJEFKQokk+tUBV9EgohMIouynLOFACunCE0phboCXIdTZfNkbilggo8s64DamVXwdv
	 purN0q96Bl+WtmV6/t1Z3GH39owPo1kspzvhN9p7AG5IXlRucqkt7VE8sbwmCR0f3Ve6Q
	 R0s3q/MTLtY5lXbu+i9Nnv7QcVPbDtd7nJ7Omc0y38NeHqqDLulM9fhVMRCQBOWRim1dM
	 MUOSQ5h5Ts+OkgENP6xPAEPVg0Qe/6uaS9s6Lsy5Im1qmEL7OZO8JhhELx8clu3AGkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dR6JifXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A56606A33C;
	Wed,  4 Nov 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dR6JifXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47121F00A16;
	Wed,  4 Nov 2026 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791367;
	bh=azj6je3Tauy8PqvAOV9GF0M1ghGb3gi86TBsOZQKuHI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dR6JifXyfU9+Y+e04PesO3E++kcxRx69CrNmSGquGaUV1ySlmdnmSjlqY9OoxG/Hj
	 mWtZzk0cQfCdyaCV7O57wwJFeE/6sw35rZkll+/dLiMvNg1o6olImYUvB634Fu24fM
	 vQsqA5hyNW2hwx64i7HsIWjT2Uk+K7hl1Zite2vL4n6u3fwysMo6BWn6W2UIReJH03
	 dqq11TVUEGjAa76UN06pRnWl63W3cAfo37m2dC+Rs6cmHHd79pjHnxAWeCj+f7l/cm
	 26bUN7KDFrYjBKzRa/AEFxTLNLKE7q5WCZNfD6gJTFb8OgCjQY+cwegiLR4LZnOhOI
	 +b1S8pxaSiP+Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Brown <broonie@kernel.org>, mfd@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8aec913c6a80c26c4cf5a1ce590f8439c997dafc.1793044546.git.bvanassche@acm.org>
References: <8aec913c6a80c26c4cf5a1ce590f8439c997dafc.1793044546.git.bvanassche@acm.org>
Subject: Re: (subset) [PATCH] mfd: twl4030-irq: Fix a lock leak in
 twl4030_sih_bus_sync_unlock()
Message-Id: <179379136541.1658386.17812950773017437620.b4-ty@b4>
Date: Wed, 04 Nov 2026 11:22:45 +0000
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 26 Oct 2026 12:55:46 -0700, Bart Van Assche wrote:
> If reading the EDR registers fails, twl4030_sih_bus_sync_unlock()
> returns without unlocking agent->irq_lock. Fix this by jumping to a new
> label in front of the mutex_unlock() call. This bug has been detected by
> the Clang thread-safety analyzer.

Applied, thanks!

[1/1] mfd: twl4030-irq: Fix a lock leak in twl4030_sih_bus_sync_unlock()
      commit: aed393ea3707fd3573b78449037e2749e9b30245

--
Lee Jones [李琼斯]

