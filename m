From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/PATCH] PM QoS: main memory throughput constraints
Date: Fri, 30 Sep 2011 22:28:07 +0200
Message-ID: <201109302228.07589.rjw@sisk.pl>
References: <CAORVsuXqujs-mdXG0VYb+LKfPVG2AfboxacKFSW1fo0E-3C3sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40413 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab1I3UZw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 16:25:52 -0400
In-Reply-To: <CAORVsuXqujs-mdXG0VYb+LKfPVG2AfboxacKFSW1fo0E-3C3sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi,

On Friday, September 30, 2011, Jean Pihet wrote:
> Hi,
> 
> Here is a patch which adds a PM_QOS_MEMORY_THROUGHPUT class to the PM
> QoS framework. The idea is to provide a memory or SDMA throughput
> constraints class, which can be applied to the low level platform code
> using the callback notification mechanism and also a MISC /dev entry
> for the constraints from user space.
> 
> The first user of this class of constraints is the OMAP platform. The
> aggregated constraint is fed to the DVFS layer in order to control the
> main interconnect (L3) frequency and so the memory bandwidth. This
> comes as a subsequent patch.
> 
> This patch is RFC since more throughput constraints could be added in
> the future, in order to control more clocks in the system. Is it worth
> adding a class for every new subsystem to control?
> 
> What do you think?
> 
> The patch follows asap as a reply to this message. It applies on
> Rafael' latest linux-pm tree, cf.
> https://github.com/rjwysocki/linux-pm/commits/pm-qos.

Quite frankly, I'm not very fond of creating more special device files for
PM QoS at this point.  It would be nice if you could give an example of
how you intend to use it, especially from the user space's viewpoint.

Thanks,
Rafael
