From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: QoS: rename pm_qos_params files to pm_qos
Date: Tue, 2 Aug 2011 11:47:36 +0200
Message-ID: <201108021147.36233.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <201107292357.48969.rjw@sisk.pl> <CAORVsuX1iXnQS5LZeKb7nJa1_QCmnHDpDZBWyQab6rcLqig=TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41025 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab1HBJqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 05:46:10 -0400
In-Reply-To: <CAORVsuX1iXnQS5LZeKb7nJa1_QCmnHDpDZBWyQab6rcLqig=TQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Tuesday, August 02, 2011, Jean Pihet wrote:
> Rafael,
> 
> 2011/7/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> The PM QoS implementation files are better named
> >> kernel/pm_qos.c and include/linux/pm_qos.h.
> >>
> ...
> 
> >>  create mode 100644 include/linux/pm_qos.h
> >>  delete mode 100644 include/linux/pm_qos_params.h
> >
> > That I agree with.
> >
> >>  create mode 100644 kernel/pm_qos.c
> >>  delete mode 100644 kernel/pm_qos_params.c
> >
> > As I said, please move that file to kernel/power and call it qos.c.
> Ok
> 
> >
> > That said the device interface should be located in drivers/base/power
> > to follow our current conventions.
> By device interface I understand the following:
> - the user space API (per-device sysfs entry),
> - the in-kernel device specific PM QoS API. If needed, cf. comments on
> [04/13] about that.
> 
> Is that correct?

Yes, it is.

I think that the definitions of the dev_pm_qos_*() funtions mentioned
in there may go into drivers/base/power/qos.c and they can call functions
from kernel/power/qos.c.

Thanks,
Rafael
