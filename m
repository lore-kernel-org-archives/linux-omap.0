From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with
 partial activation
Date: Tue, 07 May 2013 16:09:14 +0200
Message-ID: <1367935754.4474.39.camel@coredoba.hi.pengutronix.de>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
	 <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
	 <5187D655.1010402@kernel.org>
	 <902E054D-F014-4380-A493-96384AC85DD4@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52228 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973Ab3EGOIG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 10:08:06 -0400
In-Reply-To: <902E054D-F014-4380-A493-96384AC85DD4@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Jonathan Cameron <jic23@kernel.org>, rachna@ti.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On Tue, 2013-05-07 at 16:08 +0300, Pantelis Antoniou wrote:
> Hi Jonathan,
> 
> On May 6, 2013, at 7:12 PM, Jonathan Cameron wrote:
> 
> > On 05/06/2013 01:48 PM, Jan Luebbe wrote:
> >> Hi Pantelis,
> >> 
> >> while trying out your patch on a custom AM335x board, I noticed that the
> >> sysfs entries ware missing. This is fixed in the first patch, you might want
> >> to squash that into your original patch.
> >> 
> >> The second one makes sure that the iio framework does not read invalid data.
> >> 
> >> Regards,
> >> Jan
> > 
> > I don't believe Pantelis ever came back with a response to the various issues
> > raised with the original patches?
> > 
> 
> I am aware. We've been quite busy getting the new beaglebone out. I plan to
> revisit the full patchset for all the various fixes we had to do in a month
> or so.

It seems that TI continued working on this in their vendor kernel:
http://arago-project.org/git/projects/?p=linux-am33x.git;a=history;f=drivers/staging/iio;hb=v3.2-staging
We could possibly reuse/port some of that work.

> > If Pantelis has moved on, Jan feel free to pick up the patches, respin them
> > and resend to linux-iio if you like (with appropriate crediting naturally)
> > 
> 
> I wouldn't mind Jan to pick up the IIO patches.

I'm currently also busy with other things, so I'm not optimistic that
I'd find some time to do this. :/

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

