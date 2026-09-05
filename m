Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4C2503BE6;
	Sat,  5 Sep 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635060; cv=none; b=Yb3zjL5wXW5cDMRrvApwyWxnnIJkUms8aWLi90wTpPZQNvHANUr6zXCByYJZWQ+YnKRYezwnIzRZnCw6MW0Ujh073NWhJn2Dt50CqwhqFViB91nzhzKaexGr6N9U9tWs4A25wt1X3qDKk3Xcq6/cW74xnCB8vVnLKn24hysDTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635060; c=relaxed/simple;
	bh=ZO7QoC55JS7YlrPj7n0tc+0W47P37ccqMQAZ8EeLG2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZiTWHGz9rF2s/sSCemSOJyntjvbAn6Sn2QifPhlYuCUgPVsoux/kxVeUloBggVWINahDwN90NoMJLZNDMnH9FkP19tTdmW0vHSu2BEKG909F3L7D9c7QQOXGWj06xrA4p8Vc8grZFjXuH7KQqeZFJf2ClpAvxPrLm5k4OBwsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGZK3QdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGZK3QdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348EF1F00A3A;
	Sat,  5 Sep 2026 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788635058;
	bh=ZO7QoC55JS7YlrPj7n0tc+0W47P37ccqMQAZ8EeLG2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bGZK3QdNjedBzOdUANccbLKsTmyU0rDMg1V3AvzOw4poWea8kGxs2E+vX3rkzrgiB
	 KnbVlVWeluoqRYYYipEvWzTQ29XK4z4R5pvKtfXP1alBXKG0kP5dd3LMoM9pn9a3GT
	 gRR3RPmUBW140oaCy42R7rFAk7Hd5h2f0y3vABFeHZUxePUbbJYSxN3IYNv5ke/cww
	 IFXCkDblqcA9ekeWxs148h1D9nRiYtEqj5ZZHC0yfTKPQT/uYgXI+ue0xNtb7Du9T9
	 WDZ6pGyF6xS3tBM6jcVIEvfIdfyNPgwORLbTMX/l0h9aTWoKPPY8wbvoj+0NHJP8AH
	 7Kf+vcht5wgHw==
From: Thomas Gleixner <tglx@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
Subject: Re: [PATCH 4/9] docs: kernel-parameters: Drop the
 enable_timer_pin_1 entry
In-Reply-To: <20260905070347.25902-5-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
 <20260905070347.25902-5-kmehltretter@gmail.com>
Date: Sat, 05 Sep 2026 21:04:15 +0200
Message-ID: <87ik4j5xlc.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 05 2026 at 09:03, Karl Mehltretter wrote:

> enable_timer_pin_1 lost its early_param() in commit efa2559f6516 ("x86:
> order variables in io_apic_xx.c"); nothing parses it any more.
>
> Drop the entry.
>
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.
>
> Fixes: efa2559f6516 ("x86: order variables in io_apic_xx.c")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Thomas Gleixner <tglx@kernel.org>
