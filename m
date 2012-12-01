From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge window
Date: Fri, 30 Nov 2012 21:55:09 -0800
Message-ID: <CAOesGMgzPVsiVqSe30f2bGZ4MKOjA9+Usw3OqX8wFkrdD570mQ@mail.gmail.com>
References: <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
	<20121130065314.GB6899@quad.lixom.net>
	<20121130172643.GI5312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35980 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2LAFzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Dec 2012 00:55:10 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so1795733ieb.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Nov 2012 21:55:10 -0800 (PST)
In-Reply-To: <20121130172643.GI5312@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Nov 30, 2012 at 9:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Olof Johansson <olof@lixom.net> [121129 22:55]:
>> On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
>> > The following changes since commit 0f9cb211ba5db93d488fe6b154138231fdd0e22d:
>> >
>> >   Merge tag 'v3.7-rc7' into next/cleanup (2012-11-25 21:34:34 -0800)
>> >
>> > are available in the git repository at:
>> >
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-multiplatform-v2-signed
>> >
>> > for you to fetch changes up to 5ebb428d045ea9b908864547819786d5bcebad05:
>> >
>> >   ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-26 13:19:23 -0800)
>>
>> Tony,
>>
>> Did you mean to base this branch on next/cleanup? We normally try to avoid
>> having vendor branches based on our common next/* branches, since it adds
>> dependencies that makes it hard to rebuild our branch if needed for some
>> reason.
>
> Sorry I should have asked before. I wanted to base this on something
> that compiles for with multiplatform support and is bootable with
> minimal patching and does not produce new merge conflicts.
>
> But I only need the resulting branch for testing, so as long as we
> the resulting arm-soc/for-next branch is usable for me until -rc1
> is out, I'll be happy.
>
> For merging, the dependencies for these three patches are:
>
> omap-for-v3.8/cleanup-fixes-part2-v2-signed (all the header clean-up)
> omap-for-v3.8/devel-prcm-signed (needed the wdt changes)
>
> So I've merged those two to use as a base, the patches on top
> are the same. Hope that works for you better.

Yep, that's better!

> It's now missing the common clock changes, but that's OK as the
> branch does not yet enable the multiplatform support. Updated pull
> request below.
>
> BTW, note that "[GIT PULL] omap iommu clean-up dependency branch for
> v3.8 merge window" is still pending it seems?

Done, thanks for the reminder.



> The following changes since commit 2589d056122f6dcb405d411eae872aac8cf9da1b:
>
>   Merge tag 'tags/omap-for-v3.8/devel-prcm-signed' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-30 08:40:31 -0800)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/tags/omap-for-v3.8/cleanup-multiplatform-no-clock-signed
>

Pulled in, I had two minor conflicts to resolve resulting in two
one-line differences in the diff stat (removed an empty line between
some includes).

I ended up pulling this into next/pm2, since that's where the last of
the prereqs was and we'll likely reshuffle some of those late branches
before merging anyway.


Thanks,

-Olof
