Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6589314D34;
	Wed,  2 Sep 2026 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330423; cv=none; b=E574hw6MSlyL0J6bicRcc7qbZmHQKxzSTyGcFPya5Lfen8MY8Xw7jkxkZ1hu4Grqh6d8jNB5R2Oio1LRDdzZcT5Ahs6ypyYRk4BHnKjxclqggbCRoQgbCYMSzl06Ok39g3re0drSH0qgg21OWiAAQm4Z1mRVgjxPAkF3bb2Z72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330423; c=relaxed/simple;
	bh=EwgEK/M4R+ibVLOsyxFFIoPegK+UlLukoar6tG6T180=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTiegaxwO+/4EHhnQ2BISGMePtbzBg79c137K13rnSZfSXV9rgSPm+uH2+R7bvVmawD9zDrvrtYgEEWszn3vMZ9T8MAg2CAKXU0FnsctFebopswEZK0ZGQtW4jL6G8xtz5IEzKeWIjPLi/ojNW6aX2E3ROrW5eZ8uih2KWRkZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GQgPH4vD; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GQgPH4vD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=5ryKsfyArI7gxOFDLJhCI89EQrP756HMoQ9H0TpnbAw=; t=1788330422; x=1789540022; 
	b=GQgPH4vDT6KVbnNjNWU2oIQa0NjlhPoGtkp+kWFKY07EAUc1256XNykqcJOGjij4gunXLzJkJlo
	Yc4kD/EBaoRTd6wuW+YmSg6YygrJKIvaVv8YvRiE0OOpvb543Kp3wwp/zd1RVl10/cUdLDsRO0cdv
	ZbuQc+uAc93cQtr+XGtNL8WZf+VvqGVOhHqxktaHvzLYSLbamjkY1gEQSnvvAR3EPVZO5nNr6SELz
	OPcf01kVdecmwh+2a54JR43FrLe01kjRFkGTtPFp9HEjfm3bsqa7mi1WYYDfQ73D1Ovea+9T3McDC
	t+qOHw3013ZfS0uockMRy6/JsGEHMVA93qRA==;
Date: Wed, 2 Sep 2026 08:26:39 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldecilo.com
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <20260902082639.69643254@kemnade.info>
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

this seems to produce on OMAP3 (DM3730), even with the init fix.

[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff
, max_idle_ns: 58327039986419 ns                                                
[    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65
535999984741ns                                                                  
[    0.013488] clk: failed to reparent gpt1_fck to omap_32k_fck: -22            
[    0.019805] Failed to initialize '/ocp@68000000/target-module@48318000/timer@
0': -19                                                                         

Regards,
Andreas

On Mon, 27 Jul 2026 09:41:39 +0200
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> wrote:

> This commit aims to solve an issue I've been describing a few months ago
> on AM335x SoC [1]. I believe using the parent_data field of
> clk_init_data structure is now the preferred way to convey that data,
> and it should be more reliable than string comparisons.
> 
> [1]: https://lore.kernel.org/all/DI4RUFQNSSNP.2QMSSQWJW9I2O@bootlin.com/
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> Changes in v2:
> - Also use clk_parent_data structure in composite.c.
> - Rebase on v7.2-rc5.
> - Link to v1: https://lore.kernel.org/r/20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com
> 
> ---
> Mathieu Dubois-Briand (2):
>       clk: ti: mux: resolve parent clocks by DT index, not by name
>       clk: ti: composite: resolve parent clocks by DT index, not by name
> 
>  drivers/clk/ti/composite.c | 26 ++++++++++++++------------
>  drivers/clk/ti/mux.c       | 20 +++++++++++---------
>  2 files changed, 25 insertions(+), 21 deletions(-)
> ---
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> change-id: 20260713-mathieu-wdt-clock-theo-f0c5ba58e258
> 
> Best regards,

