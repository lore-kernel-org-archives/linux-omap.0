Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0A3D7A18;
	Wed,  2 Sep 2026 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337816; cv=none; b=jWIAD2wtEyLLfCUhgQG1Gq3AeO+z4HC0TYyWa1f+sWS/5CZO0Yquf/ZdYy+7EBfsiIGHAPHb0V3LxbCLNuei6Irc8L9SM9kwYlDNvabDmfiYHreQ6/GVljBD3SDuwmG1n0Vjix77Yyrfkd1ZvlQ/Umrdx1QAEg8M6jxfMpcTZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337816; c=relaxed/simple;
	bh=p9/TMtF9B6gGW8ww0VDbOuFqE32oPW1eyBSzktShqa0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=oJOh9cqacrQVc4uy8u4z6tusDvVU50QyNsPiC4WDeHfbCtiUasSpjD12+hYdIVpcJVmHT1fK6jUWI/fMizzLv+xuFS4pAhh6s3NZhbOxbmoNv0ID5XlBG8bw2s8mp7W2udDSbtANV/AQIEJ10aVx9Ym11xC8BzIYfDCDW5+hKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nM6pZzfB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nM6pZzfB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2FCC01A193E;
	Wed,  2 Sep 2026 08:30:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E14686053C;
	Wed,  2 Sep 2026 08:30:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B61811C792AC;
	Wed,  2 Sep 2026 10:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788337805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YZdKpCWAftcptnJNEmrAxxlMDwJvGn6KP9PAe+ZZ0tk=;
	b=nM6pZzfB6xyqLj6RHiiBMchUbO/wFudV2mFFuJ1nV2FSmV+tsf32xq4nGae+jcOI3tX18k
	OgOIJKDv+/RqqfDaclraqGkVXyVa71ymwYlSEV/Rdp0ubbKsPKOpdWEX4hR0J/JQzBMY9P
	G0x7r7mZVAh4ECLm4ODRO/lsDJ0WZlTnupul15NZE1YJPeW/fekJuh9mKFki1RQKz1lwQP
	Gyhgx23iM6JxkDJ6Zl9r135TzzBrESHshJvt7eKoth3UOP3EbRBMBETx/vmJUOHheJmAEa
	ogXyT2mdcNaE2O1IP7cbcMA5Cg4uCugjGQg7nYvVFMIGJyP3JVPcLdH7x602Nw==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 10:30:02 +0200
Message-Id: <DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Tony Lindgren" <tony@atomide.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hns@goldecilo.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andreas Kemnade" <andreas@kemnade.info>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260902082639.69643254@kemnade.info>
In-Reply-To: <20260902082639.69643254@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Sep 2, 2026 at 8:26 AM CEST, Andreas Kemnade wrote:
> Hi,
>
> this seems to produce on OMAP3 (DM3730), even with the init fix.
>
> [    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xf=
fffffff
> , max_idle_ns: 58327039986419 ns                                         =
      =20
> [    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps e=
very 65
> 535999984741ns                                                           =
      =20
> [    0.013488] clk: failed to reparent gpt1_fck to omap_32k_fck: -22     =
      =20
> [    0.019805] Failed to initialize '/ocp@68000000/target-module@48318000=
/timer@
> 0': -19                                                                  =
      =20
>
> Regards,
> Andreas

Hi Andreas,

That one will be a bit harder for me to debug, as I'm not sure I can
easily get this hardware. But looking at the device tree and the
reference manual, I suspect something is wrong in the omap3 device tree.

In omap3.dtsi, we have this node [1]:

&timer1_target {
	ti,no-reset-on-init;
	ti,no-idle;
	timer@0 {
		assigned-clocks =3D <&gpt1_fck>;
		assigned-clock-parents =3D <&omap_32k_fck>;
	};
};

I suspect that's the source of the error: __set_clk_parents() in
drivers/clk/clk-conf.c will try to set &omap_32k_fck as a parent of
&gpt1_fck. But looking at omap3xxx-clocks.dtsi [2], &omap_32k_fck is not
a valid parent:

	gpt1_fck: gpt1_fck {
		#clock-cells =3D <0>;
		compatible =3D "ti,composite-clock";
		clocks =3D <&gpt1_gate_fck>, <&gpt1_mux_fck>;
	};

Yet the &gpt1_mux_fck is a mux, and one of the parent is indeed
&omap_32k_fck [3]. So I suspect the correct assigned clock parent in
timer@0 should be &gpt1_mux_fck.

Can you try it that way?

Now, I have doubts about how this was working correctly so far. You
don't see any error at all without my changes?

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/arm/boot/dts/ti/omap/omap3.dtsi?h=3Dv7.3-rc1#n1036
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/arm/boot/dts/ti/omap/omap3xxx-clocks.dtsi?h=3Dv7.3-rc1#n1183
[3]: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/arm/boot/dts/ti/omap/omap3xxx-clocks.dtsi?h=3Dv7.3-rc1#n737

Thanks,
Mathieu

>
> On Mon, 27 Jul 2026 09:41:39 +0200
> Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> wrote:
>
>> This commit aims to solve an issue I've been describing a few months ago
>> on AM335x SoC [1]. I believe using the parent_data field of
>> clk_init_data structure is now the preferred way to convey that data,
>> and it should be more reliable than string comparisons.
>>=20
>> [1]: https://lore.kernel.org/all/DI4RUFQNSSNP.2QMSSQWJW9I2O@bootlin.com/
>>=20
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>> Changes in v2:
>> - Also use clk_parent_data structure in composite.c.
>> - Rebase on v7.2-rc5.
>> - Link to v1: https://lore.kernel.org/r/20260715-mathieu-wdt-clock-theo-=
v1-1-da65bba1828b@bootlin.com
>>=20
>> ---
>> Mathieu Dubois-Briand (2):
>>       clk: ti: mux: resolve parent clocks by DT index, not by name
>>       clk: ti: composite: resolve parent clocks by DT index, not by name
>>=20
>>  drivers/clk/ti/composite.c | 26 ++++++++++++++------------
>>  drivers/clk/ti/mux.c       | 20 +++++++++++---------
>>  2 files changed, 25 insertions(+), 21 deletions(-)
>> ---
>> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
>> change-id: 20260713-mathieu-wdt-clock-theo-f0c5ba58e258
>>=20
>> Best regards,




--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

