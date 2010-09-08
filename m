From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 2/2] OMAP:DSS: RFC Patch to add HDMI DSS driver support
Date: Wed, 08 Sep 2010 11:31:38 +0300
Message-ID: <1283934698.13006.4.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB4@dbde02.ent.ti.com>
	 <1283865397.2363.110.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706C5776EFE@dbde02.ent.ti.com>
	 <1283867099.2363.114.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706C5776FEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:21464 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758452Ab0IHIbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Sep 2010 04:31:44 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706C5776FEB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-08 at 06:46 +0200, ext K, Mythri P wrote:
> Hi Tomi,

> > > I have introduced these in the display.h , do you suggest adding
> > prefix like omapdss_hdmi* for all these functions ?
> > 
> > Neither of the two HDMI patches you sent modify display.h...
> > 
> > Yes, if you export functions from DSS they should be prefixed, as
> > they
> > are global functions.
> > 
> I shall correct the function names.
> Yes this is just a RFC patch to introduce the HDMI driver and panel as such, if you have no other comments on these 2 patch set I shall incorporate these comments and send out the complete patch series with all the relevant changes in display.h and some overlay.c and manager.c changes.

Please don't send incomplete patch sets. It's a waste of reviewer's time
to try to review patches that are missing components, or are based on
custom kernel. Also make sure checkpatch.pl doesn't give any (or just a
few) warnings/errors.

Or, if you really want to send an incomplete RFC patch set with errors,
make it very clear in the introduction.

 Tomi


