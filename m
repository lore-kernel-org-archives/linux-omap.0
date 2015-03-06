From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/2] pinctrl: dt-bindings: Fix amx3 SLEWCTRL_FAST binding
Date: Fri, 6 Mar 2015 11:31:06 -0600
Message-ID: <54F9E45A.2020903@ti.com>
References: <1425085827-4514-1-git-send-email-d-gerlach@ti.com> <20150306171351.GU13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbCFRbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 12:31:39 -0500
In-Reply-To: <20150306171351.GU13520@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 03/06/2015 11:13 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150227 17:14]:
>> Currently both am33xx and am43xx have the macro for SLEWCTRL_FAST
>> in pinctrl dt-bindings reversed so that selecting the macro actually
>> sets SLEWCTRL_SLOW in the pad control registers. These patches
>> correct the bindings but leave the pinctrl states that use the binding
>> *UNMODIFIED*. Previously i2c and mdio on am33xx and i2c, mdio, and
>> uart on am43xx had been using this macro and selecting SLEWCTRL_FAST
>> while actually programming SLEWCTRL_SLOW in the pad config registers.
>>
>> Because the intended selection was SLEWCTRL_FAST the macros are
>> unchanged. I tested on am335x-gp-evm and am437x-gp-evm with no
>> difference in functionality seen.
> 
> Applying both into omap-for-v4.0/fixes thanks.

Thanks!

Regards,
Dave

> 
> Tony
> 

