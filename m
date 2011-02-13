From: Nishanth Menon <nm@ti.com>
Subject: Re: How to enable dvfs in omap.
Date: Sun, 13 Feb 2011 21:17:47 +0530
Message-ID: <4D57FD23.7050706@ti.com>
References: <4D5665D4.2030902@e-consystems.com> <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com> <4D566B36.8000008@e-consystems.com> <4D567436.2090602@ti.com> <0ECA9072-4E28-4DE4-B366-6080F835C288@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45205 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932Ab1BMPr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Feb 2011 10:47:56 -0500
Received: by mail-gx0-f181.google.com with SMTP id 10so2448218gxk.40
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 07:47:55 -0800 (PST)
In-Reply-To: <0ECA9072-4E28-4DE4-B366-6080F835C288@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: OMAP-KML <linux-omap@vger.kernel.org>

Koen Kooi wrote, on 02/13/2011 09:08 PM:
> Do you also have a branch that is fully rebased with no merge commits?
well.. the tree's pm-base is a merge from Kevin's pm branch to the 
latest RC. that is the baseline for any devel for -39-rc1 (contains 
cpufreq, pm-fixes for .38rcs + accepted patches for -39) - so I keep 
merging in Kevin's branches once in a while.. but  feel free to do the 
same/cherry pick to your tree as needed. I will ofcourse replace the 
dvfs branch with the latest patches from Vishwa - at least the one i 
have is the one that was last publically posted, things are due to 
change.. so dont expect me to maintain a tree :) just sharing what ever 
I found interesting ;)

-- 
Regards,
Nishanth Menon
