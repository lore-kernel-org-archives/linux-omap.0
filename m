From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Wed, 25 Jan 2012 20:46:18 +0100
Message-ID: <4F205C0A.1050502@ti.com>
References: <4F1E7F8A.4010805@ti.com> <1327455315-19464-1-git-send-email-ameya.palande@ti.com> <alpine.DEB.2.00.1201251204480.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41521 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2AYTq1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 14:46:27 -0500
In-Reply-To: <alpine.DEB.2.00.1201251204480.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ameya Palande <ameya.palande@ti.com>, mturquette@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 1/25/2012 8:05 PM, Paul Walmsley wrote:
> Hi
>
> one important question first:
>
> On Tue, 24 Jan 2012, Ameya Palande wrote:
>
>> According to OMAP4 TRM Table 3-1183, CM_CLKSEL_DPLL_USB register defines
>> following fields for multiplication and division factors:
>>
>> DPLL_MULT (bits 19:8) DPLL multiplier factor (2 to 4095)
>> DPLL_DIV (bits 7:0) DPLL divider factor (0 to 255)
>>
>> Acked-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Ameya Palande<ameya.palande@ti.com>
>
> Have the scripts been updated?

No not yet. The easy fix I was thinking about is to replace this define 
by the hexa value of the mask. I can extract directly from the max mult 
and max div.

Regards,
Benoit

