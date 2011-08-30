From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH v2 5/6] TI81XX: Add minimal hwmod data
Date: Mon, 29 Aug 2011 17:32:54 -0700
Message-ID: <87ty8zoi15.fsf@ti.com>
References: <1314119627-23088-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58721 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab1H3Ac6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 20:32:58 -0400
Received: by mail-pz0-f49.google.com with SMTP id 6so11006251pzk.22
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 17:32:58 -0700 (PDT)
In-Reply-To: <1314119627-23088-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Tue, 23 Aug 2011 22:43:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimum required hwmod data (e.g., UARTs) for bootup of TI81XX
> devices (currently common data for TI816X and TI814X is added).
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

I haven't looked at the details yet, but just tried to boot this using
current mainline and it fails.

My first guess is that it appears to be related to a missing clkdm for
the MPU hwmod.

Kevin
