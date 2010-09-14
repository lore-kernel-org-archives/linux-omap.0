From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 8/8] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Tue, 14 Sep 2010 09:05:41 -0700
Message-ID: <87tylss42y.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-9-git-send-email-thara@ti.com>
	<87lj7vk1p2.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0329441CD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32968 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0INQFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 12:05:46 -0400
Received: by pzk34 with SMTP id 34so2480144pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 09:05:46 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0329441CD8@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Tue, 14 Sep 2010 20:28:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +#ifdef CONFIG_PM_DEBUG
>>>> +   voltage_dir = debugfs_create_dir("voltage", pm_dbg_main_dir);
>>>> +#endif
>>>
>>>This also depends on CONFIG_DEBUG_FS.
>
> Shouldn't CONFIG_PM_DEBUG depend on CONFIG_DEBUG_FS??
>

No.  There are plenty of PM debug features that don't use debugfs.

Kevin
