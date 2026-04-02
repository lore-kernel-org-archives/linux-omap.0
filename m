Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4E33B95A;
	Thu,  2 Apr 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157417; cv=none; b=NTdEXVy2gDqGS+bjKZ9xc/3OCYBO2HlC4mFmmAK/raBcahl0+76r1ejPpIpuIcSjqUwjHiuRZQq/WTrmAkQyhHUG1CiOGybKdzabYplNC/lyyFxRPy+Y0cpA48uRkMTbYbdvhaqU1KWEa3E0bQVGrKfBXADsuRl0LJN2o08x99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157417; c=relaxed/simple;
	bh=lnxe9dbZw5P54TSEcNU418OcO/GysgalCaKrea+c0Wc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l1/jLTUmJDOXPsTXrbHF9JKTjIeobmR75KGZ9S3xNDLxgG0K6plUVxQ5vtUlzPxM64ZgMv8lGGz3MNcxyTJRsBboWjJZPFIOYFLPSHZgZ78PsX5rmwM6FaDUjtlxezeP0YL2VFFSfJiarMqx0WWIhAHxRkp43du76790MS9j2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RODUo8QT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m9yMKUrY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RODUo8QT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9yMKUrY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 418D07A012C;
	Thu,  2 Apr 2026 15:16:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 15:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775157410;
	 x=1775243810; bh=vvagKRVIBbGmbpkuKlGSXdVXQTCiinPbfNczkdfG7kg=; b=
	RODUo8QTQ0JzG1OKPUrbbjkVy7sI+82Uoi7eAdDSlKA3JSP0CTIYirWdi1zalpis
	j7NyUjt7yjZJgCTUCW1sBDtPygAWPN7SqLImmGoR0fyze4ErS0a5d1FDnAvYT7vN
	mTUqbAjH72+KH5/qxfxFvPS2wD/gIPYTOE3pNvHNS/WC7J6vmBzbKwLuNsm5UXeD
	TAoKBPTtNVXNtpUirU8e1ZzoXnq4pCvCp1m3rUgi4q+7nJc9J1XncTTPNxDOxnfv
	eTTExVS0jHPoPIrYF1pAqOTUJ9bJQ8JFgokXmK1lsnyvOA3ZSje9oeIhLhKRxS0R
	/htiyND7KLb7tELcc3sHQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775157410; x=
	1775243810; bh=vvagKRVIBbGmbpkuKlGSXdVXQTCiinPbfNczkdfG7kg=; b=m
	9yMKUrYmu459oQsb8YHdPLHG8y3NSiXVR7rtT2NaakhpfB89pxeEnKfHN5WpQD9x
	jeMy3ZNYtR5yhhOrnVHwFRS3kmtQF7ypeQFhigbuK6JHcCpKUVABkRJiI1QbtOx5
	pR2sO1kF14dmgOLiiuY9+vri2/zN+REWJ+Q4DdGcAxs7qdP3M7KLrVYRsx3of7q+
	cHevdXF9bGX2UGxUJhmRJBiU7+2O5JX5oSr0uQJjNHwdxg57Zmo1fmwXXk9I7UE3
	qkRvQmrFq1Q77ICIDy70Me4/ax3jb3JAalGNZe8mhFxWsBcF0aIJaSJBX9IDRuMk
	lZ4d0rd00IzoOmGHNJZVQ==
X-ME-Sender: <xms:osDOabxKLBE8atubEbpjnNtKcIlQ80P5oYs0bUT-0I7WzEb839rLFg>
    <xme:osDOaeGN3-PQ7_RYKtEQTwtoTdUJ80nJdCJiAV9boJ0or0qlLrnUoLzKpRNxwyY1J
    hYo-pj9JZRMaK6_IAPZylRYZ4rC_BQKgmSlokQp3EAf9TX59cqKQXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprg
    hlvgigrghnuggvrhdrshhvvghrughlihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    uggrnhhivghlrdiirghhkhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhkvg
    igihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhgvghrqheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrg
    hrohdrohhrgh
X-ME-Proxy: <xmx:osDOaSLL2z1pgHZ1wjK8uu-9AKK0S6NLlIjClY_JJQxu0v5SVW2RLg>
    <xmx:osDOaRFnUaPr3HTEY82fDD5bHWC5CE-zf3zEYUJuHsFEwt23TUSWMA>
    <xmx:osDOaXx63R907KFH50O1FHm0yCK_nmKW0-20riCTxfcFnmAxdvQ0Uw>
    <xmx:osDOaejGXiQRZq6zyEmwKyzxnP0IBsazD_fQAMbEydWnVUVPSKf1GA>
    <xmx:osDOaYh8S2z10gTHYSPjFfZMQAz4FiM3V_-mj5ukcXM406ZEkIE2HhtM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E240E700065; Thu,  2 Apr 2026 15:16:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxeJrQzD9Ui3
Date: Thu, 02 Apr 2026 21:16:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Grygorii Strashko" <grygorii.strashko@ti.com>,
 "Murali Karicheri" <m-karicheri2@ti.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Roger Quadros" <rogerq@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, "Kevin Hao" <haokexin@gmail.com>,
 "Daniel Zahka" <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <4498f664-15ca-4859-a050-a593f124105f@app.fastmail.com>
In-Reply-To: 
 <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
References: <20260402184726.3746487-1-arnd@kernel.org>
 <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename soft_reset()
 function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 2, 2026, at 21:13, Ilias Apalodimas wrote:
> Hi Arnd,
>
> On Thu, 2 Apr 2026 at 21:47, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> While looking at the glob symbols shared between the cpsw drivers,
>> I noticed that soft_reset() is the only one that is missing a proper
>> namespace prefix, and will pollute the kernel namespace, so rename
>> it to be consistent with the other symbols.
>>
>> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functions in cpsw_priv")
>
> The patch seems fine, but why the Fixes: tag?

Before the c5013ac1dd0e1 commit, this was a 'static inline' function,
which is allowed to clash with other identifiers. Making it a global
symbol during the move was a problem.

       Arnd
