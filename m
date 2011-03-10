From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Thu, 10 Mar 2011 09:39:31 +0100
Message-ID: <4D788E43.4040201@ti.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com> <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1CJIj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:39:29 -0500
In-Reply-To: <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Salut Paul,

On 3/10/2011 3:37 AM, Paul Walmsley wrote:
>
> Hi,
>
> I just queued a patch to fix the SmartReflex problem.  It's the part =
that
> fixes the incorrect data:
>
>      http://marc.info/?l=3Dlinux-omap&m=3D129972435510631&w=3D2
>
> Beno=EEt, if you are happy with it, care to send an Acked-by:?  Also,=
 I
> guess we should revisit the other part of your patch at some point.

I'm almost fine with it, but if you do not want to remove the other=20
masters ports of the interconnect, then you should move SR ocp_if from=20
slaves to masters first, like it was supposed to be during the=20
introduction of the SR data?

And then remove all the interconnect master list in a second patch?

Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
