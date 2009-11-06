From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] Regulator: Renaming the supplies used in MMC driver
Date: Fri, 6 Nov 2009 15:12:04 +0000
Message-ID: <20091106151204.GD27699@rakim.wolfsonmicro.main>
References: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
 <f870da180911051317r7693dce2l8e6a345d2055198@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E302@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45691 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757587AbZKFPMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 10:12:00 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E302@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Fri, Nov 06, 2009 at 11:21:14AM +0530, Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] This was done to have the same naming conventions across
> the board. I could not find an extra "v" in supply names except MMC.
> Hence modified this. Regulator supply names should be simple and easy to
> understand.
> I can revert this change or change the dependent board files for SDP/LDP
> etc. What do you suggest?

These names normally come from the names of the supplies in the
datasheets for the consumer devices rather than the names of the rails
on the boards - those would normally be specified as the names in the
constraints where they are used for display purposes.
