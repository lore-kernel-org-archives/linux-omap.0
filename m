From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 06/15] OMAP4: GPIO: Save/restore context
Date: Thu, 26 May 2011 15:07:40 +0530
Message-ID: <BANLkTi=xAUpL9tfnY_JScjoBK2eZf2tYsg@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-7-git-send-email-tarun.kanti@ti.com> <8739k2sbg0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35379 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756902Ab1EZJi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:38:29 -0400
Received: by pvf33 with SMTP id 33so230783pvf.38
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:38:28 -0700 (PDT)
In-Reply-To: <8739k2sbg0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Kevin,

Thanks for the comments on this series.

On Thu, May 26, 2011 at 03:13, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Modify the omap_gpio_save/restore_context to support OMAP4
>> architecture so that the OMAP GPIO driver need not be modified
>> when OMAP4 off mode support is available.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> I don't think this patch is needed.
>
> PATCH 11/15 removes everything added in this patch when it moves to
> using the register offsets.

Okay.

>
> Kevin
>
