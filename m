From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Tue, 10 Jan 2012 03:30:12 +0000
Message-ID: <20120110033012.GM30766@opensource.wolfsonmicro.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com> <1323444589-19940-5-git-send-email-t-kristo@ti.com> <871ur8weds.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40356 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755996Ab2AJDaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 22:30:14 -0500
Content-Disposition: inline
In-Reply-To: <871ur8weds.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Jan 09, 2012 at 05:11:11PM -0800, Kevin Hilman wrote:

> Seems to me like the get/set override should be more generic (part of
> regulator core) instead of TWL specific?

> Otherwise, whenever someone hooks up a non-TWL regulator to an OMAP and
> is using HW control (via VC/VP), they'll have to duplicate all of this
> stuff in their regulator driver?

Frankly I'm not sure I understand how the hardware is supposed to work
here - originally the plan was to just add a new regulator driver for
the hardware control block which is I guess clean enough but it seems
like some of the other control still goes via the normal path.
