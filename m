From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache
 operation
Date: Wed, 05 Aug 2009 05:58:24 +0300 (EEST)
Message-ID: <20090805.055824.28805142.Hiroshi.DOYU@nokia.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<27F9C60D11D683428E133F85D2BB4A5304193E7C55@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48627 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284AbZHEC6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 22:58:32 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5304193E7C55@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, ameya.palande@nokia.com, x0095840@ti.com, h-kanigeri2@ti.com

From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache operation
Date: Tue, 4 Aug 2009 23:59:37 +0200

> Hi Doyu-san,
> 
> >From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> >Sent: Wednesday, July 22, 2009 3:23 AM
> >To: linux-omap@vger.kernel.org
> >Cc: Menon, Nishanth; ameya.palande@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Kanigeri,
> >Hari; Hiroshi DOYU
> >Subject: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache operation
> >
> >Check if the given area blongs to process virtul memory address space.
> >
> >Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >---
> > drivers/dsp/bridge/rmgr/proc.c |   32 ++++++++++++++++++++++++++++++++
> > 1 files changed, 32 insertions(+), 0 deletions(-)
> >
> 
> Is this patch solving any specific issue?

Without this patch, there's quite serious risk that usreland
applications can cause kernel crash on purpose.

For exmaple, if you set NULL for "pMpuAddr", it always hits kernel
oops at v7_dma_*().

It's same to any other address which doesn't belong to the process
VMAs.

