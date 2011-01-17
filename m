From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 15:45:37 +0530
Message-ID: <126c39969c8e98576bfed2b4d28794b3@mail.gmail.com>
References: <20110114194758.GM4957@atomide.com> <9ba47985064c771620bac3f4fce6a3b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47838 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212Ab1AQKPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 05:15:40 -0500
Received: by fxm9 with SMTP id 9so6019148fxm.17
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 02:15:39 -0800 (PST)
In-Reply-To: <9ba47985064c771620bac3f4fce6a3b0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Tony,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Saturday, January 15, 2011 10:50 AM
> To: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: RE: Open issues after 2.6.38 merge window
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Saturday, January 15, 2011 1:18 AM
> > To: linux-omap@vger.kernel.org
> > Subject: Open issues after 2.6.38 merge window
> >
> > Hi all,
> >
> > Before I update out master branch, let's try to summarize the
> > open issues after the merge window. Here's a list of issues
> > in omap-fixes-for-linus that I'm aware of:
> >
>
> > - omap4430 es1.0 hangs if L2X0 cache is enabled
> >
> Will have look at this one on Monday
>
I don't see the hang with L2X0 enable on my ES1.0 SDP
with the latest Linus's head.

(Mainline 'e78bf5e6cbe837' + Paul's sync timer fix)

The kernel boots fine.

Regards
Santosh
