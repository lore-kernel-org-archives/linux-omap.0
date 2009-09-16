From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Wed, 16 Sep 2009 20:11:27 +0100
Message-ID: <20090916191127.GB16457@n2100.arm.linux.org.uk>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com> <4A8FA4E7.9020206@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com> <87hbvtfw8g.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com> <873a7dwfk0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43846 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbZIPTLh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Sep 2009 15:11:37 -0400
Content-Disposition: inline
In-Reply-To: <873a7dwfk0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Aug 27, 2009 at 04:29:35PM +0300, Kevin Hilman wrote:
> > The idea is to write to phys_io and io_pg_offset from kernel/head.S
> > very early based on the uart address found in compressed/misc.c
> >
> > To make map_io writable, I will have to change the MACHINE_START to
> > remove the const.  It so happens that Russell has defined
> > MACHINE_START to be a const.
> >
> > Not sure is removing const from MACHINE_START is acceptable?
> 
> we'll find out after you post for RFC.

The answer is no, it is not acceptable - it'll break XIP kernels
because this is placed into the read-only part of the kernel image
no matter what.
