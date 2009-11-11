From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: [PATCH 0/8] Omap fixes for v2.6.32-rc6
Date: Wed, 11 Nov 2009 23:20:55 +0000
Message-ID: <4AFB46D7.7090508@blueyonder.co.uk>
References: <20091111025907.31793.84134.stgit@localhost> <4AFA2CA1.4000005@blueyonder.co.uk> <20091111190820.GG24837@atomide.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:58178 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759531AbZKKXUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 18:20:55 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N8MUn-00071v-3q
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 23:21:01 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N8MUm-00070F-N7
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 23:21:00 +0000
In-Reply-To: <20091111190820.GG24837@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

On 11/11/09 19:08, Tony Lindgren wrote:
> * Sid Boyce <sboyce@blueyonder.co.uk> [091110 19:16]:
>> I still haven't been able to find the reason why the Ralink drivers
>> haven't been offered in make config/menuconfig/xconfig - cross compiling
>> on Fedora 12 x86_64 as per my previous post. I downloaded the latest
>> linux-omap snapshot Tuesday, 6 hours after it was up.
> 
> Sounds like that should be patched via drivers/net.
> 
> Regards,
> 
> Tony
> 
> 

CONFIG_CFG80211=m and CONFIG_MAC80211=m fixed that problem, though I'm
sure I tried the same some days ago and it didn't work - your snapshot
of today built and is working.

One remaining problem is getting FB working, the LCD status light lights
up blue, but the display is blank.
For that I shall start another thread.

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

