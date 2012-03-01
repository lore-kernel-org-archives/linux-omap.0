From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into mach/io.h
Date: Wed, 29 Feb 2012 21:53:40 -0600
Message-ID: <4F4EF2C4.2060605@gmail.com>
References: <4F4451FB.7070007@gmail.com> <20120224000657.GJ18185@atomide.com> <20120224182246.GL18185@atomide.com> <4F4AFCC7.3020509@gmail.com> <20120229014719.GK18901@atomide.com> <4F4EBBDF.9090806@gmail.com> <20120301001140.GA18438@n2100.arm.linux.org.uk> <20120301003939.GU18901@atomide.com> <20120301010348.GV18901@atomide.com> <4F4EEE30.9080109@gmail.com> <20120301034613.GW18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54316 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab2CADxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 22:53:44 -0500
Received: by ggnh1 with SMTP id h1so55908ggn.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 19:53:43 -0800 (PST)
In-Reply-To: <20120301034613.GW18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, Matt Mackall <mpm@selenic.com>

On 02/29/2012 09:46 PM, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [120229 19:02]:
>> On 02/29/2012 07:03 PM, Tony Lindgren wrote:
>>>
>>> Rob, I assume you'll apply this into your branch?
>>>
>>
>> Yes
> 
> OK
>  
>>> --- a/arch/arm/plat-omap/include/plat/sdrc.h
>>> +++ b/arch/arm/plat-omap/include/plat/sdrc.h
>>> @@ -16,8 +16,6 @@
>>>   * published by the Free Software Foundation.
>>>   */
>>>  
>>> -#include <mach/io.h>
>>> -
>>
>> I added iomap.h here as there are macros in the header from it.
> 
> Hmm, did you get some compile error? I though all code
> using sdrc.h already has iomap.h included. This file
> should eventually be local to mach-omap2.
> 

No, just examined the file. If it compiles, either way is fine with me.

Rob

