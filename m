From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: serial-omap regression?
Date: Thu, 20 Sep 2012 16:03:50 -0700
Message-ID: <87obl0fga1.fsf@deeprootsystems.com>
References: <87wqzofgms.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37437 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab2ITXDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 19:03:45 -0400
Received: by pbbrr4 with SMTP id rr4so1218707pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 16:03:45 -0700 (PDT)
In-Reply-To: <87wqzofgms.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 20 Sep 2012 15:56:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Hi Felipe,
>
> I just noticed today that one of my boards (3530/Overo) was not making
> it to the console when using an Debian rootfs (nfsroot) but works fine
> with my basic busybox initramfs.  Basically, it hangs somewhere between
> finishing the userspace init and launching the login shell.
>
> git bisect ended up pointing the finger at a patch in the OMAP serial
> series[1].  I didn't debug this any further.  Any ideas?
>

I forgot to add, this was first noticed when testing with
arm-soc/for-next which has the serial-omap changes pulled in as a
dependency.

Kevin

>
>
> 72256cbd13904d4b4dbb16f5ec83a3293bb292c5 is the first bad commit
> commit 72256cbd13904d4b4dbb16f5ec83a3293bb292c5
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Thu Sep 6 15:45:24 2012 +0300
>
>     serial: omap: refactor receive_chars() into rdi/rlsi handlers
>     
>     receive_chars() was getting too big and too difficult
>     to follow. By splitting it into separate RDI and RSLI
>     handlers, we have smaller functions which are easy
>     to understand and only touch the pieces which they need
>     to touch.
>     
>     Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>     Signed-off-by: Felipe Balbi <balbi@ti.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> :040000 040000 69585356cd524953305cfba7d219cd65430a4067 ffdc0c05004afe8b73c1f2c0ba41e412c1faf5f4 M	drivers
