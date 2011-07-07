From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [GIT PULL] TWL6040 MFD and followups
Date: Thu, 7 Jul 2011 21:46:01 +0300
Message-ID: <2495406.tIHCNdL4la@barack>
References: <5898202.Q4JP1WeJj2@barack> <20110707182947.GM5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab1GGSqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 14:46:09 -0400
In-Reply-To: <20110707182947.GM5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 07 July 2011 20:29:47 Tony Lindgren wrote:
> Thanks. Can you please add one more branch for cleanup only for me to
> pull at your commit b252b0efb605b92a2f5d118e294d088d89cfd286
> (OMAP3: Move common regulator configuration to twl-common)?

Do you want a separate pull request for it?
The branch name, which only have the cleanup (ends with=20
b252b0efb605b92a2f5d118e294d088d89cfd286):
peter/topic/for-tony_mach-cleanup

> That way I can first pull that into cleanup and send that to Arnd.
> Then we can do a separate twl-asoc branch so the cleanup stays
> separate from new code.

Sound like a plan.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
