From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 8 Jul 2011 16:16:12 +0300
Message-ID: <20110708131611.GE11037@atomide.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
 <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
 <4E14B820.6070202@ti.com>
 <20110707055549.GC15815@atomide.com>
 <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60008 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564Ab1GHNQR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 09:16:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110708 09:34]:
> On Thu, 7 Jul 2011, Tony Lindgren wrote:
>=20
> Rajendra's patch series doesn't require the 4430 -> 44XX changes in t=
he=20
> PRM/CM macros (Beno=C3=AEt's patch 16).  That patch can be put in a s=
eparate=20
> series, if you like. =20
>=20
> It does require changing CHIP_IS_OMAP4430 to CHIP_IS_OMAP44XX in the=20
> powerdomains, clockdomains, etc.  To me, that seems reasonable since =
the=20
> 4460 isn't simply a die shrink, it has some other changes on it; but =
I=20
> guess you have a different view on that.

To me it seems the CHIP_IS_OMAP44XX is just defined as CHIP_IS_OMAP3430
in Benoit's patch 16.

> I will add acks/reviewed-by:s on the 4460 patches, and maybe you can=20
> decide which ones you'd like to merge, if any.

I applied the first four 4460 patches but left out the CHIP_IS44XX
changes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
