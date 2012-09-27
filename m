From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 28 Sep 2012 02:03:13 +0530
Message-ID: <CAMQu2gzMKnm25ve6dWxMiLKQEoqDQE6535kXbuh38FCsy8O+9w@mail.gmail.com>
References: <20120920232907.GN28835@atomide.com> <20120927202615.GS4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55196 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753304Ab2I0Udk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 16:33:40 -0400
Received: by qcse13 with SMTP id e13so3369000qcs.1
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 13:33:34 -0700 (PDT)
In-Reply-To: <20120927202615.GS4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>, Felipe Balbi <balbi@ti.com>, Jon Hunter <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Lokesh Vutla <lokeshvutla@ti.com>

On Fri, Sep 28, 2012 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Please see below a status update on the remaining problem
> plat headers.
>
> Note that all patches should be against current linux next
> in this case.
>
> * Tony Lindgren <tony@atomide.com> [120920 16:30]:
> >
> > $ ls arch/arm/plat-omap/include/plat/

[..]

> omap-secure.h

Will work with Lokesh to get this one sorted out along with
dma. It can be made local to mach-omap2.

Regards
Santosh
