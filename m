From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Set autoidle after smartidle during
 _sysc_enable
Date: Fri, 24 Sep 2010 10:29:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009241028210.10678@utopia.booyaka.com>
References: <1285300039-6384-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1112539661-1285345772=:10678"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48715 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0IXQ3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:29:33 -0400
In-Reply-To: <1285300039-6384-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, rnayak@ti.com, "Cousson, Benoit" <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1112539661-1285345772=:10678
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Hema,

On Thu, 23 Sep 2010, Hema HK wrote:

> OMAP USBOTG module has a requirement to set the autoidle bit only after
> setting smartidle bit. Modified the _sys_enable api to set the smartidle
> first and then the autoidle bit. Setting this will not have any impact on=
 the
> other modules.
>=20
> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, added Beno=EEt's ack, updated this to apply after Rajendra's=20
ENAWAKEUP patch, and queued for 2.6.37.


- Paul
--155748971-1112539661-1285345772=:10678--
