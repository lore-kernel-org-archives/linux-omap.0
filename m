From: Adam Wozniak <awozniak@irobot.com>
Subject: MMC read errors
Date: Thu, 01 Mar 2012 12:57:34 -0800
Message-ID: <4F4FE2BE.70402@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.irobot.com ([206.83.81.187]:39745 "EHLO smtp1.irobot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757800Ab2CAVMo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 16:12:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm seeing weird read errors on a DM3730.  Has anyone seen anything like 
this before?

Environment:
   factory images from
   http://cumulus.gumstix.org/images/angstrom/factory/2011-08-30-1058/
   loaded onto and MMC card on a
   Gumstix WaterStorm on a Chestnut board

Commands:
   dd if=/dev/urandom of=garbage bs=1024 count=1048576
   while true; do md5sum garbage; done

example output:

99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
4dee7d74d6d8013291b48d955ea7af1f  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage
99e983a8f17f3258ddaff73bf622db47  garbage

dmesg has nothing interesting.

Any clues?

root@overo:~# cat /proc/version
Linux version 2.6.39 (neil@cumulus) (gcc version 4.3.3 (GCC) ) #1 Mon 
Aug 15 19:04:09 PDT 2011

Although I've also seen similar behavior on a recent 3.2 kernel using 
oe-core.

--Adam



