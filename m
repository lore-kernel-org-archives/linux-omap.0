Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C173382C7;
	Fri, 24 Jul 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904970; cv=none; b=dEqMbTL1C679Z0MUzPp8Q4v1u6B3InV7wHkzOTisbcS8DchU28iJIGU6RP7KC5ykmIS5PZpGaapYXOiiSxiqck9RPcx5Hqwmi2QV0Tt/V93S0apJTbSBgegJ7+JUsr06HJ3Ku9Si1w/zPlvi2kg+scty1mQq1M6bw6dSKsWZfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904970; c=relaxed/simple;
	bh=p/sBH7GvWXe9h87iVhtZr/sj144hCGg2f/lFVpzev+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=S95uqKivkk7yMZhdxZkhjr01VmN14i2CNrY+SMraHhwkuT15jhTzkyYKvsj5576tnG2h6NUI8KcjKaehTPjLl8xCnr6OANJ0k/5vlIqgkDDc2zUZ7bpEceFTNY18QgorEQPZfh/njuAhsKz4w9Men8BmrweyPeBzosQEfZTpw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qdplBXCn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qdplBXCn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 780AB4E40F30;
	Fri, 24 Jul 2026 14:56:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C6C460395;
	Fri, 24 Jul 2026 14:56:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D198811C1266C;
	Fri, 24 Jul 2026 16:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784904964; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SZXLp1jkZefR0yww6P15ycBvIS1KbcfYamTfMTfZmhY=;
	b=qdplBXCn2UCD9g9D+4bO72q2Edpd9WgtgIqWw/P+J0JJ0jVc5GqUeILHCS9fjNkeVywiso
	4fT2Z+4FQtzHCu4qJK7vBoLqIgTjDCiW9B8JjMvj12hDu5OSr3FPpLEZD9VVoRpd2Yhl8n
	+eDRTwM24L3K5Cta8nOp808gk8ZSW1WQVt9BYVSQ+ejEtOYw3IAQSKCrx/Qq4hJvkMm6gO
	TkgzuiqnXhVYr3qVgvpJcDj5Il223YViODN2b6R+fx0oPFOO2liL6gRIG5HjVG5BLmoTAe
	IoFEJffX0f5AQnOB6pmz37fgZCqdsq/uLuAKuAuU2EnbLahy+M2lwu1YpD/hYQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 16:56:01 +0200
Message-Id: <DK6W03NSALJN.1SASGAY5HWSPN@bootlin.com>
Subject: Re: [PATCH] clk: ti: mux: resolve parent clocks by DT index, not by
 name
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Brian Masney" <bmasney@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com>
 <alkZmw-XmnCOZfOD@redhat.com>
In-Reply-To: <alkZmw-XmnCOZfOD@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 7:49 PM CEST, Brian Masney wrote:
> Hi Mathieu,
>
> On Wed, Jul 15, 2026 at 05:09:56PM +0200, Mathieu Dubois-Briand wrote:
>> Resolve parent clocks by their index into the device tree "clocks"
>> property rather than matching names as strings. Name-based matching is
>> fragile because a clock's "clock-output-names" value in its provider
>> node can differ from the name used to reference it in a consumer node,
>> and because names must be globally unique across all clock providers.
>>=20
>> On AM335x, this caused broken clock trees where some clocks failed to
>> enable because their parents could not be found.
>>=20
>> Replace of_clk_parent_fill() with a clk_parent_data array that sets
>> .index to the array position.
>>=20
>> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>
> So this only updates of_mux_clk_setup(). of_ti_composite_mux_clk_setup()
> calls ti_clk_add_component(), which does a name based matching as well.
> It would be nice to have this consistent within the same driver. I know
> this is going to require a larger refactor.
>
> Otherwise your fix looks correct to me.
>
> Brian

Hi Brian,

Thanks for your comment.

Yes, it does make sense to make everything consistent here. I'm not
really comfortable with this driver, but I can give it a try.

Just to be sure, are you talking only about drivers/clk/ti/composite.c
or is it about more files in drivers/clk/ti/? I'm not sure to understand
the whole interactions between each components here.

Fixing drivers/clk/ti/composite.c to use clk_parent_data looks easy, I
can definitely send a patch for that. But you are talking about a larger
refactor, so I suspect you would like to see more changes.

I had a look at the other files in drivers/clk/ti/, here are my first
thoughts:
- drivers/clk/ti/apll.c, drivers/clk/ti/dpll.c, drivers/clk/ti/fapll.c:
  Changes would be similar to what was made here.
- drivers/clk/ti/divider.c, drivers/clk/ti/gate.c,
  drivers/clk/ti/interface.c, drivers/clk/ti/adpll.c: I believe we have
  to stick with matching parents by name. This could be made using
  clk_parent_data .name field if we really want to switch to
  clk_parent_data structure. Is that a target?
- drivers/clk/ti/clkctrl.c: similarly, I believe we have to stick to
  clock names. Using clk_parent_data structure requires a lot of changes
  in drivers/clk/ti/clk-* files, but these changes should be trivial.

What would be the relevant changes here?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

