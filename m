From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Tue, 05 Oct 2010 15:00:21 +0400
Message-ID: <4CAB0545.5060309@ru.mvista.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>	<20101001213532.1408.55832.stgit@twilight.localdomain>	<4CA999AA.4030608@ti.com> <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41205 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828Ab0JELCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 07:02:07 -0400
Received: by ewy23 with SMTP id 23so2412409ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 04:02:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello.

On 04-10-2010 23:15, Paul Walmsley wrote:

>>> --- /dev/null
>>> +++ b/arch/arm/plat-omap/32ksynctimer.c
>>> @@ -0,0 +1,184 @@
>>> +/*
>>> + * linux/arch/arm/plat-omap/clocksource.c

>> What name do you want to use? 32ksynctimer.c or clocksource.c?

> Thanks, that's a bug.

    And also note that filenames in heading comments have been long discouraged.

WBR, Sergei
