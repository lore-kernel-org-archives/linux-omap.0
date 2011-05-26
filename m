From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 08/15] OMAP2+: GPIO: make workaround_enabled bank specific
Date: Thu, 26 May 2011 15:07:07 +0530
Message-ID: <BANLkTi=sw1Dc5hP+VqGu1f9aci4WhXfz=g@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-9-git-send-email-tarun.kanti@ti.com> <874o4ipfqw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55575 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757207Ab1EZJhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:37:48 -0400
Received: by pzk1 with SMTP id 1so275030pzk.2
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:37:47 -0700 (PDT)
In-Reply-To: <874o4ipfqw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, May 26, 2011 at 04:09, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Make workaround_enabled flag bank-specific instead of using a single
>> flag for all the banks together. This would be helpful while making
>> use of runtime framework in OMAP GPIO driver which would make the
>> driver handle each GPIO bank independently.
>>
>> Also rename workaround_enabled flag to off_mode_wkup_wa_enabled
>
> Do we even need a dedicated flag for this?
>
> I seems that the combination of enabled_non_wakeup_gpios and whether or
> not context has been lost could be used to check this condition.

Okay, will check and do the needful.

>
> Kevin
>
