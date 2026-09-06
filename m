Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F461FCE;
	Sun,  6 Sep 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683588; cv=none; b=OiTcdR3Ve0E3XgE49VyLqXPPIqu4Lgotjo/P9bqgEQs99ui7av7sRiW9dZocF0BPXRJ22v4Go7sPKF3b22/rUP5DHn86MFoHIOwnzU363S5n5+UWU9cZTV/CDpdsRJj6AaP+YOlch5mm9RmemZaJP7DZ3Tec7ksG7JXSdJgaTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683588; c=relaxed/simple;
	bh=sUFuBRiwKmjr58Y9SROo5gdumJQ53K3+jmGRSDx3jD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=sAz9g+AnrYUNJJSGA0P8u/5hWqDIwNW233QcAoIV3eubGlnZIJpV0Usv4zMI54cSq6nn+TEddqYuUwAdqX63m3/dHRWRTGFSuZjp/VWCdbbwq/w2kWQjMw/rsE3/dMR/2rRxpcSnk4TX3m+HBREb+FB1pgYOLXWHm4QGIjnRAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYCc69bL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYCc69bL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C60D41A19E0;
	Sun,  6 Sep 2026 08:33:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 876C660288;
	Sun,  6 Sep 2026 08:33:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B29ED11C79850;
	Sun,  6 Sep 2026 10:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788683576; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sUFuBRiwKmjr58Y9SROo5gdumJQ53K3+jmGRSDx3jD0=;
	b=dYCc69bLBTjXm22wZq8e1FvXajAa+n9vt4169JX/GQ6LqIsP+N9NwsiL/7iAsfv9p4lh6w
	Uoyyo3KH4pNqfSEqqNSOzF55dcHssew9hw61Pwbj7dMbAW9VfyuS8tyeBVgVrlWfbz84XC
	jlnRKj0LbqoD9GWlGIWYJ4syWTyMlwxwQxFteGsPL6NYt//BPZM/6ZBmFPczkiMzsLf7Z/
	hDWWKVc4UslZBLcUvpICZg256aYLYC37ltbWNx+BpbjkRAsVO52uspZNKcZyHhPAxYb+3V
	mOZGIkdg09t9b2cu5JeCIuY7D06TosbBWIgDbo27KH28Xwe6NT7pdPs+YRcoaw==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 10:32:52 +0200
Message-Id: <DL83EP6TA2EE.MGYAU17GO6D6@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andreas Kemnade" <andreas@kemnade.info>, <kristo@kernel.org>,
 <sboyd@kernel.org>, <bmasney+clk@redhat.com>, <jbrunet+clk@baylibre.com>,
 <kees@kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hns@goldelico.com>
Subject: Re: [PATCH] clk: ti: composite: resolve parent clocks by name again
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260904181716.631201-1-andreas@kemnade.info>
In-Reply-To: <20260904181716.631201-1-andreas@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Sep 4, 2026 at 8:17 PM CEST, Andreas Kemnade wrote:
> Trying to resolve them by DT index causes massive havoc on OMAP3, Clocks
> around the timers used as a system clocksource are not properly resolved
> causing ealy boot failures. The problem seems to be that parents must be
> resolved by looking into the clocks property of the component node marked
> with "ti,composite-mux-clock", with the switch to dt index, that node
> was not used anymore. It was used by the of_clk_parent_fill() call.
> To a lesser extent also OMAP4/5 boards are affected.
>
> Since this patch was introduced just because of a cleanup request
> and not to solve the actual problem
> (https://lore.kernel.org/linux-omap/alkZmw-XmnCOZfOD@redhat.com/)
> just revert it. Cleanup needs really more thought here.
> The similar change to the TI mux clock, which solves a problem on the AM3
> platform, seems to be harmless.
>
> So just revert
> commit fe3dd92ac54a ("clk: ti: composite: resolve parent clocks by DT ind=
ex, not by name")
> for now.
>
> Fixes: fe3dd92ac54a ("clk: ti: composite: resolve parent clocks by DT ind=
ex, not by name")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Hi Andreas,

Thanks for your time and testing it this way.

Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

