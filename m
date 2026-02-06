Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7364428850;
	Fri,  6 Feb 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405064; cv=none; b=iBWX8EXGeGP6/XaEDN85cMAqEU3kpX3h/B4V2o+C6txvh61NLzl3UWpE63JXRnSscsklZgfd9gVIgwBOEbuo2vKp1cQ7o/eNooLxlB5ay42USi9W6WDHc2DrBpKmPnOxoo6Xtm8LwgbyiIb/Jy0JJePnF6MDaIqDxJBTgElgQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405064; c=relaxed/simple;
	bh=0l/fKexFdKKIPT3py5+h76i7FirO+vJzod+jEkfsFjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PRt7KgMCgAUbB+TGaYPjl2pX+o55QloIuEY6fqTKonG9xy/KGMpjBylPhbB1N7WlG7qlplLOu1EarJpYwy7yAGZYwyTgK5yz1EXDKg/KW2Cmq4/qQalkQTrCHUjDlf+j0JsIxuvkOK2qPGLMmvm787rEQLufHINtxQcNzubCwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=c3brLmOV; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="c3brLmOV"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1voREJ-00068X-MR; Fri, 06 Feb 2026 14:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=0l/fKexFdKKIPT3py5+h76i7FirO+vJzod+jEkfsFjc=; b=c3brLmOV0uyqNO9urvbz
	qeSCg0g/3j5SGgO+4Mq5Grp5uIEKu9ByMVJ9AMjAmFrCPs8X/zk+qDLBPs+7JaToL06/KeO7QoAYw
	M1txyIbJwiH0s/Khv675dBkWeXbAJcju3fvhhVh/STA9+IxDiIdqkk6HsOTTH9YRcemzbhalFwuf3
	M4Zf/qtBdI3q2IRreSh2yReEXLZmAjn/nV+lqqBVRuCOeP0BFa1jPAH61imjX5KSDlMYfCEtOk90h
	cD1sVIC/Jp54hxnPgArg3wAzrSqVbbhCkdk7aDSP4FD+UvUtHGgqZKEPh0UBvDknKd0NLiXMJQEyl
	UB9yE37VrrFJiw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,  Andreas Kemnade
 <andreas@kemnade.info>,  Kevin Hilman <khilman@baylibre.com>,  Roger
 Quadros <rogerq@kernel.org>,  Tony Lindgren <tony@atomide.com>,  Matthias
 Schiffer <matthias.schiffer@tq-group.com>,  linux-omap@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ti-sysc: allow OMAP2 and OMAP4 timers to be
 reserved on AM33xx
In-Reply-To: <20250825131114.2206804-1-alexander.stein@ew.tq-group.com>
References: <20250825131114.2206804-1-alexander.stein@ew.tq-group.com>
Date: Fri, 06 Feb 2026 20:10:28 +0100
Message-ID: <87pl6hpu1n.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

> am33xx.dtsi has the same clock setup as am35xx.dtsi, setting
> ti,no-reset-on-init and ti,no-idle on timer1_target and timer2_target,
> so AM33 needs the same workaround as AM35 to avoid ti-sysc probe
> failing on certain target modules.

On am335 (Linux 6.12.66), this commit has solved those two errors:

[ 0.882765] ti-sysc: probe of 44e31000.target-module failed with error -16
[ 0.973457] ti-sysc: probe of 48040000.target-module failed with error -16

but has in turn introduced those two:

[ 2.149708] ti-sysc 44e31000.target-module: Failed to create device link (0x180) with ocp
[ 2.149735] ti-sysc 48040000.target-module: Failed to create device link (0x180) with ocp

Any idea how to fix those?

Thanks,

Mathieu
