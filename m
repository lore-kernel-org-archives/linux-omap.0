From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] cbus: Fix initialization of cached IRQ masks
Date: Fri, 18 Nov 2011 16:01:30 -0800
Message-ID: <20111119000130.GT31337@atomide.com>
References: <20111118113132.5baeb268@milhouse>
 <20111118133450.GD9999@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53316 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823Ab1KSABe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:01:34 -0500
Content-Disposition: inline
In-Reply-To: <20111118133450.GD9999@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Michael =?utf-8?B?QsO8c2No?= <m@bues.ch>, linux-omap <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [111118 04:59]:
> On Fri, Nov 18, 2011 at 11:31:32AM +0100, Michael B=C3=BCsch wrote:
> > This fixes the initialization of retu/tahvo cached IRQ masks.
> >=20
> > Signed-off-by: Michael Buesch <m@bues.ch>
>=20
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks applying all three into cbus.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
