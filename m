From: "stanley.miao" <stanley.miao@windriver.com>
Subject: git-clone from omapzoom.org failed.
Date: Fri, 25 Jul 2008 09:37:56 +0800
Message-ID: <1216949876.9424.8.camel@localhost>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33251 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbYGYBhT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jul 2008 21:37:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, rnayak@ti.com

[smiao@desktop ~]$ git clone http://git.omapzoom.org/repo/omapkernel
Initialized empty Git repository in /folk/smiao/omapkernel/.git/
got dd06a28f41991f2f004f388fde3f7edea01c1c5b
walk dd06a28f41991f2f004f388fde3f7edea01c1c5b
got 6480cf6936cf32308a113adb9af0f8602b6223f0
walk 6480cf6936cf32308a113adb9af0f8602b6223f0
Getting alternates list for http://git.omapzoom.org/repo/omapkernel
Getting pack list for http://git.omapzoom.org/repo/omapkernel
Getting index for pack 6766f8f96d6592cbccc117fdd5d91ea07ec09a60
Getting index for pack 93a2e6816791fe92516ccae4319a9037e7f1d073
[...]
Getting index for pack cdf798f41c0ed5673d2c4a81cc1ef8dffa410c6f
Getting index for pack 3651d2351b3e129d6205a06e127e6fd92899af0a
Getting pack b80f02e70fab8ef2602f6a1f2b3caab5d6156e2b
 which contains 273d545654e472dc60b2f5fee3f1bdac921a615e
walk 273d545654e472dc60b2f5fee3f1bdac921a615e
Getting pack ed451160b26a54bf420075568d28f11136b6121e
 which contains 050684c18f2ea0b08fdd5233a0cd3c7f96e00a0e
walk 050684c18f2ea0b08fdd5233a0cd3c7f96e00a0e
Getting pack c7c0ee3fb425edb3e01abdd63fccf219d913cc1d
 which contains 3ce7ba0c3c9566f50725b0108916180db86e1641
walk 3ce7ba0c3c9566f50725b0108916180db86e1641
Getting pack 407c38017452a9a8c0d8b5f9765bad837d4905eb
 which contains b4525f04fdc8a321cc78c5af6c9a899989aa7f4c
walk b4525f04fdc8a321cc78c5af6c9a899989aa7f4c
Getting pack 74316fb8187ba65d2da192a939f0c4b55a2e1ae6
 which contains 120dd64cacd4fb796bca0acba3665553f1d9ecaa
walk 120dd64cacd4fb796bca0acba3665553f1d9ecaa
Getting pack a88495de3ab49c0e59d33e2d8e9e97d6241377ed
 which contains 324384fe715944f44406012ea4285738c17ef833
error:
packfile /folk/smiao/omapkernel/.git/objects/pack/pack-a88495de3ab49c0e59d33e2d8e9e97d6241377ed.pack size changed
fatal:
packfile /folk/smiao/omapkernel/.git/objects/pack/pack-a88495de3ab49c0e59d33e2d8e9e97d6241377ed.pack cannot be accessed


Does anybody encounter the same problem with me ? I have tried several
times, sometimes it hang here, sometimes it got a error here.

Thanks
Stanley.

