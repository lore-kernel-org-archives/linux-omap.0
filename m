Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3146AED3
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492804; cv=none; b=MwRWejYGwWRs8VNh7Vj1Ray4MdAydgdr++wGXtPLNzegscmbf8aA0l+Ms/f/1+AERcoac6otKG3cVam3pJoUavf7wtyThFodmBAdgTP+mMXukJ+zvuJhuzODv+leuXW588Y6Jy+ou5ezh7TSsebDtqyZkMy7PeF9dlRH6UKVlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492804; c=relaxed/simple;
	bh=v/zafkuBWfuv5SOmCB5JYsn5RUzq1lmAdrajTwA2lcM=;
	h=From:Subject:To:Cc:In-Reply-To:Content-Type:Date:Message-Id; b=Ri5pvjblCLt4cgei9TIm0UM4deNMsRz4YByVhk0W84ePC+6qEC/jVeUGgKIFcgkViIUX/ue2Ee2sUZGYLkRFMlfYZ4VUgcGsHXYAxfe0M/h6re/LSyn4nzIfy+BSSCx80MtWjPUvESDxbK71/5TM2ht+c3TQeZecxUBOYTZJJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1wUlVh-0001fQ-E7; Wed, 03 Jun 2026 15:19:53 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1wUlVh-000v5L-0w;
	Wed, 03 Jun 2026 15:19:53 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <sha@pengutronix.de>)
	id 1wUlVh-00000001DeC-0lJB;
	Wed, 03 Jun 2026 15:19:53 +0200
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mfd: twl4030-power: drop dead machine_is_*() macros
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: "Sascha Hauer" <s.hauer@pengutronix.de>, "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Kevin
 Hilman" <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, "Lee Jones" <lee@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260603145844.3d8ee4f7@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Jun 2026 13:19:53 +0000
Message-Id: <E1wUlVh-00000001DeC-0lJB@pty.whiteo.stw.pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>

On 2026-06-03 14:58, Andreas Kemnade wrote:
> On Wed, 03 Jun 2026 14:52:34 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > OMAP LDP and 3430SDP are converted to dt in [1] and [2], the
> > corresponding machine_is_*() macros always expand to 0. Drop them and
> > with it the now unnecessary inclusion of mach-types.h.
> > 
> > [1] e92fc4f04a34a ("ARM: OMAP2+: Drop legacy board file for LDP")
> > [2] 1b383f44aabc8 ("ARM: OMAP2+: Drop board file for 3430sdp")
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> already in -next

I am impressed. After ten years this sits dead in the tree two people
manage to patch this at the same time ;)

Great, then disregard this patch.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
