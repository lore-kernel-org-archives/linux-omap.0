From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH A 09/10] OMAP2/3: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
Date: Tue, 03 Mar 2009 07:09:35 -0800
Message-ID: <87prgy7ids.fsf@deeprootsystems.com>
References: <20090128020447.7244.80496.stgit@localhost.localdomain>
	<20090128021312.7244.2415.stgit@localhost.localdomain>
	<20090128232831.GL23301@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0901290021360.32081@utopia.booyaka.com>
	<87zlg372rm.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0903021945060.30037@utopia.booyaka.com>
	<20090303082837.GJ25699@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:46792 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZCCPJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 10:09:41 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1838119yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 07:09:39 -0800 (PST)
In-Reply-To: <20090303082837.GJ25699@n2100.arm.linux.org.uk> (Russell King's message of "Tue\, 3 Mar 2009 08\:28\:37 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Mar 02, 2009 at 07:48:07PM -0700, Paul Walmsley wrote:
>> Hi Kevin,
>> 
>> On Mon, 2 Mar 2009, Kevin Hilman wrote:
>> 
>> > What about the rest of the *_PRM_REGADDR() accessor macro changes in
>> > this patch?
>> > 
>> > The rest of the PM core code uses these and so does not build on top
>> > of the Russell's omap-clks3 branch.
>> 
>> yes, all of the *_{PRM,CM}_REGADDR() work should be kept.
>
> Well, in case it wasn't clear from my previous mail, I'm not merging this.

It was clear why you weren't merging the couple pieces that you
referenced, but it wasn't clear whether you had problems with the rest
of the patch.

Kevin

