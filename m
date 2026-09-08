Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BD59E328;
	Tue,  8 Sep 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892461; cv=none; b=vDcJtmMEPoQhiEet606UC20KRAEKjpfnLst7psp4vlzi44N5mvvFO54tsl1dMHvHttWVeqF+65TGClT1upPZLol2u7mbrnWGVcnnpZThxltQjlAB08WwMkYKtgEmnpKMvvqHKyVwrsMMkNOTmi4OsQlh7EiTEgBRWFWSnBIOHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892461; c=relaxed/simple;
	bh=CAUYxFIfOAUGf/eLL1zwg8VGlQjPE5mkI0urQpJ/E/w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ClWfx8jM+eicIMnXJkgW1rUZAGqykty4UAODTFxIalvvquETEE8VWUtKNc/K/TXRxocsnDBR5F5lvbr9uSO8xcgBiE8e+KPxf0iO7mWwqpADYHyQZKNjxryk1Ec4SrQwQEAxe2Rz32FSJ6ElzW+R82coIAYThEJy5L6Ut87ezaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O8kDBEJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nh51fYk2; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O8kDBEJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nh51fYk2"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 462FA1300D1F;
	Tue,  8 Sep 2026 14:34:09 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 14:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788892448;
	 x=1788899648; bh=mehW/CyDxkmIO3arqkZApC9ipZYWGbvNNWYPndTatYU=; b=
	O8kDBEJFUQ4hnv1KhcAzt7/VLZmhjlvZ8edI/TbX9L6wqWImnH/qIuTP0F5KonfL
	fEm9ypqoiQpZNXZdyrT17Ac0Um/DowwvD7fx+ZJTFJwPSJyXfLL5l7gzF/Idymr4
	f1epRMggcMnlJq7KSiCZKpteSuyKeAFbhIb9T+x2Zr8GG976/DOjIr1cQEwabi6E
	mfQHPmaQlGCGffsknNmqUo48DrPjICNMv9IRhh72V5Vmg8/BPQxR+3XkzX+fAZzn
	MVATdcImD4H2uXRjhtOxv1MGK319Se0qL1lYqAusfl3VUcCkqOPoxtZjW/pcodwj
	x1+UoIkU5uRwM+pqUDy4RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788892448; x=
	1788899648; bh=mehW/CyDxkmIO3arqkZApC9ipZYWGbvNNWYPndTatYU=; b=n
	h51fYk2zApplolvODNqDSJGm4M066/laYwyyzuFNbYJHYmj33L68Xx7qAQFPWbG9
	OtoW56HY2PvXMTAxHGg1eZ08JwLYKkdBxzpHAKrjhsNEmt++3ZTWhz0QAT/fimgF
	/u+E9z4OyDlIVsYYr5PvIih43auCfg+qLieBiiHjToXcyIpdYR68vqzrBofQObR/
	o0zxM0tEvbHUcohNzFkNwfauajQdPwpIHVJgec69cvAdMZd4Kvv5YxVZUFkGotn/
	X+900FTmnBlSqkXdA1Iiik481dVrIeTVRqD2oht5FnSxVU1A06Xd0Kn+BkjuqpCf
	M+Ql3TBD1irt3E8kyvHPw==
X-ME-Sender: <xms:EFWgauu7GtyXgWQHujeZXC7kxuUAC_fi4FQ66bW0xH0tqluuSR9odg>
    <xme:EFWgauT4aZ6C2Yp_TEnfEXr4R2JO16aYIdaS6AKCTfr93DQiqwAyR0Kp5YNjM4nrX
    d2_w13l5PCarWY-aO1VEQHJJmhtdIGli7HZbyK9sLGynnVgu5tol-Q>
X-ME-Proxy-Cause: dmFkZTFPhVyeTYuwUsqrCzczPQ7NQS9SIU5BZcx5bS0XoavZIvkpWuRfxUE+TdQzqIZ8W3
    KgRh5EaF0ATxLS3kYVyZadsjYR3587lVpn4U6wibqTG+Z+vEyX1K6BTf23Wl2vKcZvzswW
    u896gNmqAsTDmDcBXdf+mKoJ6wtOOjaW4gf3mfRO76i5F5Fuzz0E7rvkdFBTjhtevaZfOV
    2h85LBbFVxyH/oOrwBnvcPFLPz6Ba+tOAtLnWJWDeqSBK89IvitzmWMb/bG1kty+HzE4j8
    t520Am6gozzkkQw5hKQLB5hk0heSKiwJnCqMl0Wt5slkx2lDfY55HPemu+FXy+aRnHd3c8
    EgdCB1Eo7AlOganWzCXK9NPTeR9XP2OOrta8BRxSYYW3WSbQk/LE+6tZH5AfjA5ISpc+nF
    ZBoS1kg5/CNGMB82EvzJlOWmxvZsrb+44jACuhaya3QA1nYa59bH5ivm4eam1s+O6yXT+D
    Es5aM9afF/dIB6q1FUUobemW/JB0hmtjVDggfdDSy7y8WXdqdrKiwFIaSjFeLYFXGoNsQN
    QHTddWgdmwDwzI3kyaQTZN/Ldx7dDZifv9UA8D0nNEso15LHPNQevm0ZpUqjkP6TdZ6cUE
    6WVwBkQiqWw9SVWbppCzMBNqkmqsXmGSEjFiFR4FLFX17cwUPJ6ewti7U/xA
X-ME-Proxy: <xmx:F1WgamlKMkU1kjxuFOg-_KGizDUsqst_ABIUsKjsRch3bpJytV-1Yg>
    <xmx:F1WgajiTKAGQs6gDLhlMV1v79AmLVF51M_rhNVUV5O72N6_z3z_l1A>
    <xmx:F1Wgal0RhH_jqzPU5xa8YOZ5ILjUWM9g7vCAzV0SXzjNf_OASrAq2g>
    <xmx:F1WgaoYsEeJuD_jtW46ShO3uMCgKV-lDDTZIDnboqPyRElWa9RyzVg>
    <xmx:IFWgarC94hF2G-29Xy07G5l6HzSUV8ei4nAmOV2N7J7lYRKVm4gcoHbV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D0F9232A007B; Tue,  8 Sep 2026 14:33:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArxhsfFjo9nk
Date: Tue, 08 Sep 2026 20:33:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Randy Dunlap" <rdunlap@infradead.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linusw@kernel.org>, "Russell King" <linux@armlinux.org.uk>
Cc: "Drew Fustini" <fustini@kernel.org>, "Rob Herring" <robh@kernel.org>,
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
 "Karl Mehltretter" <kmehltretter@gmail.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Nicolas Pitre" <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>
Message-Id: <173bb63a-59de-4961-a841-4a2fd0c2bcac@app.fastmail.com>
In-Reply-To: <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <fd157e63-e581-44b6-9e4a-962002669438@infradead.org>
Subject: Re: [PATCH 00/13] ARM: deprecated platform removal
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 18:53, Randy Dunlap wrote:
>
> If netwinder is going away, can all of
> Documentation/arch/arm/nwfpe/ also go away?
>
> Or do all of these come later (in phase 2 or 3)?

nwfpe is used on all OABI platforms, not just netwinder, so
the patch to remove that comes in the next series after removing
OABI. See

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=ff375183fe225b79de700f004181405ff6a739cc

for the draft patch.

      Arnd
