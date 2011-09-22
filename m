From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request functions
Date: Thu, 22 Sep 2011 11:30:33 +0530
Message-ID: <CAC83Zv+W+RmnuXaMdGwBOfHYY0undQTxCTa8OgiO5P8G3Nr0tg@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
	<20110922004243.GL2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39997 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab1IVGAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 02:00:34 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so2756175bkb.40
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 23:00:33 -0700 (PDT)
In-Reply-To: <20110922004243.GL2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Sep 22, 2011 at 6:12 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> The request functions now verify the success of omap_dm_timer_prepare() call
>> after a timer is acquired. If *_prepare() fails then we have to release the
>> timer. In order to avoid race condition during this time, include *_prepare()
>> within lock.
>
> This I've folded into patch 5.
That should be fine.
--
Tarun
>
> Tony
>
