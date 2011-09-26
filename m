From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 0/2] OMAP: omap_device: Add a method to build an omap_device from a DT node
Date: Mon, 26 Sep 2011 15:38:58 -0700
Message-ID: <8762kf9bel.fsf@ti.com>
References: <1316724745-24896-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:58689 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274Ab1IZWjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 18:39:05 -0400
Received: by mail-gy0-f182.google.com with SMTP id 2so7286685gyf.27
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 15:39:02 -0700 (PDT)
In-Reply-To: <1316724745-24896-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Thu, 22 Sep 2011 22:52:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

Benoit Cousson <b-cousson@ti.com> writes:

> This is the updated version of the initial series that introduced a
> notifier in order to create an omap_device from a platform_device bound
> to DT node as suggested by Grant.

This series looks good to me.

Barring any final comments (Grant?), I'll be queueing this for 3.2 in my
omap_device queue on top of your previous cleanup series.

Kevin
