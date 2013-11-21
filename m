From: Stefan Roese <mail@roese.nl>
Subject: Re: AM335x board with disabled RTC crashes
Date: Thu, 21 Nov 2013 05:32:48 +0100
Message-ID: <528D8CF0.1050406@roese.nl>
References: <528CC4CB.4000609@gmail.com> <528CC5C3.2010905@ti.com> <528CDAF6.7070905@ti.com> <528D8C08.1020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:16111 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3KUEcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 23:32:52 -0500
In-Reply-To: <528D8C08.1020201@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 11/21/2013 05:28 AM, Stefan Roese wrote:
>>>> Disabling the RTC in the DT doesn't help (of course). So what's the
>>>> recommended way to disable this hwmod access to the RTC registers?
>>>
>>>
>>> http://www.spinics.net/lists/linux-omap/msg98207.html
>>> might help you - we had thought it might get queued for 3.12, but it
>>> was queued for 3.13 instead..
> 
> Unfortunately this patch doesn't fix the crash for me (yet). With this
> patch applied and the RTC DT node completely removed from am33xx.dtsi it
> works. But only disabling it (via status = "disabled" in the board dts
> file) doesn't work.
> 
> I'll dig a bit deeper today...

This (hacky) patch works, but I'm not sure if this is acceptable upstream:

am335x-board_foo.dts:

...

&rtc {
	reg = <0x0 0x0>;
};

Thanks,
Stefan

