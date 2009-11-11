From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: linux-omap-2.6 does not allow configuring rt2xx
Date: Wed, 11 Nov 2009 17:19:37 +0000
Message-ID: <4AFAF229.1050907@blueyonder.co.uk>
References: <4AF9DCB8.9050305@blueyonder.co.uk> <4AFA5F05.7060201@compulab.co.il>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:45368 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756164AbZKKRTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 12:19:47 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N8GrH-0003XY-VL
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 17:19:51 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N8GrE-0004un-5X
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 17:19:48 +0000
In-Reply-To: <4AFA5F05.7060201@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 11/11/09 06:51, Mike Rapoport wrote:
> 
> 
> Sid Boyce wrote:
>> Spotted over the last few days.
>> "make ARCH=arm CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux/gnueabi-
>> omap3_beagle_defconfig", then xconfig/menuconfig/config, the option
>> never shows up.
> 
> Have you tried enabling cfg80211 and mac80211 in "Networking support -> Wireless"?
> 
>> Regards
>> Sid.
> 

Thanks, that did it. I thought I had tried those earlier.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

