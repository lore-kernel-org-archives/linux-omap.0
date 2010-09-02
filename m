From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/13] OMAP: Introduce device specific set rate and get rate in device opp structures.
Date: Thu, 02 Sep 2010 16:41:36 -0700
Message-ID: <87fwxrzpan.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-6-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43547 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab0IBXlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 19:41:39 -0400
Received: by pzk9 with SMTP id 9so374559pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Sep 2010 16:41:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch extends the device opp structure to contain
> pointers to scale the operating rate of the
> device and to retrieve the operating rate of the device.
> This patch also adds the three new APIs in the opp layer
> namely opp_set_rate that can be called to set a new operating
> rate for a device, opp_get_rate that can be called to retrieve
> the operating frequency for a device and opp_populate_rate_fns
> to populte the device specific set_rate and get_rate API's.
> The opp_set_rate and opp_get_rate does some routine error
> checks and finally calls into the device specific set_rate
> and get_rate APIs populated through opp_populate_rate_fns.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

As I think about this more, I'm not sure the OPP layer is the right
layer for the get/set rate functions.  The OPP layer is currently just
the data store for OPP data. To me, these set/get functions are better
associated directly with an omap_device instead of an OPP.

For instance, the new OPP APIs are a bit confusing in terms of OPPs.
e.g: opp_get_rate().  What is the "rate" of an OPP, and what's the
difference with opp_get_freq()?

What's really happening is the rate is being changed for a device, and
the need for specific hooks are at the device level, not the OPP level.
For example, this current approach would not scale if you needed
multiple devices in the same domain that each needed custom
set_rate/get_rate hooks.

So instead, what about adding custom hooks at the omap_device level?
They could be registered at omap_device_build() time in the device
specific code.

Kevin
