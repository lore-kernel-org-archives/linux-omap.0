From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: Does omap git have support for overo board.
Date: Tue, 08 Feb 2011 16:50:34 +0530
Message-ID: <4D512702.9040708@e-consystems.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:33928 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752491Ab1BHL1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 06:27:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I have pull the latest git from 
"http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary". 
But couldn't find config file for overo . So I used 
"omap2plus_defconfig" and made sure the overo board is selected.

But the board didn't boot. It stopped after uncompressing kernel .

Bytes transferred = 3011064 (2df1f8 hex)
## Booting kernel from Legacy Image at 82000000 ...
    Image Name:   Linux-2.6.38-rc2-13606-g448e9a6-
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3011000 Bytes =  2.9 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel. <---- Hangs after this.

Does the mainline has the support for overo board. Or am I missing 
something.

-- 
Regards,
Mohamed Thalib H

