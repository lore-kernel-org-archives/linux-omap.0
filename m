From: Ran Shalit <ranshalit@gmail.com>
Subject: understanding cpuidle
Date: Thu, 16 Oct 2014 10:42:09 +0300
Message-ID: <CAJ2oMhK_BccGQe9m1bHAc4St_jaBfaSFvyPnTRKxJwzGkfk-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:38350 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaJPHmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2014 03:42:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

Hello,

I try to understand the cpuidle main concept but have some
difficulties. I could not find any documentation to explain the
cpuidle.

what does it mean that it enters idle when "no thread to run" ?if I
have only one process which does only
while(1)
{
 printf("C");
mdelay(1000);
}
Can I expect it to enter idle for 1 second and then print "C" and get
again to idle ?

Thanks
Ran
