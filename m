From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
Date: Wed, 16 Jun 2010 17:25:36 -0700
Message-ID: <87vd9isdxb.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54489 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab0FQAZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:25:39 -0400
Received: by pxi8 with SMTP id 8so4197356pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:25:39 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com> (Partha Basak's message of "Wed\, 16 Jun 2010 20\:09\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Basak, Partha" <p-basak2@ti.com> writes:

> I wanted to close on the introduction of two new OMAP device APIs
> omap_device_enable_wakeup () & omap_device_disable_wakeup() in
> omap_device layer.
>
> These APIs are potentially needed by the USB driver (via function
> pointers) to work around some USB erratum.
>
> Alternatively, can we call omap_hwmod_enable_wakeup() via function
> pointer?  Is it agreeable to call these from driver code (via
> function pointers)in some special cases such as to handle some
> errata?

Hi Partha,

First, we need to dig up the Errata details for that USB problem to
better understand the USB-specific issue.

In addition, Paul and I discussed the option of automatically managing
the wakeup during the hwmod enable/idle, since there isn't really a
need to have the wakeup enabled when the hwmod is active.

Do you see any disadvantages to that?  That would be much cleaner than
manually managing the wakeup feature per-driver.

Kevin
