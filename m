From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform device
Date: Tue, 10 Aug 2010 10:59:55 -0700
Message-ID: <87y6ce5ox0.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
	<878w4ffkth.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:34119 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab0HJR77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 13:59:59 -0400
Received: by pxi10 with SMTP id 10so175477pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 10:59:58 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
	(Partha Basak's message of "Tue, 10 Aug 2010 17:23:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

>> Instead, please propose an API to hwmod for getting the optional
>> clock(s), or possibly cleaner, an API to directly enable/disable
>> optional clocks for an omap_device.
>
> As per our discussion with Paul & you during workshop, I believe,
> optional clock control should be done using clock APIs. So, I would go
> by your suggestion 1 of exposing an API to expose the optional clocks
> in the hwmod, something like: 
>
> struct omap_hwmod_opt_clk * omap_hwmod_get_opt_clks(struct omap_hwmod
> *oh); 
>
> If agreed, Charu will send updated patch.

OK with me.


