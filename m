From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
Date: Thu, 22 Sep 2011 11:39:13 +0530
Message-ID: <CAC83Zv+aFu6u7TezD0NA3UHf9DMtW0AsP15jB1FFn8avEwY7CQ@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<20110922005930.GN2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42673 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390Ab1IVGJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 02:09:15 -0400
Received: by mail-bw0-f52.google.com with SMTP id 5so3728959bke.39
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 23:09:14 -0700 (PDT)
In-Reply-To: <20110922005930.GN2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Sep 22, 2011 at 6:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Tarun,
>
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> Adaptation of dmtimer code to platform driver using omap_device and
>> omap_hwmod abstraction. It also include pm-runtime and off-mode support.
>
> I've applied these into dmtimer branch with some changes to simplify
> things further. I've also merged it into linux-omap master branch
> for further testing.
>
> I'll reply to your patches with the changes I've done. Care give the
> dmtimer branch a try and see if I've missed something?
Sure, I will go through the changes and do testing on it.
--
Tarun
>
> Regards,
>
> Tony
>
