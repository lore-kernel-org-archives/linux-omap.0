From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Tue, 19 Jul 2011 10:53:01 +0300
Message-ID: <1311061981.10230.21.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-4-git-send-email-t-kristo@ti.com> <20110718182218.GJ25081@legolas.emea.dhcp.ti.com>  <87ipqzkvim.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44779 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab1GSHxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 03:53:07 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87ipqzkvim.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Tue, 2011-07-19 at 01:40 +0200, Hilman, Kevin wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
> >> diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/omap-smps-regulator.c
> >> new file mode 100644
> >> index 0000000..8b56e4f
> >> --- /dev/null
> >> +++ b/drivers/regulator/omap-smps-regulator.c
> >> @@ -0,0 +1,179 @@
> >> +/*
> >> + * omap-vp-regulator.c -- support SMPS regulators for OMAP chips
> >
> > name is wrong here.
> 
> In fact, just leave filenames out of file headers all together to avoid
> this kind of problem.

Yea, can drop that out.



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

