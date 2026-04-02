Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2637882A
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166555; cv=none; b=TQvsQJnDYrky7KzldfsAnxq6NMp0K2lTul553Pn6TwQ5zeiNEUsObW4udy0QTFmuwFLnZ0lOY5UfU/0xmoF1U6uikG0D+TFPUgO6Zv6+oME7hWg1jxjsbYjT1stcIzE+HMCxPfof9l5gV/LFw2wXnV/nFD90VU0HMPD8az+C8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166555; c=relaxed/simple;
	bh=dzd1FUE6dT2IMhyX6vnewVLdO38rp0BybgKggTVioXw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z+XeldNJ7EsFMLq6Qpxr8jqhvL9CiBNxVlL90QVrpG/vJ7eKw1Uh0JxYvlTji0L5UxkHT2VLNZ+REPooY9Bzj9+1f7dH2BISkn41xWWf3Ga5qT5Lr88djHc+B34aMdptTDzXo+iiPfahGtvHvOMq/u3dmlmHnXO11vw75uejs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bAsOBNSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mbiH+zmP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bAsOBNSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mbiH+zmP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 154A47A013F;
	Thu,  2 Apr 2026 17:49:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 17:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775166553;
	 x=1775252953; bh=XB1+qEZQ3/4/NCjiwpc6YJhMs5uxlHHTszpVXBON2Bw=; b=
	bAsOBNSh44rSX7Zp6fqe29xav6a8aWeSRrpZ+bm1aYmYYPihpK+KY3YdPyqQX7tq
	+b3w2iwOG8KlV7urxMHA53JeTf1i+YA9u+duxowutB/uedKh5AvVoDWxUxENMH73
	DnK9TtCSUdBWq9sexO9Wdxqg85wSmB9hvCffYjs0TBplAqtWHOmeTsDug+w4OEkN
	u1EKWhgyE8CGEjAJrECNBP+enuSyjOfVk9Lm7NdMMvOgVXUZK07WRytbdEzbC4nz
	qzD7WIv2B7hpmDMQzqhYNAf+1Z1gCCrVSU09C/rCofYKsdR5oFnloS3vtVzOkvVM
	b7KbXtFUhhi6BuSusvQ+vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775166553; x=
	1775252953; bh=XB1+qEZQ3/4/NCjiwpc6YJhMs5uxlHHTszpVXBON2Bw=; b=m
	biH+zmP1EwDR0qNWOTXH6i+7xmqB2FMBcwtRsobX9jkxo81HRnKytTXXl8wgSTP7
	d1CHmxI7QCAtThxrVC5z3v+4WOZU9ja7CX1za1HaWmpm287xBz0BlHM111PMn2kO
	tojDZ0RnoMugLvBE7gHsQCQwbjJ/O9LIg/c2Upg1dJR911B0BTXJ5A+ro3KbbAh8
	mUDVxseGK1YDFOKhjgr0goyXAGYW0DwxGfm2CiBAHPNmbGXdnu5XaKT1l+/2QIm5
	RVxNwkUv0w5W9FeMYSO6Ba+YkKqF26FuJcN4GaZpOLazR2HaXuxZ8cljevAfpsIB
	jKJk6ca0qDctEjbzYsOPg==
X-ME-Sender: <xms:WeTOaTBnoBMs_w2pqOgtRm_MzhwgQwIJtsRItI5hl2cnFCWiNagztA>
    <xme:WeTOaUXjzxMpYzVL0UFEvnDmeEO1aqJhI2ZV2oJwHTWay3F1R4e92wVMLH9S5ZE34
    cOEArLdAs-vJCvdu5cL-9WcwDtQs6QMuQ4lMYjWPUHR53nj9siXTw39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hlihhnuhigqdhomhgrphesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WeTOacvZm9K3BPmPFfXJFrch0VvfW2IYX9T4ocXM5b6QSMtLxdBwGg>
    <xmx:WeTOaQUEWZ4PPlOBL-PEFI0971aaWNhQYGFngjyjabrWbsAgzhxRBA>
    <xmx:WeTOaQHHMRPc2J8KYpja9U3cWBLDRGukrUhOQamDlOE4l7Jtkql6jg>
    <xmx:WeTOaa3Lib2LN39k8jPIr8AIwoph6hZCjyno7KSb-VyimNBNViPBWQ>
    <xmx:WeTOaWF0JE8d6O0v2jOTXSP9W2kHxYMPAFiMO_n2ibkEg7sFbsk41-75>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FD17700065; Thu,  2 Apr 2026 17:49:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1UuxUpPOvY7
Date: Thu, 02 Apr 2026 23:48:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kevin Hilman" <khilman@baylibre.com>, soc@lists.linux.dev
Cc: Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Message-Id: <83d0c8d8-fcde-4407-bb09-c2ae0e0e142d@app.fastmail.com>
In-Reply-To: <7hqzoytlms.fsf@baylibre.com>
References: <7hqzoytlms.fsf@baylibre.com>
Subject: Re: [GIT PULL] ARM: dts: updates for ti/omap for v7.1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 1, 2026, at 23:29, Kevin Hilman wrote:
>
> ----------------------------------------------------------------
> ARM: dts: updates for ti/omap for v7.1
>

Hi Kevin,

I applied this one, but I noticed two problems:

There is no long form changelog text, please add
more information about what is in the branch in
the future. I've added a short paragraph while
applying.

> +-
>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi     | 744 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts           | 101 
> +++++++++++++++++++++
>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts            |  70 
> +++++++++++++++
>  arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                          |   2 

Something went wrong with the overly long lines here.

      Arnd
