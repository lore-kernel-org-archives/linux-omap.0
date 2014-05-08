From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
Date: Thu, 8 May 2014 13:08:16 +0300
Message-ID: <536B5790.1050800@ti.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbaEHKIp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 06:08:45 -0400
In-Reply-To: <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

Hi Paul,

On 05/08/2014 03:20 AM, Paul Walmsley wrote:
> Hi P=E9ter,
>=20
> On Wed, 30 Apr 2014, Peter Ujfalusi wrote:
>=20
>> Add HWMOD_SWSUP_SIDLE to flags.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> This patch could use a better changelog.  It would be ideal to unders=
tand=20
> _why_ HWMOD_SWSUP_SIDLE is needed.  Is there a known hardware bug?  O=
r is=20
> this simply based on practical observation, e.g., something bad happe=
ns if=20
> the McPDM is not software-idled?

The same issue exists on OMAP5 as on OMAP4:

commit 12d82e4b0aa6c71f38b668a372f9a13f243207da
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Fri Jan 18 16:48:16 2013 -0700

    ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

    McPDM need to be configured to NO_IDLE mode when it is in used othe=
rwise
    vital clocks will be gated which results 'slow motion' audio playba=
ck.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    [paul@pwsan.com: copy patch description into hwmod data comments]
    Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
