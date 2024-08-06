Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB54A0F;
	Tue,  6 Aug 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922861; cv=none; b=agqGWlApOLkYFr5K4k/QRUPedmR6pdN2QjcpwEJdGRj/cCsyX/v7+5m0iCywgIE4f45hbVCg/uAhjfCMpYCN6wyT1rct8Zp/0rQlbUCOAXGUSBKQqvPAxKKx7RT9+2Qvu2pIJ2bmARztWprtZk9KkixiF5f/SRb7UCd/eC6S8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922861; c=relaxed/simple;
	bh=FVuLlUrzDV7l3g3RHHqynBsyVJVXyq0uoJ6Zi/amFfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4FAfh1WbXFLGfbuk2z4SOMSgLS7NoLovq41CivXpPwmqSFbyp8vby3SqQqFbiGGtlNCiJfG7yNnhHGC+REX2vt8kmmaplZHqBQQ6XRTjWeNX7mBACDH/HmjR3/lNIKmxcJqTI6bSouWDpFvPNxext4/ZowHGqgziUdDjkQ5tOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC3r1s9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC3r1s9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A27C32786;
	Tue,  6 Aug 2024 05:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722922861;
	bh=FVuLlUrzDV7l3g3RHHqynBsyVJVXyq0uoJ6Zi/amFfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EC3r1s9r0Kqk1VMybfitJSOSDMZdbtmNBzlrr1krP9jLtARgrMS6ostdkpi3SIbCM
	 Jo41NPMjavTuuRfc084pbvA6zcLAoCvLCvG0zfkGehM4E4Efq+9bQ0LNrtLBwgV67n
	 +YZLhZWruX/NG6dqAI1QdGBSJb5Otgd8OTWRnulT8C9rftKSTuPwK5dw/NkfNvnwfV
	 k/k3/koQ3dp0rHq01yuwLNHYO91zHq8xsoubKYjtwp8oxaex81izbIVRw5gBvc4gck
	 zLjeF6ifWr12Wd44m+F0D7Xw/1iKjX3ISUvKGpE9mzVBPHL3Mny6UuxHB0nt+69Jhf
	 QOCP71buYGgqg==
Message-ID: <cb3d6f0b-4513-4744-8c16-c3f76ee36fef@kernel.org>
Date: Tue, 6 Aug 2024 08:40:56 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: ti-sysc: Use of_property_present()
To: Kevin Hilman <khilman@baylibre.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731191312.1710417-1-robh@kernel.org>
 <2ff177ed-a5e8-46ad-9902-14f377033da2@kernel.org>
 <7hy15a3m88.fsf@baylibre.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7hy15a3m88.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 05/08/2024 20:36, Kevin Hilman wrote:
> Hi Roger,
> 
> Roger Quadros <rogerq@kernel.org> writes:
> 
>> On 31/07/2024 22:12, Rob Herring (Arm) wrote:
>>> Use of_property_present() to test for property presence rather than
>>> of_get_property(). This is part of a larger effort to remove callers
>>> of of_get_property() and similar functions. of_get_property() leaks
>>> the DT property data pointer which is a problem for dynamically
>>> allocated nodes which may be freed.
>>>
>>> The code was also incorrectly assigning the return value to a 'struct
>>> property' pointer. It didn't matter as "prop" was never dereferenced.
>>>
>>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>>
>> Reviewed by: Roger Quadros <rogerq@kernel.org>
> 
> just FYI, missing a '-' in your Reviewed-by, which means tools like b4
> will not spot it.  I added it manually this time cuz I happened to
> notice it was missing.

Sorry, my bad. Thanks for fixing this up.

-- 
cheers,
-roger
