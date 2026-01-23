Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495429E0E6
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173954; cv=none; b=UkxKcxOn9MQWO0IE65PNNOAg9Sf9crI4Nyt5PWR6TpE/iroemDQKq7kEe8QI5ptgcPlz3bkB0qJow/hFOJVZG8nPVueS4huq0l/nxMUklvZNg/CVrmMeG7CfBQ6FSMqJ6mTNaSxmoQcOU2BV0TdRr5GEFwp1L+iJuwgub520qEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173954; c=relaxed/simple;
	bh=K7zJHUtjvCk9zW085TQhbAKQFbA9gj4GZtqhhwIr24Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAYCgSLovlDir5731BpAMSW09j/HtQ/xNzfzb29jhNGTkeQ3T2fr4iJC0eTjHOts9VK+JI/mixYluOJfcKyiris8Sv7ifXsdcrPFn0Rqh2NtxP/AoKA5HpIdA9TCNX++GOEU89/wkzIoLvVsDw2hh0CKOFT+2z2Fcez6keDw/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxFthOpw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxFthOpw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so1032602a91.2
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769173952; x=1769778752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F6Q0KrzJx/PydalRZY11/eFAiNA4NIIjUoKpRMvjGE=;
        b=LxFthOpwTxsx5FcuiBZx5ZNLdkoxzWp9RVMhE0yfEU+QAa5R4WXssdqvKsdLFwOvtW
         /8HLPAYA0vbx+r0p9J9rccki/i69DfHOiv2AD9PAjvhWbyto70kOIaigfd/1NyVvudy3
         p9G935UHM1NDgqs4Hq/k5O16bOLfaQrPAyMu1QEcWyGBDF3NTP6tcmFu6/6koGr2pxgw
         rPNqbrJAUmriIc8pzy85+bQMBJCU+jo7AQD5ri6QryRodcGFVCfpZoWN4lFJn6EhExf7
         OUqTPxfO6fLSnzv4wcLSASEDExHpPvXrDeAQWiQFiw5hPus7qhoeyqhVsEPqTzF9HilO
         YslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769173952; x=1769778752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F6Q0KrzJx/PydalRZY11/eFAiNA4NIIjUoKpRMvjGE=;
        b=qjN64FWNjhN60gw/fvnZtoKmUZPy/pCEqhkHRPlj3vJC0gfA9WnlDGwIlB98OFnBe0
         fbw6xDei7MBDX1hKxUyDj2beXHTeePJAtP7bwPZ9D75qZ7c0wqEAhEWjiQb7sr4S57E2
         loj7vmKdum6xYFVbztiwp/hT2WU7YFzdCALXFmNqmzsjHJ2FrWZWNvAqM3mhP4NIacYQ
         qsOQgxhcKotMzd/nAkQRIPL7bylUatrJq8UunrkdQm2gfMBXMqn5gB3/PEl4GCiMnImp
         mlA7QMZeUA00PjxSCsZkkxI2jrZppdtA+RnY1CX7EkElwOJ765xaluiG8kSYcYdvYvep
         bWAw==
X-Forwarded-Encrypted: i=1; AJvYcCVWLWnD4QF6vReuGFtnxEw0eCzJPd5JYIamLFXNnaNGema4dtLELA8QqhFQocpfgQ+bcVDnJCFLbfKs@vger.kernel.org
X-Gm-Message-State: AOJu0YysrEFAICd84uCndA0ihhgkuSlpVRneLF7fsAh3fxDlzjcEqOJd
	Or4YHFNKvqYqKUhl21kUYxZtDPgxsoajP4ykqsiU1EOxntD5TaSjl85k
X-Gm-Gg: AZuq6aI1TSr5XQL5jTsAW5lhA+Os/ACU2yCKh7SRQTzbyCh2XClwNlHlYs9DuJlhkiu
	V0ooGg8aRa5cKXLQgAB7JQ83LHytMRawaT4B7wjW4967GsBBCSY90TNokI6CXh0jhGzgtwbcblo
	UpUCmBSAZhj5OOYXFzOj1mhIQrXApm5sBe/CI0Xvybd/CGrj3yNAVwDGjKyfDJT8gLulvVXbpit
	m55+rZeRAGckvFEGMTAMHahh+Ozr6cDwULb+n/oA0IVktbMvC9iB5ICPi3/8Z/x5Q2YVggPGe5u
	11684Ev8wvPnNk1hEwvMEYQmTh+AojYm5sAMorNCk3Tx9cx1MbCNbNWyKRuVkF++sZW7MQbelBj
	PwXqBgIcosgd9bAnVgcrUPkc+81zMP/ZgUZ5i/xXGM507j79aZT8jVmLnoKtUqWTE1HBs78aeeT
	J6DjtNApAGk2FAsX6EAHxGdYa4OzSxzbqciGY=
X-Received: by 2002:a17:90b:2cc3:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-353676fbaf3mr2327414a91.15.1769173951647;
        Fri, 23 Jan 2026 05:12:31 -0800 (PST)
