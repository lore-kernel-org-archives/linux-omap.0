From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP PM interface, version 2
Date: Wed, 18 Jun 2008 23:49:03 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806182334290.24288@utopia.booyaka.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain> <87od5zatew.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1731025234-1213854543=:24288"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47418 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbYFSFtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2008 01:49:04 -0400
In-Reply-To: <87od5zatew.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@mvista.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1731025234-1213854543=:24288
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jouni,=20

On Wed, 18 Jun 2008, H=C3=B6gander Jouni wrote:

> "ext Paul Walmsley" <paul@pwsan.com> writes:
>=20
> > Major changes since the first version:
> >
> > 1. Jouni Hogander suggested that the set_max_cpu_lat() function be
> >    merged into set_max_dev_wakeup_lat(), when set_max_dev_wakeup_lat()
> >    is called with the CPU0 sys_device (via get_cpu_sysdev(0)).  He feel=
s
> >    that this will be easier for device driver developers to use.  This
> >    change has been made.
>=20
> I just noticed that this won't work. We have this declaration:
>=20
> (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t)
>=20
> In case of cpu it is not possible to underlying code to identify the
> caller.=20

Eh, nice catch.  Let's add set_max_intr_lat() back in - perhaps call it=20
set_max_mpu_wakeup_lat() instead for symmetry?

> This derives a question should we have parameter for caller
> identification in set_max_dev_wakeup_lat()?
>=20
> I mean currently we are assuming that there is only one caller for each=
=20
> device. Is this correct assumination?  If we think e.g. busses. There=20
> might be drivers for devices on some specific bus. Each of them might=20
> want to set latency constraint for the bus.

In the case of bus wakeup latency, all of the on-chip interconnects share=
=20
the same wakeup latency - the CORE powerdomain wakeup latency.  So=20
set_max_dma_lat() covers all of the interconnect latencies.

We could call it set_max_bus_wakeup_lat(), with a prototype similar to=20
set_max_dev_wakeup_lat(), for consistency. (The bus agent argument would=20
effectively be ignored in OMAP2/3.)

Thoughts?


- Paul
--155748971-1731025234-1213854543=:24288--
