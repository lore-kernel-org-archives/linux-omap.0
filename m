From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH] omap: tidspbridge: fix build failure on MEMBLOCK_REAL_LIMIT
Date: Tue, 2 Nov 2010 10:10:43 -0400
Message-ID: <AANLkTimagFyRo5a3f7u2TV5a0vyyz5bq1tSfdtcKz0rW@mail.gmail.com>
References: <1288704660-21683-1-git-send-email-gadiyar@ti.com> <AANLkTi=fGA__ZXHOUz-VH5dhq7jWG7ZuPOzPdrN7xBM+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47164 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0KBOLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 10:11:05 -0400
Received: by mail-wy0-f176.google.com with SMTP id 36so7328361wyg.21
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 07:11:04 -0700 (PDT)
In-Reply-To: <AANLkTi=fGA__ZXHOUz-VH5dhq7jWG7ZuPOzPdrN7xBM+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 2, 2010 at 10:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Nov 2, 2010 at 3:31 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
>> MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
>> (memblock: Introduce default allocation limit and use it to replace
>> explicit ones). This breaks build as below when CONFIG_TIDSPBRIDGE
>> is selected. Fix this.
>
> I would rather apply this:
> http://article.gmane.org/gmane.linux.ports.arm.omap/45076
>

Okay, I hadn't seen that one. Thanks!

- Anand
