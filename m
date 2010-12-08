From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
 accessor/mutatorfunctions
Date: Wed, 8 Dec 2010 12:46:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012081243270.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain> <3407936b2b482d0f7f6b5bb273455377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57460 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab0LHTqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 14:46:32 -0500
In-Reply-To: <3407936b2b482d0f7f6b5bb273455377@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com

On Wed, 8 Dec 2010, Rajendra Nayak wrote:

> > +#include "cminst44xx.h"
> 
> This header seems to be missed in the series.

Oops, sorry about that.  Fixed in the git branch on git.pwsan.com.

Attached below is the final mach-omap2/cminst44xx.h file.  It's created by 
the first patch in this series ("OMAP4: PRCM: add OMAP4-specific 
accessor/mutator functions") and modified by the seventh patch in the 
series ("OMAP4: clockdomains: add OMAP4 PRCM data and OMAP4 support")
I will repost those.


- Paul
