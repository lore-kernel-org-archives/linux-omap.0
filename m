Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5C3016FC;
	Sun,  5 Apr 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417532; cv=none; b=EGMA4JVQMXJ6Uzmam2/Mn4ocOq2D7a5g2MF23Y/rOY8NqEFTqKSC/7I0Xcctb9Ml1vFt7E/6yGD5dQiJ0ZbDXvdIjlQnQjArL1jjxhzVnZXBisw48JIaAspSH/MjrLPwD8ZHVkBf/iQn+zltLDFyWAYhWTjuBKpRjLuqcUws4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417532; c=relaxed/simple;
	bh=Mzj+bKNHKDekgtt9IVrHrL0LyZGVZTkE5+yiZv/rEgQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cGVE1xnBiyZCQ59sqhNKen3VVBvyCeOdEtCi684Z4FxxeXbUTqcsRjjzORLCCGOBGd4GHZjHRe09liK0CTuth4ABdKZUryxndvX06q9bTEEBT3ft3lqGvAatHZ3n1RhJXtbopvnk0552hyOdFDGulAXnJc8bDoF35+F72UKEI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XOSZke6F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BX9fi0F5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XOSZke6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BX9fi0F5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4BA51400029;
	Sun,  5 Apr 2026 15:32:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 05 Apr 2026 15:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775417529;
	 x=1775503929; bh=25xkYrco7rjEEztGHHRTWHWIOdtGy3UjIQU8Zg73vQk=; b=
	XOSZke6FnjUWZXoTZxuI5RkSj7HfPikElwmlK5pN/j2Mvuc/5xXRAj5AWyO6qIFJ
	b9nCON7zoBPJKhRvybbwbvXjfYSXbq6IDfignFfss/WSGyce3/M4OhtP6rfPQ3Ys
	VocTA8d7WC1u6FVgtU21Gc3jJuVRiZCEqFYPXqD+9y4axBydEP7pGNtaiEAZYngl
	pY7jVsxWlYb0SkMu8JNzegkreTZ54LxujPk+a7xIStLrljaSBMQ4+E3qimUNfGvr
	lsjZCHqvS3Wv6CXzF5w8G8IQu0c3oTX2EOUKDQiSpOhzmL514kXxKD6enSzD6FOy
	vyeX6R1/KEJymReptMffgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775417529; x=
	1775503929; bh=25xkYrco7rjEEztGHHRTWHWIOdtGy3UjIQU8Zg73vQk=; b=B
	X9fi0F5ZbgSRquFupWUHWL8r40d6D/mstla7tA8PzTpc9N6FdxO9CUBtvuGu6bbT
	0ncFa3E89DU5fIX4X8IdTSCX85U9HQV+8hYYmNNllLDVvkbZqASc8y7YIxtoXKhm
	iMF8XvRqaX/dP0T/RT9FC4/BSz/SvpQdDuJ9YloQqrFtqNkhok9Xl4qjIrRqbscC
	pYGzTJPlzzE8NFjIlqQdfy0ShcPioJJ7cb1QsSCDsdCtqirKw8MelFvmhyre9XGn
	tumPcWKkL4yF8+tRqy7y3jSoxvI9Ybgy2OEvyrSZvT8qM4r10aPClU/w9N2YsLIF
	Z4lpMMf5KpZ6z+mGOhhsw==
X-ME-Sender: <xms:ubjSaeo8ZR0lb4xpcEPJNt0ILYEeGbh7RtHamiuVXcY52ebcnifKoQ>
    <xme:ubjSaXf_G2jic0Rt0pnf35PebjEWsbQ37MbdxIBwtwlmojDjIcnvSQnac5oaf-mgF
    WcIa7qZ60SFVCgnJ7Z3HPmilCtyiDt2d_RRXg7uSsS6l19m7lM60gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    grlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesghhmrghilhdrtghomhdprhgtphhtthho
    pegurghnihgvlhdriigrhhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehhrghokh
    gvgihinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ubjSacDPJ-qnuKHZIJYExUUuXJMHJvVOlM50CPTjxBKt7WWujCs9ew>
    <xmx:ubjSacPbrYUbjP8SBpXyDCkRn8jI4uL2hlNR12oq-5d4h4Ellha5XQ>
    <xmx:ubjSaRWuriMRJhJr4S38nhNz52jtijGz0QL5vmdMh31kMu-4_LJkuA>
    <xmx:ubjSafS1jk7DFIY4DJ-i8cGB_xPcaGTt1KJ8U4t0sG57SU_FT4ZWuw>
    <xmx:ubjSabyeCxHRSiOROUd7SXjWTzv7E7ChS3eXNKVuxGpRVKEEwSDCin7B>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C26B700069; Sun,  5 Apr 2026 15:32:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxeJrQzD9Ui3
Date: Sun, 05 Apr 2026 21:31:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Simon Horman" <horms@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
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
Message-Id: <64384fd1-edb3-4c7a-9ba8-56385a303d35@app.fastmail.com>
In-Reply-To: <20260404091100.GT113102@horms.kernel.org>
References: <20260402184726.3746487-1-arnd@kernel.org>
 <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
 <4498f664-15ca-4859-a050-a593f124105f@app.fastmail.com>
 <20260404091100.GT113102@horms.kernel.org>
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename soft_reset()
 function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Apr 4, 2026, at 11:11, Simon Horman wrote:
> On Thu, Apr 02, 2026 at 09:16:29PM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 2, 2026, at 21:13, Ilias Apalodimas wrote:
>> 
>> Before the c5013ac1dd0e1 commit, this was a 'static inline' function,
>> which is allowed to clash with other identifiers. Making it a global
>> symbol during the move was a problem.
>
>
> If we are going to treat this as a fix then probably it should be separated
> from the rest of the patchset and routed via net. With the rump patchset
> re-submitted to net-next once dependencies are in place.

I'll drop patch 1 then and send the other two when I get the next
regression with duplicate objects in a couple of releases. I'm
travelling at the moment and won't have time to rebase and test
before the merge window.

It's no longer urgent since both cpsw and dpaa2 have been broken for
years now since I first reported the regression.

     Arnd
