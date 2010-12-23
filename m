From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Thu, 23 Dec 2010 13:44:21 +0100
Message-ID: <20101223134421.6f33effd@surf>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20101221192735.GG5829@atomide.com>
	<20101221230028.7d7d5e01@surf>
	<20101222182841.GS5829@atomide.com>
	<alpine.DEB.1.10.1012231406120.18898@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:36218 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0LWMo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 07:44:27 -0500
In-Reply-To: <alpine.DEB.1.10.1012231406120.18898@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

On Thu, 23 Dec 2010 14:31:46 +0200 (EET)
Aaro Koskinen <aaro.koskinen@nokia.com> wrote:

> > No not yet, will take a look after we're done with this upcoming
> > merge window..
> 
> I also think the idea is good, and this should be maybe posted to wider
> audience than just linux-omap.

Yes, definitely. As the proof of concept implementation was
demonstrating usage on OMAP, I wanted to have some early comments of
a few kernel developers before going to a wider audience.

> > Yeah I don't know how much non-init data we have for each board-*.c
> > file. Maybe there is not much for each machine.
> 
> I took a quick look at omap2plus_defconfig kernel, and non-init text/data
> for 29 boards takes 85K. If we would page align those memory consumption
> would increase during init to 29*8=232K, but after other boards are
> freed we would eventually save 85-8=77K.

Thanks for those numbers. 77K is nice, but is not really a huge saving.

> Under mach-omap2, another big consumer is clock data which takes also
> around 80 K, while e.g. on 2420 only 14 K is needed.

My patch 3/6 (which didn't make it to the list, since it was probably
too large) already marked some OMAP2 clock data.

Unfortunately, I haven't found a nice way of putting strings into a
separate sections. For example:

static struct foobar __omap2 foo = {
	.name = "blabla",
	.id   = 12,
};

The "struct foobar" goes into the OMAP2-specific section (8 bytes), but
the "blabla" string (6 bytes) remains in the global .rodata section,
without anyway from removing it. The only solution I see so far would
be :

static char __omap2 foo_name[] = "blabla";

static struct foobar __omap2 foo = {
	.name = foo_name,
	.id = 12,
};

but it's really unpleasant.

Other ideas ?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
