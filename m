Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E13A1E81;
	Tue,  8 Sep 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896596; cv=none; b=OnbT0QZyqisRL/eXFwFbuRfn7Kp0rXmbEMazOPRQAx2DR+yhWb9He6cYOR/+cqUwKHyvBlUSy10x+j8X3X1DH2ve0ectMVqz0ytyb7AwvnHwkrZ0G9XBEA9H/Wj/g24+CrL0ZI5M0DOb7+s6aD4tg7Jiy9s+TX6ReMfY93Zorbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896596; c=relaxed/simple;
	bh=xlqEswEziPGf0ZRlGaptPva6ELMXLnrVfl8OWXiHUlg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SgNgdp+JyHMbp8mMrYuRIx4owfugb8n5SWGxTV8KfB/2pXi9wnNGwMnP7USaeiyy+LnDpte0W0UDk1jhwXGc3nIP5/tJeTepR0hvyPZ68hm8GnCXgzHzQTRpTBxn3sjRYa/9vEQX+rDO24UPyKu6Rt3H6iiyqxfstuvecxiZqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U6mPFVk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2Cld9ng; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U6mPFVk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2Cld9ng"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24BAA7A00F4;
	Tue,  8 Sep 2026 15:43:12 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 15:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788896591;
	 x=1788982991; bh=4IJjsl35hy6uWhJvFuqE8L4yxSGKu+5lpZymIsb8Msc=; b=
	U6mPFVk9YL16LJWdXa/424N8Q9tnaQEfkXaFZfC05Rv7g4jpETeO3ajN2fq495Fh
	WrMWE0DREKl8e+FiZIiwVBqHCNQxkGRS9lPOKYYAWBJE1fupx5qElQI0jQ530txI
	g3X5DeD2h8/VRfWue8/KhfhKl1JROC2/WzNBrYwJIF4sNlclS3yqaVAEDE3v6ak2
	7ERTKh65f/H0qH1V8JJl3KCQyVVkUiiUM6IbZARWbZYq5VmWPMicnoqBENNth38I
	cwUAoGf8GVvYgj42lLzAoVmQVfkALFAtU+9JW7ssDaQsghuNEj184yNFsP3Fk+wH
	db58YqvVf1CgsbAr6b3r6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788896591; x=
	1788982991; bh=4IJjsl35hy6uWhJvFuqE8L4yxSGKu+5lpZymIsb8Msc=; b=S
	2Cld9ngfwmUHarBMQc/LHSHeHWD0xtCBeynQUwY/nM+jxDIY8h9wQU0SijPCvIEI
	1UeKVQxK0LSWtuTvDfHOWngQW+JKivd59xMRq6nr1wGJ+RGQT0pCL9Kds9X2runx
	Id4R0A1GnYrDNERfPiYJP1Q8vLXjKG/UfcF0jMSKzYfwb5BpMZE9GabqI2IXZXni
	kKq4xIYCl4XCv9v4dqy+32BQo3yWlSuBZ1XB4rhrzQXSSilmjSvRk+tdOvw+Q62m
	tEv7nKUYq9BDQjn6duHrF7DdeRu1YwZC1RRUCSdXPpldghkrE/Y2Cmi6zC1McD0x
	SLUVnqFm1WUDD7+EKjE2Q==
X-ME-Sender: <xms:TGWgajM7wSAGALfvOn0tYKDarPFdSWSYTFcyb7sKqGRwOaa-2zryUQ>
    <xme:TGWgaozaCDYxyc6ffkMyogw7qY-sR8oaeaSB_DHd5mYdn1O5vI2LHIwT9Y3CPOVsW
    q-fPOeJgxWDBvFvRRObAkHu6rlIgBNykdQrvQlbUysBtUpUMctkb2A>
