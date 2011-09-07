From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 20/25] gpio/omap: skip operations in runtime callbacks
Date: Wed, 7 Sep 2011 11:03:58 +0530
Message-ID: <CAC83Zv+OoysGwzGqydFkCd6y4aRr-67LUcpMBfyuZiYqkhJzOw@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-21-git-send-email-tarun.kanti@ti.com>
	<87ty8pw7jm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:36172 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754015Ab1IGFeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 01:34:00 -0400
Received: by mail-bw0-f43.google.com with SMTP id zv15so8851230bkb.16
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 22:33:58 -0700 (PDT)
In-Reply-To: <87ty8pw7jm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, Sep 7, 2011 at 5:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Most operations within runtime callbacks should be skipped when
>> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
>> *_gpio_request() and *_gpio_free().
>
> Why?
>
> (again, I know the answer, but should be described in the changelog for
> folks not familiar with this driver, or when we come back to this in 3
> months and have forgotten why.
Ok.

>
>> We just need clock enable/disable.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Kevin
>
