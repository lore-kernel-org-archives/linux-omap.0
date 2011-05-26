From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore
Date: Thu, 26 May 2011 15:06:55 +0530
Message-ID: <BANLkTimS7XbGQ6sn-uPagq_FuvxopibYfg@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-12-git-send-email-tarun.kanti@ti.com> <871uzmo05l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39844 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757207Ab1EZJhg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:37:36 -0400
Received: by pwi4 with SMTP id 4so361410pwi.39
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:37:35 -0700 (PDT)
In-Reply-To: <871uzmo05l.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, May 26, 2011 at 04:31, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> It is not required to use hard-coded offsets any more in context
>> save and restore functions and instead use the generic offsets
>> which have been correctly initialized during device registration.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> Looks good.
>
> I suggest you move this and all the other patches that just change to using
> regsister offsets earlier in the series.

okay.

>
> Kevin
>
