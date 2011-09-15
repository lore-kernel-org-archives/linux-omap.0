From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Thu, 15 Sep 2011 22:56:15 +0530
Message-ID: <CAMQu2gx8beDSziPDkc9Lut67VfLxYfhUnZmrcmHRQNaEhu6QUg@mail.gmail.com>
References: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com> <20110915170203.GJ32263@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56281 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756583Ab1IOR0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 13:26:36 -0400
Received: by mail-yw0-f50.google.com with SMTP id 13so2761287ywm.37
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 10:26:35 -0700 (PDT)
In-Reply-To: <20110915170203.GJ32263@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 15, 2011 at 10:32 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Santosh,
>
> On Tue, Sep 06, 2011 at 09:29:30PM +0530, Santosh Shilimkar wrote:
>> TWL6030 devices have an interrupt line which is connected to
>> application processor like OMAP. These devices support multiple features
>> such as MMC card detect, USB cable detect, RTC interrupt, etc. that must
>> wake up the application processor.
>>
>> With this change, TWL6030 client drivers can make use of
>> irq_wake() if the wakeup is desirable on it's irq events.
> Patch applied to my for-next branch, thanks.
>
Thanks Samuel.

Regards
Santosh
