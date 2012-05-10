From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address
 space.
Date: Thu, 10 May 2012 15:11:06 +0530
Message-ID: <4FAB8D32.3030901@ti.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com> <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com> <20120509122348.GA30632@n2100.arm.linux.org.uk> <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com> <20120509154849.GA10375@n2100.arm.linux.org.uk> <4FAB6A27.3050509@ti.com> <20120510085325.GA3655@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:33810 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757900Ab2EJJlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 05:41:13 -0400
Received: by obhx4 with SMTP id x4so1832950obh.20
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 02:41:12 -0700 (PDT)
In-Reply-To: <20120510085325.GA3655@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Thursday 10 May 2012 02:23 PM, Russell King - ARM Linux wrote:
> On Thu, May 10, 2012 at 12:41:35PM +0530, Santosh Shilimkar wrote:
>> Are you planning to merge below patch as is or split
>> the patch like 1) Refactoring 2) ARMv7 fix
> 
> I don't see any point in splitting this up, especially as the ARMv7
> fix would involve merely changing two lines (the domain register value
> and the value passed into __setup_mmu via r6.)

Fine with me.

Regards
santosh
