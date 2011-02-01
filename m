From: =?ISO-8859-15?Q?Robert_W=F6rle?= <rwoerle@mibtec.de>
Subject: serial8250: too much work for irq73
Date: Tue, 01 Feb 2011 17:10:10 +0100
Message-ID: <4D483062.9010809@mibtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56933 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1BAQKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 11:10:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi List

I am running into issues , when using ttyS1 on a heavy loaded 
application. It trys to send and recieve around 60bytes every 100ms with 
57600baud.  There is a PIC Microcontroller attached on the otherside 
which immidiatly returns the data when requested.

After some hours , the kernel starts to flood with the above messages 
and the system gets into an unusable state.

i am running 2.6.35.9 ( released from isee.com ) on their Igep Module ( 
arch igep0030).

What would you guys do ? Anything i can provide you to help here ? Its 
really a major issue for us and showstopping an important release.

Thanks in advance for any help or suggestion

Regards Rob

