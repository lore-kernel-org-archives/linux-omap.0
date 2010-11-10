From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 0/9] OMAP3: Adding Smartreflex and Voltage driver support
Date: Wed, 10 Nov 2010 11:03:00 -0800
Message-ID: <874obp80ij.fsf@deeprootsystems.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<4CC85F8F.8020705@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D5D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab0KJTDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 14:03:03 -0500
Received: by pwi9 with SMTP id 9so24058pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 11:03:03 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D5D@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 28 Oct 2010 21:02:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>
>>>Also curious should:
>>>"OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code should probably be
>>>" dropped with "OMAP3: PM: Register TWL4030 pmic info with the voltage" ?
>
> Hmm.. Last time I suggested moving the contents of this patch to
> twl-core.c Nobody seemed to much keen. Hence I retained the
> plat-omap/opp-twl-tpl.c file.  In fact "OMAP3: PM: Register TWL4030
> pmic info with the voltage" registers the params from
> plat-omap/opp-twl-tpl.c. But if we have a consensus I will just drop
> this patch and have the pmic params passed from twl-core.c.

Sounds right to me.

Kevin

