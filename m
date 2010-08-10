From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 16:03:24 +0300
Message-ID: <20100810160324.8df82287.jhnikula@gmail.com>
References: <1281442891.17541.26.camel@chotu>
	<1281443718.17541.29.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65401 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0HJNDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 09:03:39 -0400
Received: by eya25 with SMTP id 25so3788857eya.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 06:03:37 -0700 (PDT)
In-Reply-To: <1281443718.17541.29.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

On Tue, 10 Aug 2010 15:35:18 +0300
Ameya Palande <ameya.palande@nokia.com> wrote:

> > When I enable CONFIG_CPU_IDLE and boot kernel, it hangs around the point
> > when it switches to user space. I am able to reproduce this for 2.6.35
> > on linux-omap and linux-2.6 trees.
> > 
> > Has anyone else noticed the same thing for omap3 based boards?
> 
> Broken on linux-omap-pm as well!
> 
I'm able to reproduce with 2.6.35-rc1 but not with l-o head. It seems
that the commit below fixes this.

commit c786bcf12e092802496f1bc440b2b189144612a5
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Thu Jun 3 17:13:22 2010 +0000

    OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg


-- 
Jarkko
