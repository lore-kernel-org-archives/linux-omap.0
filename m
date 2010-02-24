From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [ANNOUNCE] dspbridge: kill camelcase
Date: Wed, 24 Feb 2010 09:38:01 +0200
Message-ID: <4B84D759.7000801@ti.com>
References: <4B848B9B.2030002@ti.com> <20100224031325.GM28173@atomide.com>
Reply-To: <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab0BXHiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 02:38:06 -0500
In-Reply-To: <20100224031325.GM28173@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren said the following on 02/24/2010 05:13 AM:
> * Omar Ramirez Luna <omar.ramirez@ti.com> [100223 18:11]:
>> Hi All,
>>
>> I'm currently working on removing camel case + hungarian notation
>> from dspbridge code in the following branch:
>>
>> dspbridge-next-camelcase on d.o-z
>>
>> I'll appreciate if you can mail any unsent patch otherwise it will
>> need to wait (and be rebased) after the camelcase changes.
>>
>> If nobody disagrees I'll be marking dspbridge 0.2 (as per private
>> discussion) in the upcoming days.
> 
> Maybe do a perl or sed script that allows you to convert one
> string at a time? That way you can regenerate the patches as
> needed.
> 
> We used something like that to convert the musb code a few
> years ago.
> 
> I recommend converting one variable at a time and then compile
> and boot test in between. Otherwise you can easily convert
> substrings accidentally and then things will not compile..

I think we discussed this quiet some time back:
http://marc.info/?t=125319739500001&r=1&w=2 - yep there is script 
available.

-- 
Regards,
Nishanth Menon
