From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: What's in omap git tree for 2.6.33
Date: Mon, 07 Dec 2009 11:00:31 +0000
Message-ID: <4B1CE04F.5000806@blueyonder.co.uk>
References: <20091204182604.GC24013@atomide.com>,<4B1B21ED.30003@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB0309C863BE@dbde02.ent.ti.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:49786 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932808AbZLGLAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 06:00:42 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NHbKi-0005aM-5N
	for linux-omap@vger.kernel.org; Mon, 07 Dec 2009 11:00:48 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NHbKS-000408-KC
	for linux-omap@vger.kernel.org; Mon, 07 Dec 2009 11:00:32 +0000
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863BE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 06/12/09 03:37, Gadiyar, Anand wrote:
> Sid Boyce wrote:
>> Still a few fragments missing on beagleboard - Very roughly:
>> drivers/usb/Kconfig
>> +       default y if ARCH_OMAP34X
> 
> 
> This one's in Greg's queue for sure.
> 
> <http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-ehci-allow-ehci-to-be-built-on-omap3.patch>
> 
> And I did point out the other one. Olaf sent a patch too.
> We can get that in during the merge window, or right after.
> 
> So, wait up for -rc1 to be tagged.
> 
> - Anand
> 
> 

That's one bit, but with EHCI an integral part of the beagleboard, there
shouldn't be a need to hunt around for patches as without this support
it limits what you can do. OTG with the solder bridge couldn't see any
of my USB hubs, so I had to rely on the EHCI.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

