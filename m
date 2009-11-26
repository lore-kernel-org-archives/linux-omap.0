From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3evm: touchscreen delays on pm branch
Date: Thu, 26 Nov 2009 22:32:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34962 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760840AbZKZRCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 12:02:15 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAQH2IKE008841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 11:02:21 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAQH2Hod027971
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 22:32:18 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am finding the response of touchscreen on the omap3evm very slow.

Here is my test:
On console, I run : watch -n2 "cat /proc/interrupts"
Then, I tap the touchscreen approximately once per second. However,
(usually) no interrupts are registered. As I increase the frequency
of 'taps' more and more interrupts are registered. But still not
matching exact taps.

However, when I keep the cpu busy with "cat /dev/zero > /dev/null &"
each tap is recognized.

EVM uses GPIO175 for touchscreen. I notice that Zoom2 uses GPIO102.
Both are not on BANK0.

Is the behavior same on ZOOM2 as well?

Best regards,
Sanjeev
