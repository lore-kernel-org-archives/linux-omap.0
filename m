From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization from board files.
Date: Fri, 22 Oct 2010 09:37:36 -0700
Message-ID: <87pqv29oa7.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-10-git-send-email-thara@ti.com>
	<87aamgpc5e.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57664 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab0JVQhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:37:39 -0400
Received: by pvb32 with SMTP id 32so183600pvb.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:37:39 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAC@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 22 Oct 2010 20:13:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>> This patch enables smartreflex class3 functionality for OMAP3430SDP,
>>>> OMAP3630SDP, ZOOM2 and ZOOM3 boards.
>>>
>>>This patch doesn't touch 3630sdp.
>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>I'm having some doubts about whether this should be done by board files or
>>>not.  Seems like the general case will be that by default will be SoC
>>>specific, and only boards that want something other than the default
>>>class should need to override this.
>>>
>>>Thoughts?
>
> I agree. I wanted this to be a default initcall and one to enable the
> menuconfig option for the required class driver.. But Nishant wanted
> this from board files. 

And I want both.  :)

> If we have consensus in removing this init from board file, I am cool
> with it.

I want to suport a kernel that could be built with all possible classes
supported.  e.g. an omap3/4 kernel that has both class 1.5 and class 3
support.

If both are enabled in Kconfig, then either could be used.  We'll have
to pick one as the default initcall (e.g. highest class present), but if
a board file chooses to call a different one, that should override the
default one.

Kevin
