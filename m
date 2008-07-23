From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/2] Add clock post-rate-change notifier
Date: Tue, 22 Jul 2008 23:09:34 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807222307500.25059@utopia.booyaka.com>
References: <20080620231155.21640.89851.stgit@localhost.localdomain> <000001c8eb1f$787c8880$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59060 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbYGWFJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 01:09:35 -0400
In-Reply-To: <000001c8eb1f$787c8880$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

On Mon, 21 Jul 2008, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, June 21, 2008 4:44 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 0/2] Add clock post-rate-change notifier
> > 
> > 
> > This series adds a clock rate change notifier to the OMAP clock
> > framework.  Currently only post-rate-change notification is
> > implemented, although pre-rate-change notification is in the works.
> 
> Was there any patch set posted after this with pre-rate change notifications
> support?

No, it isn't quite ready yet.  Will try to prioritize it for your use.  
But, see below...

> I am currently working on CPUFreq patches and CPUFreq requires a pre notification 
> to be able to update jiffies/BogoMips.

Could you explain further what you're trying to do?  For example, in the 
interim, would it be possible to create a custom set_rate function for 
mpu_ck that would call the existing CPUFreq pre-rate-change notifier?

- Paul
