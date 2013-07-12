From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
Date: Fri, 12 Jul 2013 11:27:36 +0200
Message-ID: <51DFCC08.4050204@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com> <20130711145916.GA6138@kahuna> <51DED333.9080609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab3GLJ2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 05:28:01 -0400
In-Reply-To: <51DED333.9080609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 05:45 PM, Peter Ujfalusi wrote:
>> We could get rid of all the #ifdef from the code that way. OMAP3 is =
the
>> only platform that still depends on this - Further, with this change=
,
>=20
> Yep, I can do that. I'll send a separate patch to do this.

Now that I have looked at this: we might need to wait a bit and clean u=
p other
files first: if we compile twl-common only if OMAP3 is selected, a buil=
d for
OMAP4/5 only will break due to missing symbol in pm.c (omap_pmic_late_i=
nit is
missing).
I could add another set of #ifdef there, but it defeats the point IMHO.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