Received: from [192.168.1.7] ([115.99.251.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335205bb5sm5183483a91.1.2026.01.23.05.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 05:12:31 -0800 (PST)
Message-ID: <7b922a72-f17b-492f-ae04-a97a75738d4d@gmail.com>
Date: Fri, 23 Jan 2026 18:42:24 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: ti,phy-usb3: convert to DT
 schema
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260122-ti-phy-v3-0-751619729433@gmail.com>
 <20260122-ti-phy-v3-2-751619729433@gmail.com>
 <20260122233309.GA3730160-robh@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20260122233309.GA3730160-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23-01-2026 05:03, Rob Herring wrote:
> On Thu, Jan 22, 2026 at 05:52:58PM +0000, Charan Pedumuru wrote:
>> Convert TI PIPE3 PHY binding to DT schema.
>> Changes during conversion:
>> - Define a new pattern 'pcie-phy' to match nodes defined in DT.
>> - Drop obsolete "id" property from the schema.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 135 +++++++++++++++++++++
>>  1 file changed, 135 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
>> new file mode 100644
>> index 000000000000..605f12f0f79a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
>> @@ -0,0 +1,135 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/ti,phy-usb3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI PIPE3 PHY Module
>> +
>> +maintainers:
>> +  - Roger Quadros <rogerq@ti.com>
>> +
>> +description:
>> +  The TI PIPE3 PHY is a high-speed SerDes (Serializer/Deserializer)
>> +  transceiver integrated in OMAP5, DRA7xx/AM57xx, and similar SoCs.
>> +  It supports multiple protocols (USB3, SATA, PCIe) using the PIPE3
>> +  interface standard, which defines a common physical layer for
>> +  high-speed serial interfaces.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^(pcie-phy|usb3-phy|phy)@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    enum:
>> +      - ti,omap-usb3
>> +      - ti,phy-pipe3-pcie
>> +      - ti,phy-pipe3-sata
>> +      - ti,phy-usb3
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +    minItems: 2
>> +    items:
>> +      - const: phy_rx
>> +      - const: phy_tx
>> +      - const: pll_ctrl
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 7
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 7
>> +    items:
>> +      enum: [wkupclk, sysclk, refclk, dpll_ref,
>> +             dpll_ref_m2, phy-div, div-clk]
>> +
>> +  syscon-phy-power:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      items:
>> +        - description: Phandle to the system control module
>> +        - description: Register offset controlling PHY power
> 
> This allows N entries of 2 cells each. You need either:
> 
> items:
>   - items:
>       - description: ...
>       - description: ...
> 
> (the hyphen is important!)
> 
> Or:
> 
> maxItems: 1
> items:
>   items:
>     - description: ...
>     - description: ...

Okay, I will use the above format in the next revision.

> 
>> +
>> +  syscon-pllreset:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      items:
>> +        - description: Phandle to the system control module
>> +        - description: Register offset of CTRL_CORE_SMA_SW_0
>> +
>> +  syscon-pcs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      items:
>> +        - description: Phandle to the system control module
>> +        - description: Register offset for PCS delay programming
>> +
>> +  ctrl-module:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle of control module for PHY power on.
>> +    deprecated: true
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,phy-pipe3-sata
>> +    then:
>> +      properties:
>> +        syscon-pllreset: true
>> +    else:
>> +      properties:
>> +        syscon-pllreset: false
>> +
>> +required:
>> +  - reg
>> +  - compatible
>> +  - reg-names
>> +  - "#phy-cells"
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    /* TI PIPE3 USB3 PHY */
>> +    usb3-phy@4a084400 {
>> +        compatible = "ti,phy-usb3";
>> +        reg = <0x4a084400 0x80>,
>> +              <0x4a084800 0x64>,
>> +              <0x4a084c00 0x40>;
>> +        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>> +        #phy-cells = <0>;
>> +        clocks = <&usb_phy_cm_clk32k>,
>> +                 <&sys_clkin>,
>> +                 <&usb_otg_ss_refclk960m>;
>> +        clock-names = "wkupclk", "sysclk", "refclk";
>> +        ctrl-module = <&omap_control_usb>;
>> +    };
>> +
>> +  - |
>> +    /* TI PIPE3 SATA PHY */
>> +    phy@4a096000 {
>> +        compatible = "ti,phy-pipe3-sata";
>> +        reg = <0x4A096000 0x80>,  /* phy_rx */
>> +              <0x4A096400 0x64>,  /* phy_tx */
>> +              <0x4A096800 0x40>;  /* pll_ctrl */
> 
> Use lowercase hex.

Sure.

> 
>> +        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>> +        clocks = <&sys_clkin1>, <&sata_ref_clk>;
>> +        clock-names = "sysclk", "refclk";
>> +        syscon-pllreset = <&scm_conf 0x3fc>;
>> +        #phy-cells = <0>;
>> +    };
>> +...
>>
>> -- 
>> 2.52.0
>>

-- 
Best Regards,
Charan.

