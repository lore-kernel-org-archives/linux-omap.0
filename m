From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Suggestion for a new kernel version
Date: Wed, 12 Nov 2008 02:31:45 +0200
Message-ID: <94a0d4530811111631y2f454147o866c40985cb4de69@mail.gmail.com>
References: <deb0f030811101627s2f5093c0nf79d14bf6e03ca3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:60437 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYKLAbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 19:31:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so149023rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 16:31:46 -0800 (PST)
In-Reply-To: <deb0f030811101627s2f5093c0nf79d14bf6e03ca3c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org, linux@mistralsolutions.com

On Tue, Nov 11, 2008 at 2:27 AM, Suresh Rajashekara
<suresh@mistralsolutions.com> wrote:
> Hi List,
>
> We have been using 2.6.16-rc3-omap1 on one of our OMAP1 based product
> which had quite a few bugs. We had been taking some fixes from the
> later kernels and port it back, but at some point it becomes difficult
> to do it when the basic data structures changes (because any such big
> changes are frowned upon if proposed for a working product), but now,
> finally we have decided to change the kernel itself to some later
> version. I would appreciate if the list can suggest us some kernel
> version to which we can switch to. Requirements are;
>
> 1. Kernel should be pretty stable (very less bugs)
> 2. Even if there are any bugs, it should be easy to port the fixes
> back. This is important because I don't get a chance to convince the
> decision makers to change the kernel again because its something which
> is very basic and they are afraid to change a working system for a
> small bug fix.
>
> Some of the components for which we depend heavily on the kernel are
> MTD/JFFS2 (with which we have faced lot of issues in
> 2.6.16-rc3-omap1), DSP Gateway functionality and power management.
>
> Thanks in advance for your help.

You should avoid rc* releases, those are release candidates, only for
testing purposes.

You should stick with plain -omap* releases, like 2.6.27-omap1, or
2.6.26-omap2, unless you want to be on the bleeding edge.

-- 
Felipe Contreras
