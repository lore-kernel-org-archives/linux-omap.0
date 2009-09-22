From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL]: OMAP2/3 Display Subsystem
Date: Tue, 22 Sep 2009 07:33:02 -0700
Message-ID: <20090922143301.GN27699@atomide.com>
References: <1253622588.25232.11.camel@tubuntu> <4AB8C429.60804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55251 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZIVOdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:33:08 -0400
Content-Disposition: inline
In-Reply-To: <4AB8C429.60804@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: torvalds@linux-foundation.org, tomi.valkeinen@nokia.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

* Artem Bityutskiy <dedekind1@gmail.com> [090922 05:36]:
> On 09/22/2009 03:29 PM, Tomi Valkeinen wrote:
>> Linus,
>>
>> Here's the new display subsystem and framebuffer driver for OMAP2/3.
>>
>> The driver has been reviewed on linux-omap and linux-fbdev-devel, and is in
>> use, for example, on N900, Beagle Board and Overo boards. We have an ACK for
>> the OMAP parts from Tony Lindgren, who maintains the OMAP platform.
>>
>> We have gotten positive feedback about the driver, for example in this thread:
>> http://marc.info/?l=linux-kernel&m=125171081901820&w=2
>>
>> The driver is actively maintained and developed further, and I have already a
>> bunch of patches on top of these patches, but I would like to get the big core
>> driver merged first. After the driver is merged, other people can send patches
>> to LCD drivers and board files to enable the new display subsystem on their
>> boards.
>>
>> Andrew said 2-3 weeks ago that he'll merge the driver (after he has looked
>> through it), but he hasn't responded since then. I'm guessing he's quite busy.

I guess that was because there were some merge conflicts at that point, but
those are sorted out now.

> Just in case it matters, here is my redundant confirmation that we are
> successfully using this piece of software for about a year.

Ack, it would be nice to get this merged.

Regards,

Tony
