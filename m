Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD95262FC1;
	Sat,  5 Sep 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603211; cv=none; b=VhKh3KUP3mLLCEkG/TifQKHrUQioR4552mUAwARYUYZoCTbpWm7zYgGusAQsDSsk2AtrxTgVms9oCp3uoc58GIgCSbvObhVN4sozHv9oXQTFZqpabqZJ4Z/NiYsNWxuFbU6oXbWMVoZp7W4IChlolytRSHI/nrnmpkmT7HcxGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603211; c=relaxed/simple;
	bh=NJSqlHD37INoc1+8xMdO8n5G/1SJs6PcUD6wuZoGE18=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j+103nvyVRu0y6wV/rqYNoGcOYwHJzzwqpbJce0iazKu0QlkudWGphBRs1Jgj1il6f/8EHTlTyJlToCcbx6kv54xNQa01nH7xTTEIZnlIjA5TtOllTZ2EInZHVaAzFvq+arp1QjhLw120+FNsk3OuALrmefzDE1c2rZU5h7q87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DBmv3ukj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEw/7r7R; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DBmv3ukj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEw/7r7R"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 5C2871300171;
	Sat,  5 Sep 2026 06:13:24 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sat, 05 Sep 2026 06:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788603203;
	 x=1788610403; bh=s5Pdm/fx3nduxQtcVl6TUYT4x3GVjZLFxT9EXjbWN9Q=; b=
	DBmv3ukjHj8j07tSdPdiH2JToVRjL08m1iZ9+gfVrQkOxRirqWEpVPO0dhoxhTit
	vlZA5zwc33EGQG1ZSAZXi3lUknl/5DJRzQf2NX4iUoeF8dsXjZMRJ/rfKAW3dTbM
	ocB19jJRFzOmrinM4EL56NYHh3WJTLPEE9CzvtlbYCWg39Ejy7TRyv0tD9wL6YFn
	Kno1cq+OIXrKnoA1/PkX5ZR2NSb1Xoj/o5q8hRcd/uuV5ldsdqlCnW0m1SKEckOL
	w5zil5NSFXgDjBiXR0fTp8tPpEpg9t//zcgLNihKjXospRHWKFlWVJtTGstWDHE6
	Vh/BTS1ouJwc21jBSjvHnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788603203; x=
	1788610403; bh=s5Pdm/fx3nduxQtcVl6TUYT4x3GVjZLFxT9EXjbWN9Q=; b=E
	Ew/7r7RCyjkKYKLqQtjJYuiiklDYNyJGd/bIMC9EU/b2Trc7ALqDgkLfXUNPKeLB
	pc/uj4n27HoPuqRJcPcPAny680AGstHqeX7YrHiflBWf4isC3zsYlKZABk5s5rlU
	FaZjHlnSlcKaq8RKOHgzOjQvfz0IJEO45MpqmdzzbsOsUiVzFIlw/CI+w9wITLWS
	N6w2BNgP2DeQaG1P0R2RPwIcCBGoL5QNTPoXyo17j+NmjCbJ6fFSDZBDWExPQ4Qm
	SF7iHYDrplOZxUNuGl5hGCVZRmUUoH44ueRk9DuHqwIFj3oMmPWK5qgpcvB2zcx3
	ZRAEUQpGgw61f817YKwLw==
X-ME-Sender: <xms:OOubajGQ5QqXy-m5z6KqqMh_DsM201vWq14Cac6olvrdHCxukQn7CQ>
    <xme:OOubarI-BSpZ4yKtbuNGmaSZHfkq6ZQjcWoNfrxiqDld2e4QJ6uzzZdtRweCh70HC
    m9xkpxNEUpQ1WDsBepUILKRaA1irQm_6v7kSm8zUMkCSiaLCQTCnCc>
