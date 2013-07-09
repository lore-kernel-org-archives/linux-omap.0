From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Tue, 9 Jul 2013 20:20:39 +0300
Message-ID: <51DC4667.3030305@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3GIRVJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 13:21:09 -0400
In-Reply-To: <51DC1B47.7070504@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On 07/09/2013 05:16 PM, Stefan Roese wrote:
> Hi Roger,
> 
> On 07/09/2013 03:55 PM, Roger Quadros wrote:
>>> I'm using latest kernel.org for this (git ID d2b4a646 also tested with
>>> v3.10 release). This is with DT-enabled booting and without-DT (same
>>> problem). I also tested some older Linux kernel versions and it fails
>>> there as well. Only v3.2.40 seems to be able to mount this rootfs via
>>> NFS reliably (approx. 10 times success).
>>
>> I can't really tell at the moment where the problem is.
>>
>> Did you compile in all the necessary drivers required for NFS booting?
>> In the beagle case that would mean NOP_USB_XCEIV, USB_EHCI_HCD, USB_EHCI_HCD_OMAP
>> and the smsc95xx driver.
> 
> Yes, sure. Otherwise no USB/NFS mount would have been possible.
> 
>> If you can paste your full kernel boot log we can check if all these show up
>> before the kernel tries to look up for the NFS server.
> 
> Please find it attached (one log for the NFS mount working and one for
> failing - both with exact the same kernel/dtb). Also my current .config.
> 

Thanks for the logs. Configuration part seems OK. NFS root has been mounted
in failing case as well. Then it fails. I'll need to investigate more what
happens. 

cheers,
-roger
