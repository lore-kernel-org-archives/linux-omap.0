From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 3/3] omap3+: sr: Reuse sr_[start|stop]_vddautocomp
 functions
Date: Thu, 3 Mar 2011 08:57:09 +0200
Message-ID: <20110303085709.b443794f.jhnikula@gmail.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
	<1299081445-27938-4-git-send-email-jhnikula@gmail.com>
	<4D6E775D.7040107@ti.com>
	<87vd01t4ex.fsf@ti.com>
	<4D6EE654.1090207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37336 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1CCGzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 01:55:46 -0500
Received: by ewy6 with SMTP id 6so255708ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 22:55:44 -0800 (PST)
In-Reply-To: <4D6EE654.1090207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

On Thu, 03 Mar 2011 06:22:36 +0530
Nishanth Menon <nm@ti.com> wrote:

> Kevin Hilman wrote, on 03/03/2011 06:18 AM:
> > Nishanth Menon<nm@ti.com>  writes:
> >> Looks like a nice cleanup to me.
> >>
> >> if the motivation of patch 1/3 is to do this cleanup, I am altogether
> >> for it (lesser code == lesser bugs ;) ). btw, this should not impact
> >> class1.5 either - core sr.c sequencing has not been modified in sr1.5
> >> :)
> >>
Heh, no any hidded motivation here. I was just blind to see your 12/18
and I found the issue and cleanup possibilities at the same time and
decided to put them into same RFC set :-)

> > Nishanth,
> >
> > I'd prefer if you handle these.  You can add them to the fixup/cleanup
> > part of your SR1.5 series.
> 
> ok will pull this in as part of sr1.5 series if no further review comments.
> 
Ok, that's fine to me (though your set has the priority as I didn't
notice the 12/18).

-- 
Jarkko
