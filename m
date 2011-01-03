From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Mon, 03 Jan 2011 16:39:59 -0600
Message-ID: <4D22503F.9060100@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com> <20110103223656.GA8414@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33114 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840Ab1ACWkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 17:40:03 -0500
Received: by mail-gy0-f176.google.com with SMTP id 1so5701029gyf.21
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 14:40:02 -0800 (PST)
In-Reply-To: <20110103223656.GA8414@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux had written, on 01/03/2011 04:36 PM, the following:
> On Mon, Jan 03, 2011 at 12:58:28PM -0600, Nishanth Menon wrote:
>> Source:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>> branch: omap-for-linus
>>
>> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
>> resulted in the following sparse warnings:
>> http://pastebin.mozilla.org/907954
> 
> FYI, you may like to try:
> 
> make C=2 arch/arm/mach-omap2/
> 
> instead of the two-step process:
> | Do a kernel make with "make C=1" to run sparse on all the C files that get
> | recompiled, or use "make C=2" to run sparse on the files whether they need to
> | be recompiled or not.  The latter is a fast way to check the whole tree if you
> | have already built it.
Gee thanks. /me should update my old bash aliases :D

-- 
Regards,
Nishanth Menon
