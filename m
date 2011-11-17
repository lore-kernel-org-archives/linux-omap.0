From: Omar Ramirez Luna <or.rmz1@gmail.com>
Subject: Re: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Wed, 16 Nov 2011 18:53:33 -0600
Message-ID: <CAPTm=KHxSvyCb4i02vnuU9Wz-0j3h+h_UvDc0An5mwb2472dPg@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
	<CAPTm=KGDEKGxLpJt0t6k_NL5Wz81NkMmRJ+OkmyvHedd6_exgQ@mail.gmail.com>
	<CAC83ZvJSev97waAOuzoJsFTX4vmeVFxkg6BzpjQm+Tjo3cbhpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36840 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab1KQAxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 19:53:35 -0500
Received: by eye27 with SMTP id 27so1210525eye.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 16:53:34 -0800 (PST)
In-Reply-To: <CAC83ZvJSev97waAOuzoJsFTX4vmeVFxkg6BzpjQm+Tjo3cbhpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, Nov 16, 2011 at 12:18 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
...
>> My use case is as follows:
>>
>> DSP sends a mailbox message to ARM, this triggers a tasklet in mailbox
>> for processing the message, when it reaches tidspbridge it turns out
>> that the DSP wants to enable a gpt timer; however, locks involved
>> "clocks_mutex" and "dm_timer_lock" now could cause a deadlock as they
>> have been called from unsafe contexts in the past
>> (http://pastebin.com/7Dtz8t0f).
>>
>> Is the intention to restrict enabling the dmtimer clocks from hard|soft irqs?
> The aim is to prevent client drivers perform clock enable/disable independently.
> Instead just use the request/start/stop APIs. In that way we can make clock
> enable/disable functions static in the future.

Those are the APIs I'm using, omap_dm_timer_request_specific from a
softirq triggers this warning, this was not hinted by the patch or
cover letter of the series, hence the question:

Was this change intentional? Does omap_dm_timer_request_specific
should be allowed on other contexts (soft|hard irq)?

...
> You are right. This change some how got missed in mainline.
> I have posted a patch for this already.

Ok.

Regards,

Omar
