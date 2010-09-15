From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [v4 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Wed, 15 Sep 2010 11:03:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F98F@dbde02.ent.ti.com>
References: <1284390809-11519-1-git-send-email-charu@ti.com>
	<1284390809-11519-5-git-send-email-charu@ti.com>
 <87tylsnqt0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab0IOFd2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 01:33:28 -0400
In-Reply-To: <87tylsnqt0.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, September 14, 2010 11:36 PM
> To: Varadarajan, Charulatha
> Cc: tony@atomide.com; wim@iguana.be; linux-watchdog@vger.kernel.org;
> paul@pwsan.com; Cousson, Benoit; Nayak, Rajendra; Basak, Partha; linux-
> omap@vger.kernel.org
> Subject: Re: [v4 4/6] OMAP4: hwmod data: Add watchdog timer
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> > From: Benoit Cousson <b-cousson@ti.com>
> >
> > Add watchdog timer hwmod data for OMAP4 chip
> >
> > This patch is extracted from the below patch sent by Benoit
> > OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
> > https://patchwork.kernel.org/patch/99052/
> 
> Minor nit: the above paragraph is better to put after the '---' as it is
> useful for the reviewers/maintainers, but doesn't need to go in the
> final commit log.
> 

Point noted. This comment is addressed in the v5 version of patch series.

-Charulatha

> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68
> ++++++++++++++++++++++++++++
> >  1 files changed, 68 insertions(+), 0 deletions(-)
> >
