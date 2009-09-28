From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: Re: [RFC] OMAP1: Massive clean up of omap730/omap850 code
Date: Mon, 28 Sep 2009 22:19:00 +0100
Message-ID: <3d374d00909281419v1b4bf578sdb883371655492bb@mail.gmail.com>
References: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com>
	 <20090921231723.GD27699@atomide.com>
	 <3d374d00909231126y442c41e1y558664b360205192@mail.gmail.com>
	 <20090923222143.GM4919@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57523 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZI1VS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 17:18:58 -0400
Received: by fxm18 with SMTP id 18so4016911fxm.17
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2009 14:19:01 -0700 (PDT)
In-Reply-To: <20090923222143.GM4919@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

2009/9/23 Tony Lindgren <tony@atomide.com>:
>
> Thanks, looks good to me.
>
> Can you please rebase against the mainline 2.6.32-rc1 once it gets
> tagged?
>
> Then please keep your branch around until it all gets merged into the
> mainline tree. There should not be any need for you to rebase it,
> but I may need to pull it several times as I rebase the various
> upstream queues after each -rc.

Done. ZMC has now reviewed it, and I've mirrored it to a proper hosted
server too:

git://robotfuzz.com/linwizard-kernel.git
branch: omap7xx-fortony-rc1

Confirmed booting to a shell with the addition of the patches in
branch omap7xx-test2 - but those patches aren't ready to go as we
still need workarounds for a serial bug in order to know that we have
booted.

Thanks,
-- 
Alistair Buxton
a.j.buxton@gmail.com
