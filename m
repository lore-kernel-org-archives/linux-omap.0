Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468B3F9F27;
	Tue, 31 Mar 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967341; cv=none; b=Nl9YLh9xvYuK+SLumCDQIrggwDbyDgPt2BLu2FN6uXCKY/NMWtif6ZmQeeU+2a8pIxPcaVcxzAKm/sgmdZ2JJC4jFT6lHmGCnFvLrYNJsBsr1cCGRJxBNWXkRPKkFPnSMZUM6wNrGHb+KAmKX7dtWPL4pZ8Yioe+wIuCi1kxlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967341; c=relaxed/simple;
	bh=+1bS46ZAA7pp0mgz73/J8GN2ndSPqyiQ8J/28Jl0deM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V9w9GbC98CcDsJ1xXWvTv+LdIWMnw96svpagT07XRhYxyyuLymjXZl/XngJ3sDZdaMzpwz4u1FW3zG3ye3GpK5tYwu5dcI2wezKxERCjGGKPgrHDvYVYPxN5NaOvzkpHWkt2auYN9PFa+g6UJFIANP2Z2xxinKqNeCsTJ8nTinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GIyQRsgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jx3yUZHQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GIyQRsgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jx3yUZHQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A771A7A00E8;
	Tue, 31 Mar 2026 10:28:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774967338;
	 x=1775053738; bh=gwjTKRN7CKx6VBzelTeoJWz//Z40N3ckpJ64EfpPZN4=; b=
	GIyQRsgLBEUPdekUSmrKw3y2sdb9k8B56H0eto+5KHHuKLgLxNooiIV+8n1zkVXh
	PK+Y/U141AnNdcccVG7n9IjwSAxwlP3wYwvP4EWOgxu8SuJ7qrrA6jWybMCA5Rcm
	ixkvUub/GUbqmNsOtVUh2XO/ejs1kpWI49aosAvoltqSNmXKOqZAnDhXOgrXsTPq
	ELOlAltwV91RL3I2cHjv1nyiT8h+o5nO3eqO9fieuaLHMzGLJfdwoyASfqZleSrS
	IubSNfy+Jt3QbwVhEWSOPsMvMw4Wf9Gm3/NLXrNDDPWZQKgsxHY0ktwGvg3jb9Vg
	OAHJq3ykXIuBV/7wv0gPmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774967338; x=
	1775053738; bh=gwjTKRN7CKx6VBzelTeoJWz//Z40N3ckpJ64EfpPZN4=; b=J
	x3yUZHQHmZi493P+Bypf5OpDAyDXLErp4LHLcwQ5F8rpRx25f5igK5cVLwI/M64P
	bOs9G3iCafoQgiDE4CILBxQ/zRAy9aZbzAucwvOH0DjK0YlL8bDUde7timAiDcED
	mg8z8KB85BqmCqo3pRpy9o5gJ8mpwACiAMNwkLB9nQv9mSDzOJ038gyBmka6K9/7
	HOtJzBB703yxJIwCwJhRlU5Cu5cpcWyeAdtjimhBFWNWrr3sFATfBBz0iZlAO6eR
	EKxcyRvw8Plov6LPzGkEEjy7bky1dWCfnn5B+g1QEfBIScbyhgw91C2/rF4OJhYm
	7BT0sBH7STRbl+UxLYKnw==
X-ME-Sender: <xms:KtrLaQSPBrym0FF0ZYzAt9huAYT-K0lY1ozO13CGTO0Jp02FF1iINQ>
    <xme:KtrLaYlQhx63FcE-M7AX9J-mfJKcuG0jNHM3SLYLjCnPYffcMdSZTHvHJtfnB0VLJ
    4ihpHML4BJ4mNx5eQrNoplaBv48wWW9o0SAMHCRqreaqUHv-N0_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    fhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrg
    hrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhope
    htohhnhiesrghtohhmihguvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegsrgih
    lhhisghrvgdrtghomhdprhgtphhtthhopegujhhrshgtrghllhihsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjmhhkrhiihihsiihtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    grrhhordhkohhskhhinhgvnhesihhkihdrfhhipdhrtghpthhtohepsghrghhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KtrLadCzLDpwew3xf9ULxZFdCUioGdiLTCHFC3kiDkY0QMU5oqvz9Q>
    <xmx:KtrLaYvGjSiwzJzUHoUu94YNOAIMrFCh44hYhgCh7VabhHvroXMDGA>
    <xmx:KtrLadHjmS5TgUtzGs25OUzfHPLXEPKsjZbAQkAXJrYT4YezYeYnZA>
    <xmx:KtrLaT_NqHLFlO9u-7dljQjtLKKu9cv2kKw3eNzEotXKYe0-BHc5Gg>
    <xmx:KtrLaVSozOKHK4qeBoQCNI6YOCaveUP1H8SnzxKeqdxn-lscZ_JgwLMW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED3CA700065; Tue, 31 Mar 2026 10:28:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFr_uRj1O5Ps
Date: Tue, 31 Mar 2026 16:28:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Scally" <djrscally@gmail.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Message-Id: <a895905f-069b-4fc5-bbf0-34c3978b3f39@app.fastmail.com>
In-Reply-To: <acuraLhLVgyP-LUK@ashevche-desk.local>
References: 
 <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
 <acrcDTPpXZ_5A4D8@ashevche-desk.local> <acruxMNdnUlyRHiy@google.com>
 <acto3TE1AR8iTzF0@ashevche-desk.local>
 <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
 <acuMD7Oly4XWW4n8@ashevche-desk.local>
 <9359e475-fc8e-4d32-9ab4-383710170553@app.fastmail.com>
 <acuraLhLVgyP-LUK@ashevche-desk.local>
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2026, at 13:09, Andy Shevchenko wrote:
> On Tue, Mar 31, 2026 at 12:45:59PM +0200, Arnd Bergmann wrote:
>> On Tue, Mar 31, 2026, at 10:55, Andy Shevchenko wrote:
>>
>> My best guess is that __exit_call should just use
>> __attribute__((unused)) instead of __attribute__((used)) and
>> have the compiler drop it from built-in code instead of the linker:
>
> But why do we need that at all? Can we just drop the full section for good.
> Or i.o.w. where exactly is it being used in the current kernel?

The main use case I see for __exit_call is for device drivers
that can be either loadable modules or built-in: In a loadable module,
you need the cleanup function, but for built-in code you want
it to be dropped at build time.

For the few direct callers of __exitcall, the only explanation I have
is that these could at some point be turned into loadable modules,
and the author wanted to be prepared for changing it later. In theory
we could change those to module_exit(), or just remove them, but
there is little practical benefit either way.

I've tested the __maybe_unused change on randconfig builds now and
found no (build-time) issues with that, so I'm submitting that
now.

     Arnd
