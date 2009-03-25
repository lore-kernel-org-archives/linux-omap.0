From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: move platform_device_register under mach-omap2
Date: Wed, 25 Mar 2009 15:16:59 +0200
Message-ID: <49CA2ECB.5040204@nokia.com>
References: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com> <8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60628 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbZCYNR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 09:17:27 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "2ameya@gmail.com" <2ameya@gmail.com>

ext Kanigeri, Hari wrote:
> Thanks, Doyu-San.
> 
> I am still going through the patch, but one quick question regarding this. One of the requirements of DSP memory pool is that it should be physically contiguous and non-cacheable. I hope the below patch is taking care of this requirement.
> 
> Thank you,
> Best regards,
> Hari
> 

Hi Hari,

I just checked __alloc_bootmem_nopanic() function.
I think memory allocated by that function is physically contiguous since
page frames are allocated in sequential order.

But I didn't get any information about page cacheing :(

Cheers,
Ameya.
