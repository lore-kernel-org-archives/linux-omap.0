From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] omapfb: Fix argument of blank
 operation.
Date: Wed, 11 Mar 2009 15:20:00 -0700
Message-ID: <20090311152000.8a3db19c.akpm@linux-foundation.org>
References: <1228430755-4221-1-git-send-email-felipe.contreras@gmail.com>
	<5d5443650903111017n9c818b0y2119d06ea84c3abf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48684 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752270AbZCKWXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 18:23:31 -0400
In-Reply-To: <5d5443650903111017n9c818b0y2119d06ea84c3abf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: felipe.contreras@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, felipe.contreras@nokia.com, linux-kernel@vger.kernel.org

On Wed, 11 Mar 2009 22:47:41 +0530
Trilok Soni <soni.trilok@gmail.com> wrote:

> Hi Felipe,
> 
> On Fri, Dec 5, 2008 at 4:15 AM, Felipe Contreras

I bet he thought we'd forgotten.

> <felipe.contreras@gmail.com> wrote:
> > From: Felipe Contreras <felipe.contreras@nokia.com>
> >
> > The blank operation should receive FB_BLANK_POWERDOWN, not
> > VESA_POWERDOWN.
> >
> 
> Thanks. Looks good.
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> 

Unfortunately the changelog didn't give me any hint as to the
seriousness of the problem which was fixed.  So I queued it for 2.6.30,
perhaps inappropriately.


