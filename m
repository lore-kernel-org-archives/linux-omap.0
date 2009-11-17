From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Is the OMAP patch process badly flawed?
Date: Tue, 17 Nov 2009 21:44:34 +0000
Message-ID: <4B031942.5020106@blueyonder.co.uk>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au> <4B0213AC.6050502@blueyonder.co.uk> <4B02A583.8090602@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C911F@dbde02.ent.ti.com> <4B02AC98.8030507@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C916A@dbde02.ent.ti.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:42160 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbZKQVoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 16:44:34 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NAVqq-0005o9-8k
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 21:44:40 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NAVqp-0005F4-P7
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 21:44:39 +0000
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C916A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 17/11/09 14:51, Gadiyar, Anand wrote:
> Sid Boyce wrote:
> 
> <snip>
> 
>>>>
>>>> I would expect patches sent upstream would result in all the basics for
>>>> long established platforms to be fully covered. Appreciating that
>>>> development is quite fast paced with mods and supporting new platforms.
>>>> Could someone please enlighten me?
>>>
>>> Sid,
>>>
>>> Speaking purely for EHCI, this is now queued up in Greg's USB queue
>>> for upstream and will get merged in the next cycle.
>>>
>>> Until then, the linux-omap code does have working EHCI support
>>> on beagle, evm and the other boards. If you're cloning from
>>> gitorious, you're probably picking the wrong tree.
>>>
>>> - Anand
>>>
>>>
>>
>> Thanks, that explains a lot as I can't remember seeing those patches on
>> the linux-usb list for submission upstream.
>> What tree is best to clone?
> 
> 
> Not sure which is best - I suppose that depends on what all you need.
> The canonical linux-omap tree maintained by Tony is at [1].
> 
> For EHCI, Felipe sent the driver to Greg who queued it up for .33 [2].
> Tony lined up the board files and mach-omap2/usb-ehci.c in the for-next
> branch.
> 
> 
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> [2] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-07-usb-2.6.32-rc6.patch
>  
> 

Thanks for the update and the patch. I downloaded the launchpad 2.6.31
kernel which I have currently running. Finally found one that outputs to
the LCD.
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

