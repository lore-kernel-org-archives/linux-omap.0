From: <aaro.koskinen@nokia.com>
Subject: RE: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
 omap_i2c
Date: Thu, 9 Dec 2010 22:18:48 +0000
Message-ID: <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<20101209190110.GR20097@trinity.fluff.org>,<87wrni7jys.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:55773 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab0LIWTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 17:19:34 -0500
In-Reply-To: <87wrni7jys.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, ben-i2c@fluff.org
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, b-cousson@ti.com

Hi,

Kevin Hilman [khilman@deeprootsystems.com]:
> Ben Dooks <ben-i2c@fluff.org> writes:
> > Renaming stuff like this is going to have an impact on the userspace
> > as anyone looking through /sys's driver heirarchy is going to miss the
> > old name...
> >
> > It all depends if you really want to go ahead with this...
>
> Yes, we are aware of the userspace impact, but this name change makes
> all devices on OMAP have consistent names and actually improves the
> ability to have userspace tools have consistent naming as well.

So there are no imporant users, or if there is, they are prepared for this change?

>> >  drivers/i2c/busses/i2c-omap.c        |    4 ++--

What about the .c / .ko file name?

A.
