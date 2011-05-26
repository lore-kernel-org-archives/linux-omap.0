From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank structure
Date: Thu, 26 May 2011 15:37:55 +0530
Message-ID: <BANLkTim49A1DYga62_Ys1=6+UPCSh=YW1w@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-6-git-send-email-tarun.kanti@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D178021@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:60389 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753446Ab1EZKIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 06:08:36 -0400
Received: by pwj8 with SMTP id 8so328891pwj.41
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:08:35 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D178021@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 26, 2011 at 15:28, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> DebBarma, Tarun Kanti
>> Sent: Tuesday, May 24, 2011 7:55 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Varadarajan, Charulatha
>> Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of
>> gpio_bank structure
>>
>> From: Charulatha V <charu@ti.com>
>>
>> gpio_context array, which is used to save gpio bank's context,
>> is used only for OMAP3 architecture.
>>
>> Move gpio_context as part of gpio_bank structure so that
>> it can be specific to each gpio bank and can be used for
>> any OMAP architecture
>>
>> TODO: extend the gpio save/restore context function for OMAP4
>> architecture. This is done in one of the next patches in this
>> series
>
> [sp] Should this TODO be part of commit?

Probably this could be moved into diff section.

<<<snip>>
