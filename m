Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509092;
	b=w+f+loJbLZII6+g6QRa9ehJVlpeaIveXVyKMg69K4oHRW2Ksyf9tDyvmW1Y+5V9OJwcH
	 E2OE6TGX7MlVJWdxzWmxwd4i5ATV4LJX6sIIyMpGG8BZZ7qqaVfvBlkSc4l0VfP9VxOi9
	 54W46GCpWmorqUfsnyin8E7dAOWb+t+hlufmwKVQbp61igOfw+i3KI/ShqgmJpQyEOoi/
	 DkljwArYXfoWBE6asDbPN/IfG6haOkPzeyHkBXK1D8O4HbWYV97VgrN+T0Kh4WnOVC1Fi
	 j0rVv4iWYO7An8GMSl9BJ4huD0VLvJRiswKQjuU3ms8KIoWECDVHsw8myftl5SPEKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509092;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=+bPig9YEHBQ1S6SsdO9IeXMhubBXV+ZrKdQRrhuVKKI=;
	b=5cUdltPodNkTaJks5LJpEi/Wucsw64Axc/4IzYd8tasB3m0B5DCnvmLVkMlM5Lbw8DQC
	 wqMlNxl9cUEI/gaUBIyFoCy0ATzdGzjoHo2sLAdF0y4UBeovHYVS+GVy346JBIuQqCu86
	 lUgYpTx5cluhPrZp1lhrzEix769lJbkcl8INqKHIFMdVrZOeog7eTQkHEH8mV+rTWa68t
	 55F9Dkw6FFtCMjhvuvTZmh4jUNIm7Y1Kr9TUEFqV0AFcxHAW2iaCPVqP7XrPJJJcTMMjX
	 Ex2n7ZPXR+QVKkhSbmZIfkt9aHBv05cafbk750w3HMKx7E+XRQwQK/Z2jGm+AXfwiig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0wQm0FN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F5606A31C;
	Thu, 12 Nov 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0wQm0FN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2EF1F000C4;
	Thu, 12 Nov 2026 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509092;
	bh=+bPig9YEHBQ1S6SsdO9IeXMhubBXV+ZrKdQRrhuVKKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0wQm0FNud0zVLTPOtWYzzJU6wVKvLGZhBeT56YpZC9qU1kbyi/Pgy3two7KhvpuN
	 hsHScHInWb314agvfKGhsUTZeP0TY0HNL2bE46jasN9aSzczAsiBOEmKxPrA6gho+z
	 gfwhMfROnnxjnp8vRXIDmhea0PSHvV5b6WRt8a9WrN8j7P0zEmMTkYqHX71HAHr5VN
	 MFx+uMayJ2u4J5HSKpD6iO2fENiSzP+jwnddBw4haVTchi2uqT6MWokCjkW1yijwty
	 f3NkfWaeTW+wxo/kUR6EE0WaME12avyP25q1KLRPk/eqHGHvyA6W3jwByTXLqDjTpR
	 wlGyNcmBPcV/g==
Date: Thu, 12 Nov 2026 13:44:49 -0500
From: Brian Masney <masneyb@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ettore Chimenti <ettore.chimenti@linaro.org>,
	Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Michael Turquette <mturquette@linaro.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] clk: ti: fapll: Fix clock speed calculation
Message-ID: <avYJIZrFu19Ivcbz@x1g10>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-2-dc6bf0fabae4@linaro.org>
 <179444595968.1126566.8596406047613157255.b4-review@b4>
 <38a09248-032a-4144-9e56-6d52eef8c077@linaro.org>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a09248-032a-4144-9e56-6d52eef8c077@linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)

On Thu, Nov 12, 2026 at 05:24:41PM +0000, Andrew Goodbody wrote:
> On 12/11/2026 01:12, Brian Masney wrote:
> > Hi Ettore,
> > 
> > > The fractional part of the divider was being treated as 1/10000000
> > > whereas it is in fact 1/2^24 (1/16777216). This led to incorrect clock
> > > speeds being reported when a fractional divider was in use. Correct it.
> > > As well as fixing the clock speed calculation when read, also update the
> > > calculation on set in a similar manner.
> > > 
> > > Fixes: 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > 
> > Should there be a Co-Developed-By here and on the other patches?
> 
> Not sure about that. This is my patch but is being submitted by Ettore in a
> series of patches that affect the clk system. We were working together on a
> project and at times each produced patches. Ettore has collected together
> this series for submission.

OK, I see. That makes sense. Thanks for confirming.

Brian
