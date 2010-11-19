From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 13:09:36 -0800
Message-ID: <87sjyx2f73.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-9-git-send-email-nm@ti.com>
	<87eiahckba.fsf@deeprootsystems.com>
	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
	<4CE6B2D4.1030201@ti.com>
	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
	<877hg9ayox.fsf@deeprootsystems.com> <4CE6DB9E.9000708@ti.com>
	<87y68p3uee.fsf@deeprootsystems.com> <4CE6E5CE.7010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36108 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab0KSVJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 16:09:40 -0500
Received: by yxf34 with SMTP id 34so3010133yxf.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 13:09:40 -0800 (PST)
In-Reply-To: <4CE6E5CE.7010502@ti.com> (Nishanth Menon's message of "Fri, 19
	Nov 2010 15:02:06 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 11/19/2010 02:55 PM, the following:
> [...]
>> Now, based on what you say below, it seems like there is no way to
>> guarantee that SMIs don't do this, so I guess we have no choice but to
>> protect them all.
> In that way, I do like the patch from Santosh - with the relevant
> changes we will need to incorporate. Do keep in mind that SMI is a
> secure service - In theory, there could be(and to my knowledge, are)
> custom secure services to do all kind of other things that are not
> power management related[1] - 

All the more reason that this secure mode code should be moved out of
the core idle path into its own driver.

Kevin

> The only area we can protect is the one in idle/ power paths.

