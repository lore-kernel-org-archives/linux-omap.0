From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 07/22] gpio/omap: avoid cpu checks during module ena/disable
Date: Tue, 23 Aug 2011 18:27:12 +0530
Message-ID: <4E53A3A8.3040506@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:50172 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754980Ab1HWM5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:57:19 -0400
Received: by mail-gw0-f54.google.com with SMTP id 15so66779gwb.13
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:57:18 -0700 (PDT)
In-Reply-To: <1312455893-14922-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
> request/free.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---

Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
