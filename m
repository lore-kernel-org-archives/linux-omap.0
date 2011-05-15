From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Sun, 15 May 2011 10:25:05 +0300
Message-ID: <4DCF7FD1.6090209@compulab.co.il>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru> <1304891407-29364-2-git-send-email-green@linuxhacker.ru> <4DC791C9.9040709@compulab.co.il> <8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:38647
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753823Ab1EOHZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 May 2011 03:25:14 -0400
In-Reply-To: <8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/13/11 06:52, Oleg Drokin wrote:

> Hello!
>
> On May 9, 2011, at 3:03 AM, Igor Grinberg wrote:
>
>>> Bare-bones board file, comes with serial console, gpio keys,
>>> MMC/SDCard and USB support.
>>>
>>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>>> ---
>> In general, here you should write the version history of your patch...
> umm, ok.
> Do you think the history of the changes is important in this case, though?
> I mean it's mostly the case of "kill unneeded includes, fix style, fix incorrect mux package type" and so on.
> Nothing of real interest to anybody.

It can help everybody (also yourself), for example, the fact that you
already contacted Russell regarding mach-types (though the better place
for it is cover letter) could help me to not wonder why do you have this
stuff here.


-- 
Regards,
Igor.

