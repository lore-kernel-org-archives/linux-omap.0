From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 12 Mar 2013 12:11:54 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA516BD@HQMAIL03.nvidia.com>
References: <1363053266-515-1-git-send-email-achew@nvidia.com>
 <20130312070104.GB6467@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:17505 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302Ab3CLTMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 15:12:03 -0400
In-Reply-To: <20130312070104.GB6467@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Thierry Reding [mailto:thierry.reding@avionic-design.de]
> Sent: Tuesday, March 12, 2013 12:01 AM
> To: Andrew Chew
> Cc: peter.ujfalusi@ti.com; Alex Courbot; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
> pwm-backlight
> 
> * PGP Signed by an unknown key
> 
> On Mon, Mar 11, 2013 at 06:54:26PM -0700, Andrew Chew wrote:
> > The pwm-backlight driver now takes a mandatory regulator that is
> > gotten during driver probe.  Initialize a dummy regulator to satisfy
> > this requirement.
> >
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > ---
> > This patch, along with many more soon to follow, attempts to satisfy
> > the new mandatory regulator that pwm-backlight will grab during probe.
> > The only board in mach-omap2 to use the pwm-backlight appears to be the
> 4430sdp.
> >
> > I thought I'd start small and use this board as an example.
> >
> > I tested similar code in my Tegra board, so it should be okay.  Of
> > course, I don't have a 4430sdp to test with.
> 
> Hi Andrew,
> 
> This looks good, one minor comment below. I think it might make sense to
> post this patch as part of a series that includes the change to the pwm-
> backlight driver. This will make things easier on potential testers.
> You can later extend that series to include all the other users and eventually
> the whole series can be merged.

Do you mean I should do a single patch series, accumulating other boards
as I go?

And by the way, do I have your reviewed-by for the pwm-backlight regulator
patch?
