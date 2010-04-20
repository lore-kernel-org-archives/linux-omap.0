From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCHv3 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Tue, 20 Apr 2010 17:40:08 +0300
Message-ID: <1271774408.2433.25.camel@tubuntu.research.nokia.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
	 <4BCDA3DF.5010906@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56244 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0DTOkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 10:40:33 -0400
In-Reply-To: <4BCDA3DF.5010906@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-04-20 at 14:53 +0200, Quadros Roger (Nokia-D/Helsinki)
wrote:
> Hi Tomi,
> 
> Quadros Roger (Nokia-D/Helsinki) wrote:
> > Tomi,
> > 
> > Resending the patchset.
> > 
> > Checkpatch was not complaining at my end. Probably the mail server is
> > mangling the patches. I will send a tarball separately.
> > 
> > The only change in this version is that i've put the Video memory
> > initialization code in the board file.
> > 
> > The TSC2005 stuff is still thereas without it panel is not detected.
> > The merge conflict with TSC2005 patches if happens is very trivial to resolve.
> > 
> 
> I don't see his patches in your git tree yet.
> When do you plan to have this in?

I pushed them to master branch.

I need to find some time to go through them a bit better before moving
them to for-next branch.

 Tomi


