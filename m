Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88B3DA5D9;
	Mon, 16 Mar 2026 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687164; cv=none; b=i8NrMSSpeufRibsDTqFFZEQqXliIpIIYjpCsYv/H+unvIBZfvTmv6B2cQUzdccNBZuowByj5ld1XfUiUe0z0+oXO90XvpfHNzHcM8/mIbeorPyKtFf3S0PwHf8AgDOUBxoYEuRJyxcXvXgd4QWqgAk1sk4GvblY75pdqdl2ckPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687164; c=relaxed/simple;
	bh=KX/ElHW2NVnmxewJnwZxA85/Oodw4mPDntSMLYXwv64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c84MMGVOcTarh4z3i4/9zl49torDaVCKG0p9oHssjQqi//m3wf33V6VACMTu6ntKbmLqjIUYaCan2sk2Lq+OImh9OqWb8WbnFNDEjDZd6m7SDpJYsogHzkmcFjGM/4NrzgVeZ5phlA/B+aIKBXYyC3ULt+PLl3u+XSpy8nSCwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV2jeEmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV2jeEmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF05C19421;
	Mon, 16 Mar 2026 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687164;
	bh=KX/ElHW2NVnmxewJnwZxA85/Oodw4mPDntSMLYXwv64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IV2jeEmG7kKevDW2JHVvNUI5TtUV+Eej8klDzmn6zOa0IVB0gzweG+SeIH8pc+wmH
	 edu4CofnesZyl8vYHk5P4xynFuVfbyFoznynGVrJnqjjOy5fyu6RMFZmsP9AsUBVGv
	 Io0dF+PHkETjjX5QaBytZ10tsmJsFar+N5XHwO0NTHkHvK/CV+HAUKN7b2LBLj3+LL
	 54h+ovGZowocyrZcpTu7mVrhHF7E0eqJTzwm1LDy+9eQ4H84NidIQsugqHsBcuvXDC
	 JCtpCFqfp9tkOzA73EmSPgRLnvdTMK1VRqAvwSj7j7IqB+P9dtPyzMs6ThNT6QmQaU
	 TdeLNZ9MSoktA==
Message-ID: <ee2ec279-ee5d-4d6d-b6ff-35187e3f03e6@kernel.org>
Date: Mon, 16 Mar 2026 19:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for PRU-ICSS
 on AM335x
To: Parvathi Pudi <parvathi@couthit.com>, Kevin Hilman <khilman@baylibre.com>
Cc: nm <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>,
 rogerq <rogerq@kernel.org>, tony <tony@atomide.com>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 richardcochran <richardcochran@gmail.com>,
 aaro koskinen <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>,
 Andrew Lunn <andrew@lunn.ch>, linux-omap <linux-omap@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev
 <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>,
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>,
 praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>,
 m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>,
 mohan <mohan@couthit.com>, pmohan <pmohan@couthit.com>,
 basharath <basharath@couthit.com>, Murali Karicheri <m-karicheri2@ti.com>
References: <20260307122641.738450-1-parvathi@couthit.com>
 <20260307122641.738450-4-parvathi@couthit.com> <7ho6ks1r4s.fsf@baylibre.com>
 <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2026 13:00, Parvathi Pudi wrote:
> Hi,
> 
>> Parvathi Pudi <parvathi@couthit.com> writes:
>>
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
>>> This patch adds the new device tree overlay file in-order to enable
>>> PRU-ICSS instance, along with makefile changes.
>>>
>>> PRU-ICSS instance consists of two PRU cores along with various
>>> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
>>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>>>
>>> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
>>> of the PRUSS subsystem node.
>>>
>>> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
>>> eth port information and corresponding port configuration. It includes
>>> interrupt mapping for packet reception, HW timestamp collection, and PRU
>>> Ethernet ports in MII mode,
>>>
>>> GPIO configuration, boot strapping along with delay configuration for
>>> individual PRU Ethernet port and other required nodes.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>>
>> [...]
>>
>>> +/*
>>> + * Disable CPSW switch node and
>>> + * MDIO configuration to prevent
>>> + * conflict with PRU-ICSS
>>> + */
>>> +&mac_sw {
>>> +        status = "disable";
>>> +};
>>> +
>>> +&davinci_mdio_sw {
>>> +        status = "disable";
>>> +};
>>
>> I think you need s/disable/disabled/?  (note the trailing 'd').  Without
>> that, I don't think you're disabling these nodes, so I'm curious how it
>> is not conflicting with the PRU-ICSS.
>>
>> Kevin
> 
> Thank you for pointing out this typo.
> 
> We checked the kernel code as to why this did not create any issue in our
> testing.  We found that the device availability check goes through
> of_device_is_available(), which only treats "ok" or "okay" as enabled.
> Anything else is effectively treated as not enabled.
> 
> So even though "disable" isn't the usual DT value, it still prevents the
> node from being probed since it doesn't match "ok"/"okay".


The question is whether you build tested your code (so dtbs_check). And
if not, why?

Best regards,
Krzysztof