X-ME-Proxy-Cause: dmFkZTFs6JiRJZvxm+Ld1zJwu35HcCPfSmdka7WkN8Ycq24gzWFFqx4jqbfwmS2jZqJcrZ
    /FKINazIOWPInQNVp92+nCl0q1eQHggUKBKETX7255000VRkk3eEowI/hgJqD4ZygmGQle
    v6l5Zwc+LSWgWtAQCfMDwVuhcFRr128FqExoGbaXUz+Ukcp4CmTu3bpi89zpgdsBb2w6hY
    +eJh2+vjNBR5GrUtizfqE9tDxH0g97x5vXVH7A65/yUARxdMIDdWZuVS0p6RyBRQ34EGjO
    JHY3kJLUefCR2NFc9QAYL/UQWOLqHlP9IDrInmsA5rApTMpDseAV6Y7ddm0ojOYLyRpIp9
    AO/EH6n+bVRnttFc/ipehsxObz2bN55Rpje5y0lDCiXDzr/bUfEzRzOROxuQJj1XpAm+Aq
    N14iKjVaCygOKyYl56EUTJCnGyGXXf/asJIAzRfQgkGidaTx/JSFn5khrSjLnAX+auxi3I
    Rbt3Hxzt84YnDWyJrI+ma4GXalRQh0N+oEmLXXM00KnvNHYQM+lXzBVlxqZj3r9Gbiklul
    yPQzYhtzkNWacPB3LDGrSB93ax4PEz7OHFMfvK3LlQ0OvKNQte+Q8Gbx3++kXMaidlbLxa
    3Uuv2GSRu/n95VsKiA+kNGgU557ZSXHwr4TQjnILOFkmlGD4mgINRz6omONg
X-ME-Proxy: <xmx:PeubakJhdRASeqYGHwObHi7AA9xWlaBtAO0oi58Ajo8ITDg_K4rknQ>
    <xmx:Peubau9GbCtGRe3jCczZ2t9aQEbs2o75D-f-uvK0N9mgPwQnJowIBA>
    <xmx:Peubai-6UD1NU3KRKkytPQ4qQZPVxgOfn4gYncu-MUvnSUdljTKQjA>
    <xmx:Peubag844RG_ob2jwzAOnxef-mvias2paLjLAbXKSCUhchdjO4wzkA>
    <xmx:Q-ubap2micY-hE0ds-fPOYRjA8XzovD0Xa-3mFu5sdCjfr5pZU6DRXCb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 41E7032A007C; Sat,  5 Sep 2026 06:13:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhImxtAmqTw3
Date: Sat, 05 Sep 2026 12:12:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Steve Wahl" <steve.wahl@hpe.com>,
 "Dimitri Sivanich" <dimitri.sivanich@hpe.com>,
 "Mike Travis" <mike.travis@hpe.com>, "Tony Luck" <tony.luck@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Tony Lindgren" <tony@atomide.com>,
 "Kevin Hilman" <khilman@baylibre.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "Dominik Brodowski" <linux@dominikbrodowski.net>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Niklas Cassel" <cassel@kernel.org>, linux-ide@vger.kernel.org,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Michael Schmitz" <schmitzmic@gmail.com>,
 "Andreas Kemnade" <andreas@kemnade.info>
Message-Id: <693303da-350b-4295-b008-6fee8bb4c591@app.fastmail.com>
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Subject: Re: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for parameters
 that no longer exist
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 5, 2026, at 11:46, Karl Mehltretter wrote:
> kernel-parameters.txt still documents ten boot parameters whose parsing
> code was removed with the drivers or platforms that used them, one of
> them (atarimouse=) since before the git history. One patch per
> parameter, each with a Fixes: tag for the commit that removed the
> parser, so the maintainers of that area are on their own patch only;
> the two pata_legacy module parameters share the last one. Each entry
> was checked with git grep for its __setup(), early_param() and
> module_param() handler and with git log -S for the removing commit.

These all look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

If you have a script that you can easily run on another tree,
could you send me the script or the output for this one?

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove

I'm removing a bunch of code there, and if that ends up removing
additional documented paramenters, I'd like to fold the Documentation
update into the respective patches as well.

      Arnd
