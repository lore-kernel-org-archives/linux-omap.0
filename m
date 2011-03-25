From: Andy Green <andy@warmcat.com>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 15:00:51 +0000
Message-ID: <4D8CAE23.5080906@linaro.org>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <201103251424.47141.arnd@arndb.de> <4D8C99CC.5020103@linaro.org> <201103251550.26117.arnd@arndb.de>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44422 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab1CYPAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 11:00:55 -0400
Received: by wwa36 with SMTP id 36so1472129wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:00:54 -0700 (PDT)
In-Reply-To: <201103251550.26117.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On 03/25/2011 02:50 PM, Somebody in the thread at some point said:
> On Friday 25 March 2011, Andy Green wrote:
>> I see.  It would work OK then.  They probably wouldn't want to blow
>> their $1750 just on Panda though, so maybe they set 4 bits or whatever
>> and let 20 be computed.
>
> Well, if the algorithm is defined well, it could be used for any device
> based on OMAP. The marketing department could turn this into a win by
> declaring "does not require external EEPROM for ethernet mac address" ;-)

Okay, can't argue with it ^^

> * Some places try to keep a database of all used machines and their MAC
> addresses to monitor who connects to the network. This requires the address
> to be stable. It also prevents the use of virtualization, so it's becoming
> less common.

They will probably just be happy the crazy noise they have been seeing 
from current Panda MACs changing every session will go away, it doesn't 
seem to add anything it's an OUI namespace MAC.  In the patch case the 
"locally administered" mac will be "stable".

Anyway since I understood it, I can see your idea is a cool approach, 
it's up to TI what they will do about it but I guess it's OK with or 
without it.

-Andy