X-ME-Proxy-Cause: dmFkZTEWysj5ngFE1nM4ud5BEPnvNaVbfYlRDfiGwB68r8EDMkiU5dzpKRL9NlWCptfdbK
    gfYqSYN+zM2p2G/Yb36sHfe9I/KOu0qw/QkNoT2IKpQDasimiA7FGdoW6yMeisRcU7Ho+s
    BCTOjGzEhfUj3P4ZL+t9f53KwQHAUqftFGmSnQ9rLouWbRnDbVR9a1+b+C+MvXP4Muec/V
    Pnuh871vbx1/3VKO6k5vpaVJLH98Mku+zk4Zc7wG/4cDobBB0jqTgHteoMd27vRHO/nxiS
    0jjysIFfqmCGHzCtN1VTOia6Ta1mDR+gs6c2FHBGR/mzzcwxxWOVowCsEHHjW9br5Wasfb
    s48PSXmTpU6kXUvvenJcDEcEuqj5qljSKEZpS9kJHmeDmAEeLZeZ+KZ6847/LJEySgqP2o
    bZWhPCGN5NrPyltp+oBJBs2Dz0+uBeOh41cZdIztRcs88YNCunjoRMiMcjQ51f2zrZH23A
    WgAZg8velj0kko8cn/rU8NOleKEaOpEO9ZRV5APtuQylj7KorLjPWnTvlJUr1wLNsa52nd
    1zfrX5XpW52RTnm3HHcOk7CsE63TkpT0eGNz+xdN7EHW+XcPFE5ojIAOf1j5ADEPfgIvhH
    cMceBWJ/nNjX9ZlH7XRe1MrrpxcJbGiUISI0/dsIUh2MU0KelaKeAo7v6QEg
X-ME-Proxy: <xmx:TWWgau76hFCfszuDLebCtu_Obicnoz1oY4QV544NImgpBVmbrFLXdA>
    <xmx:TWWgamIx8dtaC3Y5Qz36XcUAjyWFju7iSwPqzOgORSdUH-_DrSitXA>
    <xmx:TWWgamxWttHdozSgKKMVHp7vYnUvEue8cpp_Yr84jmKvYJwinmGPtw>
    <xmx:TWWgauKmvGYTP7PhPkc5fWcT22JbHI87VUCq43eLfcarGYdLADfcSg>
    <xmx:T2WgamK7BjD-KSv4eKe3JVkV1RWLIt4kYji1aOSvJ72E0WheE6FecdYn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 25BF232A0078; Tue,  8 Sep 2026 15:43:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABtt46vjHSU-
Date: Tue, 08 Sep 2026 21:42:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linusw@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Drew Fustini" <fustini@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Vladimir Zapolskiy" <vz@mleia.com>, "Stefan Agner" <stefan@agner.ch>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Roger Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew@lunn.ch>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Kristoffer Ericson" <kristoffer.ericson@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Nicolas Pitre" <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "Paul Walmsley" <paul@pwsan.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Kyungmin Park" <kyungmin.park@samsung.com>,
 "Helge Deller" <deller@gmx.de>, "Tero Kristo" <kristo@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Message-Id: <5c7ef711-0e5b-4006-831f-c1129acc65be@app.fastmail.com>
In-Reply-To: <aqBXOemS4boakDGt@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org> <aqBXOemS4boakDGt@gmail.com>
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 21:21, Karl Mehltretter wrote:
> On Tue, Sep 08, 2026 at 05:27:56PM +0100, Arnd Bergmann wrote:
>>  86 files changed, 60 insertions(+), 10696 deletions(-)
>
>> -CONFIG_ARCH_MULTI_V6=y
>>  CONFIG_OMAP_RESET_CLOCKS=y
>> -CONFIG_ARCH_OMAP2=y
>
> With CONFIG_ARCH_MULTI_V6 gone, CONFIG_ARM_ERRATA_411920=y a few lines
> down can be deleted (savedefconfig drops it)

fixed now

>> diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
>> deleted file mode 100644
>
> perl scripts/get_maintainer.pl --self-test=patterns now warns:
>   ./MAINTAINERS:19896: warning: no file matches	F:	arch/arm/mach-omap2/*gpmc*

Ah perfect, I was looking for that command, and will check
the rest of my series now.

>> @@ -560,13 +533,11 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
>>  	 * We still need this for omap2420 and omap3 PM to work, others are
>
> Stale comment about omap2420

fixed.

>> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
>> deleted file mode 100644
>> [...]
>> -void __init omap2xxx_voltagedomains_init(void)
>
> The declaration for this is still in voltage.h.

fixed.

Thanks a lot for taking a look here.

       Arnd
