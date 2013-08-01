From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Thu, 1 Aug 2013 10:10:48 -0500
Message-ID: <51FA7A78.20702@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-4-git-send-email-t-kristo@ti.com> <51FA1C7D.5060403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60995 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708Ab3HAPLO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 11:11:14 -0400
In-Reply-To: <51FA1C7D.5060403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/01/2013 03:29 AM, Rajendra Nayak wrote:
> Tero,
>
> On Tuesday 23 July 2013 12:49 PM, Tero Kristo wrote:
>> +	dd->control_reg = of_iomap(node, 0);
>> +	dd->idlest_reg = of_iomap(node, 1);
>> +	dd->autoidle_reg = of_iomap(node, 2);
>> +	dd->mult_div1_reg = of_iomap(node, 3);
>> +
> []...
>> +	reg = of_iomap(node, 0);
>
> Doing an of_iomap() for every single clock register seems like an overkill
> and might have performance penalties at boot.

the other option might be to use offset and a single allocation - but I 
think Tero should comment if this is possible or if registers on some 
SoCs are strewn all over the place

-- 
Regards,
Nishanth Menon
