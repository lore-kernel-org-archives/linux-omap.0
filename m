From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Mon, 18 Jan 2010 13:46:16 +0200
Message-ID: <20100118114616.GE2234@esdhcp037198.research.nokia.com>
References: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
 <87r5t7ku90.fsf@deeprootsystems.com>
 <20091013194808.GB12700@atomide.com>
 <636c5030910131251p14057abdobab3ba5bfb0d67f2@mail.gmail.com>
 <20091014094407.GA7471@codecarver.research.nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43232 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0ARLqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 06:46:44 -0500
Content-Disposition: inline
In-Reply-To: <20091014094407.GA7471@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Tony and Kevin,

On Wed, Oct 14, 2009 at 11:44:07AM +0200, De-Schrijver Peter (Nokia-D/Helsinki) wrote:
> On Tue, Oct 13, 2009 at 09:51:30PM +0200, ext Kevin Hilman wrote:
> > On Tue, Oct 13, 2009 at 12:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Kevin Hilman <khilman@deeprootsystems.com> [091013 12:09]:
> > >> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> > >>
> > >> > From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia.com>
> > >> >
> > >> > This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace via
> > >> > sysfs. This can be used to track down silicon specific issues. The info is
> > >> > exported via sysfs because it should be possible to include this in corematic
> > >> > dumps.
> > >> >
> > >> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> > >>
> > >> Please export these via debugfs.
> > >
> > > I don't think we want to export unique chip identifiers by default.
> > >
> > 
> > Right, which is why I suggested using debugfs, which is something that
> > probably wouldn't be enabled/exported on default production kernels.
> > 
> 
> Which is why I do not want it in debugfs as we log this info in
> crash reports on devices which might not have debugfs enabled.

As Peter said here, this patch is to identify the chip from user land.
So it is not really a debug tool, but a identification tool.

Any good reason why we should not have it?

Another thing is, it could go into /proc/cpuinfo. Currently I don't
see any OMAP related info there, only ARM. Do you guys know why we don't
put anything in /proc/cpuinfo?

> 
> Cheers,
> 
> Peter.
> 
> -- 
> goa is a state of mind
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR,

-- 
Eduardo Valentin
