From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
Date: Fri, 4 May 2012 17:59:42 +0200
Message-ID: <20120504175942.5ceb8e91@skate>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:54942 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2EDP7z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 11:59:55 -0400
In-Reply-To: <1316809399-19579-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, grant.likely@secretlab.ca, khilman@ti.com, paul@pwsan.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Benoit,

Le Fri, 23 Sep 2011 22:23:09 +0200,
Benoit Cousson <b-cousson@ti.com> a =C3=A9crit :

> Add SoC specific map_io function to be used by the generic DT
> board file. This is an intermediate step before having some
> generic DT aware map_io function.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Do you know if some progress has been made on having a generic DT aware
map_io function, or is the per-SoC ->map_io() function still the
recommended way of handling SoC having different requirements of static
mappings at boot time?

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
