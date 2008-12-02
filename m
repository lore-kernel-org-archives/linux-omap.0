From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: Oops in MMC
Date: Tue, 02 Dec 2008 14:10:44 +0200
Message-ID: <493525C4.9040000@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36666 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbYLBMBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 07:01:34 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote:
> I was trying to mount the filesystem from MMC card on OMAP3EVM.
> Came across this oops.

[snip]

> Starting system logger: <1>Unhandled fault: external abort on non-linefetch (0x1808) at 0xd809c104
> Unhandled fault: external abort on non-linefetch (0x1808) at 0xd809c104

[snip]

> PC is at omap_mmc_request+0x64/0x264

[snip]

Do you have the latest HSMMC patches?

Tony has refused to apply them but they are in the list archive and here:

git://git.infradead.org/users/ahunter/omap_hsmmc.git 

in branch 

omap_hsmmc
