From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCHv2] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu, 5 Sep 2013 22:11:22 +0200
Message-ID: <62E39EC3-A2D5-4631-A21F-4F29D18A74D9@dominion.thruhere.net>
References: <1358461134-13452-1-git-send-email-jacmet@sunsite.dk> <50F8DA3A.3090406@ti.com> <51DAB39C.7090106@newflow.co.uk>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43896 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab3IEUL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Sep 2013 16:11:26 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so96808wib.5
        for <linux-omap@vger.kernel.org>; Thu, 05 Sep 2013 13:11:25 -0700 (PDT)
In-Reply-To: <51DAB39C.7090106@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, hvaibhav@ti.com, richardcochran@gmail.com, tony@atomide.com, michal.bachraty@gmail.com, michal.bachraty@streamunlimited.com


Op 8 jul. 2013, om 14:42 heeft Mark Jackson <mpfj-list@newflow.co.uk> het volgende geschreven:

> On 18/01/13 05:14, Mugunthan V N wrote:
>> On 1/18/2013 3:48 AM, Peter Korsgaard wrote:
>>> When booting with CONFIG_ARM_APPENDED_DTB (either because of using an old
>>> U-Boot, not wanting the hassle of 2 files or when using Falcon fast boot
>>> mode in U-Boot), nothing updates the ethernet hwaddr specified for the
>>> CPSW slaves, causing the driver to use a random hwaddr, which is some times
>>> troublesome.
>>> 
>>> The am33xx has unique ethernet hwaddrs programmed in the efuse, so it makes
>>> more sense to default to these rather than random ones. Add a fixup step
>>> which adds mac-address dt properties using the efuse addresses if the DTB
>>> didn't contain valid ones.
>>> 
>>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>>> 
>> 
>> This implementation looks fine.
>> Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
> 
> Tested-by: Mark Jackson <mpfj-list@newflow.co.uk>

Tested-by: Koen Kooi <koen@dominion.thruhere.net>



