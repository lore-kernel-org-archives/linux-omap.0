From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [RFC PATCH] GPIO chip select support for McSPI
Date: Tue, 21 Dec 2010 12:56:34 -0500
Message-ID: <1292954195-20204-1-git-send-email-bgamari.foss@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36276 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab0LUR4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:56:45 -0500
Received: by vws16 with SMTP id 16so1814899vws.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:56:45 -0800 (PST)
In-Reply-To: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael


As you may recall, about a year ago I wrote wondering whether it was possible
to use GPIO lines as chip selects in the McSPI driver. A few of you pointed out
that this functionality had been added to other drivers and it should be quite
simple to do the same for McSPI. Two semesters then passed without a followup
from me.

Thankfully, classes are over and I've had some downtime due to sickness,
finally freeing up some time to look at this (just in time as we'll soon need
this functionality). This morning I looked through the relevant code and put
together this patch to add support for GPIO CSs. As was suggested, I modelled
this after the approach taken in the s3c24xx-spi driver. Let me know whether
this looks sane. It has yet to see hardware, but in principle things look
alright (famous last words).

Cheers,

- Ben


P.S. In case people are curious to see an example of usage I have a patch
adding support for multiplexed chip selects to support a data acquisition board
for the BeagleBoard that I've been working on[1]. I can send these out if
people are interested.

[1] http://goldnerlab.physics.umass.edu/wiki/BeagleBoardDaq

