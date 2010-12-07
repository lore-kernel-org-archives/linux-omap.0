From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] FOR TESTING ONLY
Date: Tue, 7 Dec 2010 07:55:11 +0200
Message-ID: <20101207055511.GD2576@legolas.emea.dhcp.ti.com>
References: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
 <20101202222736.GZ17222@atomide.com>
 <20101203124453.GC2633@legolas.emea.dhcp.ti.com>
 <20101206194917.GQ8345@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35331 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865Ab0LGFzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:55:14 -0500
Received: by mail-ey0-f175.google.com with SMTP id 28so6678060eya.34
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:55:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101206194917.GQ8345@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Dec 06, 2010 at 11:49:18AM -0800, Tony Lindgren wrote:
>* Felipe Balbi <balbi@ti.com> [101203 04:35]:
>> On Thu, Dec 02, 2010 at 02:27:36PM -0800, Tony Lindgren wrote:
>> >
>> >Great, yeah I'll merge them into linux-omap master branch for testing
>> >probably later on today.
>>
>> Cool, I just made the updates Mike asked and it's now all good again
>> :-p
>
>It will get repulled the next time I rebuild l-o master branch.
>
>> I'm hoping Greg will still accept these patches on monday for merge
>> window, cross your fingers :-p
>>
>> for 2.6.39 I'll get them all to build together. Not quite there yet.
>> TUSB6010 messed up the whole code with ifdefs, I need to check how to do
>> that one properly.
>
>It seems the right long term solution is to get drivers/dma dmaengine
>to work for us for both system DMA and CPPI DMA. Well there are probably
>other problems you're dealing with too..

true, then musb would only use that API. I'll check how that can be
done, but that's something for 2.6.40, it'll be a mess to get all those
dma layers to drivers/dma in the near future :-p

-- 
balbi
