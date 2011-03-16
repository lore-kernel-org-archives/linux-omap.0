From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: remove unused power regulators
Date: Wed, 16 Mar 2011 17:28:29 +0200
Message-ID: <20110316172829.5a1a3084.jhnikula@gmail.com>
References: <1300216227-21138-1-git-send-email-x0132446@ti.com>
	<4D7FBA82.40403@linaro.org>
	<AANLkTing6jerp4mVgVDkW7eTu9LPgwRNAR9KXQPZNWcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64812 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab1CPP2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 11:28:36 -0400
Received: by bwz15 with SMTP id 15so1621226bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 08:28:35 -0700 (PDT)
In-Reply-To: <AANLkTing6jerp4mVgVDkW7eTu9LPgwRNAR9KXQPZNWcs@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: andy.green@linaro.org, David Anders <x0132446@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com

On Wed, 16 Mar 2011 10:19:41 +0100
Jean Pihet <jean.pihet@newoldbits.com> wrote:

> On Tue, Mar 15, 2011 at 8:14 PM, Andy Green <andy@warmcat.com> wrote:
> > On 03/15/2011 07:10 PM, Somebody in the thread at some point said:
> >>
> >> the pandaboard does not use the VUSIM or VAUX1 power regulators on the
> >> TWL6030
> >> and are left floating. if the VUSIM and VAUX1 power regulators are
> >> initilized,
> >> noise on the unloaded regulators generates an overcurrent interrupt
> >> causing the
> >> system to power down. this patch removes the initialization of the unused
> >> power
> >> regulators of VUSIM and VAUX1.
> >>
> >> Signed-off-by: David Anders<x0132446@ti.com>
> >
> > Acked-by: Andy Green <andy.green@linaro.org>
> >
> > Great job finding this one David.
> Great!
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>
> 
Excellent! Some of us don't need a halogen lamp anymore to run
Panda [1] :-)

And indeed, the VUSIM and VAUX1 are unused according to schematics.
Definitely 2.6.38-rc material and probably 2.6.37 stable too?

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
---
1. http://marc.info/?l=linux-omap&m=129784674528539&w=2
