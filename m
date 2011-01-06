From: <aaro.koskinen@nokia.com>
Subject: RE: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Thu, 6 Jan 2011 10:15:50 +0000
Message-ID: <BC214410FD04D84F9079A62423659707161C0C@008-AM1MPN1-003.mgdnok.nokia.com>
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com>,<874o9mvpxf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:44933 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab1AFKQV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 05:16:21 -0500
In-Reply-To: <874o9mvpxf.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Kevin Hilman [khilman@ti.com]:
> Aaro Koskinen <aaro.koskinen@nokia.com> writes:
>
> > Make !CONFIG_SUSPEND init declarations identical on all OMAPs and
> > eliminate some ifdefs.
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
>
> I like this solution, but it introduces compiler warnings:
>
> [...]
>
> As you likely noticed, removing the const leads to checkpatch warnings:
>
> WARNING: struct platform_suspend_ops should normally be const
>
> so the choice is between a checkpatch warning or a bunch of compiler
> warnings.
>
> Alternatively, I just posted a patch[1] to linux-pm propsing to fix this
> at the source.  Let's see what happens there.  Merging $SUBJECT patch
> will depend on how this is fixed upstream.

Sorry, I should have mentioned this when I posted the patch. I was aware of
this issue, but I thought this was already fixed in upstream. Check the following
commit in linux-next:

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=2f55ac072f5344519348c0c94b3d2f4cca46847b

(suspend: constify platform_suspend_ops)

A.
