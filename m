From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Wed, 14 Oct 2009 12:44:07 +0300
Message-ID: <20091014094407.GA7471@codecarver.research.nokia.com>
References: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com> <87r5t7ku90.fsf@deeprootsystems.com> <20091013194808.GB12700@atomide.com> <636c5030910131251p14057abdobab3ba5bfb0d67f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34874 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbZJNJpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 05:45:46 -0400
Content-Disposition: inline
In-Reply-To: <636c5030910131251p14057abdobab3ba5bfb0d67f2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Oct 13, 2009 at 09:51:30PM +0200, ext Kevin Hilman wrote:
> On Tue, Oct 13, 2009 at 12:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Kevin Hilman <khilman@deeprootsystems.com> [091013 12:09]:
> >> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> >>
> >> > From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia.com>
> >> >
> >> > This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace via
> >> > sysfs. This can be used to track down silicon specific issues. The info is
> >> > exported via sysfs because it should be possible to include this in corematic
> >> > dumps.
> >> >
> >> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> >>
> >> Please export these via debugfs.
> >
> > I don't think we want to export unique chip identifiers by default.
> >
> 
> Right, which is why I suggested using debugfs, which is something that
> probably wouldn't be enabled/exported on default production kernels.
> 

Which is why I do not want it in debugfs as we log this info in
crash reports on devices which might not have debugfs enabled.

Cheers,

Peter.

-- 
goa is a state of mind
