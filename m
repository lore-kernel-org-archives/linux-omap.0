From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Fri, 21 Jan 2011 09:28:42 +0200
Message-ID: <20110121092842.bd17f93b.jhnikula@gmail.com>
References: <1295532731-5438-1-git-send-email-weber@corscience.de>
	<AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com>
	<20110120181952.GY4957@atomide.com>
	<AANLkTikkApJAa_mnwr9tKT2e2OUnERHoEifbdj8+CcEe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63255 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab1AUH2r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 02:28:47 -0500
Received: by fxm20 with SMTP id 20so1468757fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 23:28:46 -0800 (PST)
In-Reply-To: <AANLkTikkApJAa_mnwr9tKT2e2OUnERHoEifbdj8+CcEe@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Poddar, Sourav" <sourav.poddar@ti.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

On Fri, 21 Jan 2011 11:55:55 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> >> I was just about to post a patch for this, but you beat me
> >> to it!
> >>
> >> > Signed-off-by: Thomas Weber <weber@corscience.de>
> >>
> >> Acked-by: Sourav Poddar <sourav.poddar@ti.com>
> >
> > Thanks, merging this into the original. Also adding
> > applying into linux-omap master.
> >
> 
> Aren't we breaking multi-omap build with this?
> 
Don't point it out immediately but these patches looks like yet another
reason why there's a need to get rid of these ifdefs and cpu_is_omapxxx
tests from the drivers.

-- 
Jarkko
