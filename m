From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 15:02:06 -0600
Message-ID: <4CE6E5CE.7010502@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-9-git-send-email-nm@ti.com>	<87eiahckba.fsf@deeprootsystems.com>	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>	<4CE6B2D4.1030201@ti.com>	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>	<877hg9ayox.fsf@deeprootsystems.com> <4CE6DB9E.9000708@ti.com> <87y68p3uee.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34208 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755747Ab0KSVCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 16:02:10 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so481532vws.12
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 13:02:10 -0800 (PST)
In-Reply-To: <87y68p3uee.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 11/19/2010 02:55 PM, the following:
[...]
> Now, based on what you say below, it seems like there is no way to
> guarantee that SMIs don't do this, so I guess we have no choice but to
> protect them all.
In that way, I do like the patch from Santosh - with the relevant 
changes we will need to incorporate. Do keep in mind that SMI is a 
secure service - In theory, there could be(and to my knowledge, are) 
custom secure services to do all kind of other things that are not power 
management related[1] - The only area we can protect is the one in idle/ 
power paths.


[..]

Ref:
[1]http://groups.google.com/group/pandaboard/browse_thread/thread/b9a28cab32e10fd2/067acd6b61c1e9fa
-- 
Regards,
Nishanth Menon
