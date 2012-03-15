From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
Date: Thu, 15 Mar 2012 10:21:29 -0500
Message-ID: <CAB-zwWh3tcz5xUkzthH_AAsmeXfMieUW-SCQnAaXyfSg8khqvg@mail.gmail.com>
References: <20120228053524.16278.59430.stgit@dusk>
	<20120228053657.16278.76132.stgit@dusk>
	<CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
	<alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:46509 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932409Ab2COPVa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 11:21:30 -0400
Received: by mail-lb0-f179.google.com with SMTP id gn12so1482641lbb.10
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 08:21:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

On Thu, Mar 15, 2012 at 1:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hola Omar,

Hola :)

> On Wed, 14 Mar 2012, Ramirez Luna, Omar wrote:
>
>> If we reached here the reset lines will be asserted, and then the co=
de
>> below touches sysc registers on a module under reset.
>
> Do you know of any case where this would be a problem? =A0Seems like =
it
> would only affect IP blocks that have both hard reset lines and SYSCO=
NFIG
> registers, and as far as I know, we don't have any of those defined?

MMU (not yet mainlined) has both, a reset line and a sysconfig.

I have been holding the hwmod for some time, but now that
rpmsg/remoteproc is going to mainline it could make use of it along
with omap3isp, however now I need to define functions to handle the
reset lines (although I was fine with hwmod handling it).

AFAIKnew, hwmod handling the reset line was fine (IMHO), the only 2 thi=
ngs were:
- For the drivers to somehow make use of shutdown/enable if they
needed they hwmod under reset and out.
- The annoying: hwmod XX failed to hardreset because of the wrong
reset sequence but causing no functional issues.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
