From: Andrejs Cainikovs <AndrejsC@GlobalAutomationSystems.com>
Subject: Re: OMAP2420-HS flashing question
Date: Mon, 19 Oct 2009 23:27:26 +0300
Message-ID: <4ADCCBAE.4030702@GlobalAutomationSystems.com>
References: <4ADCA2BF.3020105@globalautomationsystems.com> <13B9B4C6EF24D648824FF11BE8967162039B318B04@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from b124.csc.lv ([193.138.189.124]:56375 "EHLO
	mail.globalautomationsystems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118AbZJSU2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 16:28:00 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B318B04@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Woodruff, Richard wrote:
>> I've googled that OMAP HS are checking some kind of signature (applications
>> should be signed with the special tool (OST Tools)) so the developer must own
>> the keys for particular CPU? It is possible to turn off the HS option so I'll
>> be able to work with non-signed binaries?
>> The problem is that I want to get kernel running on custom OMAP2420-HS board
>> but have no keys.
>>     
>
> With out keys it's mostly impossible to introduce new boot code into the system.
>
> There isn't a practical way to 'turn off HS' with out destroying the omap chip itself.
>
> The way to add code would be through what ever mechanism the OEM has left to add code into the system (if any).  From there depending on software some kind of KEXEC could be attempted.
>
> Regards,
> Richard W.
>   
Thanks Richard, unfortunately this is what I've expected to hear.

Regards,
Andrejs Cainikovs.
