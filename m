From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and L-Z)
Date: Mon, 23 Feb 2009 20:19:50 +0200
Message-ID: <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>
	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:64451 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbZBWSTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:19:53 -0500
Received: by fxm11 with SMTP id 11so2048124fxm.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 10:19:50 -0800 (PST)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org

On Mon, Feb 23, 2009 at 8:10 PM,  <ext-Eero.Nurkkala@nokia.com> wrote:
>> I am not entirely sure about the basis of Eero's equation:
>>
>> scll = (scl+3) * iclk
>> sclh = (scl+9) * iclk
>
> No, no:
>
> Exactly the opposite,
> +                       fsscll = internal_clk / (dev->speed * 2) - 3;
> +                       fssclh = internal_clk / (dev->speed * 2) - 9;
>
> means a longer period for scll. (and shorter for sclh)
Oops.. copy-paste typo.. :(
tLow = (scll+3) * iclk
tHigh = (sclh+9) * iclk
Vs:
TRM:
tHigh  = ( sclh +5 )*iclk period
tLow  = ( scll +7 )*iclk period

But my question is this: why are we trying to a different equation
here compared to the equation in the TRM? if the reason is that the
tLow and tHigh should be a variant based on board, probably
precomputed values or run time computed values wont work for all
platforms. the board file probably should give it as a platform
specific data. if this is not provided, use the run time computation..

just a thought..

Regards,
Nishanth Menon
