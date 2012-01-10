From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Tue, 10 Jan 2012 07:19:18 -0800
Message-ID: <87pqertwjt.fsf@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	<1323444589-19940-5-git-send-email-t-kristo@ti.com>
	<871ur8weds.fsf@ti.com>
	<20120110033012.GM30766@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33230 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756349Ab2AJPTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 10:19:21 -0500
Received: by mail-yw0-f41.google.com with SMTP id o21so1579678yho.14
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 07:19:20 -0800 (PST)
In-Reply-To: <20120110033012.GM30766@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Tue, 10 Jan 2012 03:30:12 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Jan 09, 2012 at 05:11:11PM -0800, Kevin Hilman wrote:
>
>> Seems to me like the get/set override should be more generic (part of
>> regulator core) instead of TWL specific?
>
>> Otherwise, whenever someone hooks up a non-TWL regulator to an OMAP and
>> is using HW control (via VC/VP), they'll have to duplicate all of this
>> stuff in their regulator driver?
>
> Frankly I'm not sure I understand how the hardware is supposed to work
> here - originally the plan was to just add a new regulator driver for
> the hardware control block which is I guess clean enough but it seems
> like some of the other control still goes via the normal path.

Yes, some of the control still goes via the normal path (although I
forget which, maybe Benoit can remind us), so I think it's best to add
the HW control part to each regulator that might uses it.

Ideally this could be facilitated by adding the extentions to the
regulator core so the amount of code needed for each regulator driver
would be minimal.

Kevin
