From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Wed, 30 Jun 2010 13:38:56 -0700
Message-ID: <87ocesjlwf.fsf@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
	<1277423084-25528-11-git-send-email-khilman@deeprootsystems.com>
	<87y6dxrblk.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323763838@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39581 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab0F3UjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 16:39:00 -0400
Received: by pwj8 with SMTP id 8so431226pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 13:38:59 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323763838@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Wed, 30 Jun 2010 09:48:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>+static int __init omap_common_pm_init(void)
>>>+{
>>>+	omap_init_processor_devices();
>>>+	omap_pm_if_init();
>>>+
>>>+	return 0;
>>>+}
>>>+device_initcall(omap_common_pm_init);

>
> But I guess opp layer is still getting initialized before this. Esp if
> the board files are initializing the opp structures. Or do you have a
> patch to fix it in some other branch ?
>

The common OPP init will be done in this function as well (see current
PM branch.)  Board files no longer do OPP init (by default) as it is
handled by common code.  Only boards that add OPPs need to call the init
function, and we'll have to figure out way to handle that late.

Kevin

