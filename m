From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCHv2 0/4] Regulator: OMAP: Removing common code for	TWL4030
 from OMAP3- board-evms
Date: Fri, 29 Jan 2010 18:37:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E4F2235@dbde02.ent.ti.com>
References: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
 <20100115111259.GC28625@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55725 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab0A2NHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 08:07:16 -0500
In-Reply-To: <20100115111259.GC28625@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, January 15, 2010 4:43 PM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
> Subject: Re: [PATCHv2 0/4] Regulator: OMAP: Removing common code for
> TWL4030 from OMAP3- board-evms
> 
> On Tue, Jan 12, 2010 at 02:43:45PM +0530, Anuj Aggarwal wrote:
> 
> > Anuj Aggarwal (4):
> >   Regulator: OMAP: Creating TWL4030 file having supplies & init data
> 
> I'd expect to see the header file here have ifdef guards and also
> include the headers it depends on (linux/regulator/machine.h at least)
> but both of those could be fixed up later.  Otherwise it all looks OK
> from a regulator point of view
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Tony,

Have you pulled these patches? I need to send another patch set
for other PMICs which would be based on the first set. Are you expecting
some change in the original set? Please let me know if that is the case.
