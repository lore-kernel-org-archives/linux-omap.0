From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP: PM support for OMAP4 MPU sub-system
Date: Thu, 08 Dec 2011 11:45:27 -0800
Message-ID: <87liqmkfu0.fsf@ti.com>
References: <874nxaewbv.fsf@ti.com> <20111208191956.GC31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36144 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794Ab1LHTpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:45:35 -0500
Received: by mail-iy0-f170.google.com with SMTP id z21so2089834iab.15
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 11:45:29 -0800 (PST)
In-Reply-To: <20111208191956.GC31337@atomide.com> (Tony Lindgren's message of
	"Thu, 8 Dec 2011 11:19:56 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [111208 10:14]:
>> Tony,
>> 
>> Please pull the OMAP4 MPUSS PM series below.  It is based on the
>> Russell's devel-stable branch due to dependencies
>> 
>> Kevin
>> 
>> The following changes since commit 3ee0fc5ca129cbae81c073756febcb1c552af446:
>> 
>>   Merge branch 'kexec/idmap' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into devel-stable (2011-12-06 20:27:54 +0000)
>
> I don't think there's a dependency here to the kexec/idmap commit?

Nope.

> Great yeah this is badly needed. One minor thing, can you please rebase
> this on one commit earlier to commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a
> (ARM: 7194/1: OMAP: Fix build after a merge between v3.2-rc4 and ARM
> restart changes) as that's what we have as the base for other branches.

Done, pushed updated branch.

Kevin

