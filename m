From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [RFC/PATCH] PM QoS: main memory throughput constraints
Date: Fri, 30 Sep 2011 16:16:35 +0200
Message-ID: <CAORVsuXqujs-mdXG0VYb+LKfPVG2AfboxacKFSW1fo0E-3C3sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50483 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1I3OQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 10:16:36 -0400
Received: by vcbfk10 with SMTP id fk10so1298118vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 07:16:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi,

Here is a patch which adds a PM_QOS_MEMORY_THROUGHPUT class to the PM
QoS framework. The idea is to provide a memory or SDMA throughput
constraints class, which can be applied to the low level platform code
using the callback notification mechanism and also a MISC /dev entry
for the constraints from user space.

The first user of this class of constraints is the OMAP platform. The
aggregated constraint is fed to the DVFS layer in order to control the
main interconnect (L3) frequency and so the memory bandwidth. This
comes as a subsequent patch.

This patch is RFC since more throughput constraints could be added in
the future, in order to control more clocks in the system. Is it worth
adding a class for every new subsystem to control?

What do you think?

The patch follows asap as a reply to this message. It applies on
Rafael' latest linux-pm tree, cf.
https://github.com/rjwysocki/linux-pm/commits/pm-qos.

Regards,
Jean
