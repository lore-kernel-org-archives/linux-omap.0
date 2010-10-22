From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 03/11] OMAP3: PM: Adding smartreflex driver support.
Date: Fri, 22 Oct 2010 09:17:20 -0700
Message-ID: <87vd4ucicv.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-4-git-send-email-thara@ti.com>
	<87lj61tzaz.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95E9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48268 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0JVQRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:17:25 -0400
Received: by pwj3 with SMTP id 3so313748pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:17:25 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95E9C@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 22 Oct 2010 19:51:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
>>>
>>>as an internal function, to be consistent with other naming, this should
>>>be sr_remove.
>
> It is omap_smartreflex_probe and remove. Do you prefer omap_sr_probe
> and omap_sr_remove?

Yes

