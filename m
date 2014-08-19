From: Hugh Dickins <hughd@google.com>
Subject: Re: Lock Directory failure
Date: Tue, 19 Aug 2014 09:34:49 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1408190926090.1991@eggly.anvils>
References: <20140818163209.GJ9662@saruman.home> <alpine.LSU.2.11.1408181350260.1127@eggly.anvils> <20140820012345.7c358fd7@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52293 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaHSQgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 12:36:36 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so10062599pde.4
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2014 09:36:35 -0700 (PDT)
In-Reply-To: <20140820012345.7c358fd7@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonas Jensen <jonas.jensen@gmail.com>, Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 20 Aug 2014, Stephen Rothwell wrote:
> On Mon, 18 Aug 2014 13:58:26 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> >
> > [PATCH next] vfs: initialize m_list to fix crash in mnt_set_mountpoint
> > 
> > Fix mnt_set_mountpoint() crash: new_mountpoint() must initialize m_list.
> > 
> > Reported-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> I assume that this is a fix for commit 89f7ca1af15b ("vfs: Keep a list
> of mounts on a mount point") that is currently i the vfs tree.  I will
> apply this patch as a fix up for the vfs tree in linux-next today.

Yes, that's it: thanks a lot, Stephen, that will help everybody.

I should acknowledge that Thierry Reding posted the same fix (a few
lines away) before mine, but I only came across his later in the day.

Hugh
