From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: PM: Declare idle modules as functional too
Date: Fri, 24 Sep 2010 01:28:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009240123420.10678@utopia.booyaka.com>
References: <1285312248-15734-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-171366562-1285313286=:10678"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55071 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab0IXH2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:28:07 -0400
In-Reply-To: <1285312248-15734-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-171366562-1285313286=:10678
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra, Partha, Beno=EEt,

On Fri, 24 Sep 2010, Rajendra Nayak wrote:

> The omap4_cm_wait_module_ready function would only check for
> the modules to be completely functional before declaring them
> ready to be accessed.
> There might also be instances where in the module is actually
> in idle (under h/w control) but should still be declared
> accessible, as the h/w control would make it functional when
> needed.
>=20
> Hence make omap4_cm_wait_module_ready return true in case
> the module is fully functional *or* in idle state.
> Fail only if the module is fully disabled or stuck intransition.
>=20
> The explaination from the TRM for the idlest bits on OMAP4 is as
> below for quick reference
>=20
> Module idle state:
> 0x0 func:     Module is fully functional, including OCP
> 0x1 trans:    Module is performing transition: wakeup, or sleep, or sleep
>               abortion
> 0x2 idle:     Module is in Idle mode (only OCP part). It is functional if
>               using separate functional clock

Thanks for the detailed changelog.  Do we need to check any other=20
registers to ensure that the OCP port is in autoidle, or to ensure that=20
the separate functional clock is active?


- Paul
--155748971-171366562-1285313286=:10678--
