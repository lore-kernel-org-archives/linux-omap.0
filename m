From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH RFT] regulator: twl: Fix list_voltate for twl6030ldo_ops
Date: Mon, 16 Jul 2012 17:41:46 +0530
Message-ID: <50040502.30603@ti.com>
References: <1342434670.4717.6.camel@phoenix> <50040440.80703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:34947 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2GPMLy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 08:11:54 -0400
Received: by yenq11 with SMTP id q11so8917809yen.16
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 05:11:52 -0700 (PDT)
In-Reply-To: <50040440.80703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>

Sorry, I seemed to have messed up with the underlining.

On Monday 16 July 2012 05:38 PM, Rajendra Nayak wrote:
> [    0.337341] V1V8: 1800 mV normal standby
> [    0.338531] V2V1: 2100 mV normal standby
> [    0.339813] VMMC: 1200 <--> 3000 mV at 3100 mV normal standby
>                      ^^^^^^^^

I meant 3100 mV normal standby was wrong.

> [    0.341278] VPP: 1800 <--> 2500 mV at 2000 mV normal standby
>                      ^^^^^^^^^

2000 mV being wrong here.

> [    0.343505] VCXIO: 1800 mV normal standby
> [    0.343597] VCXIO: supplied by V2V1
> [    0.345855] VDAC: 1800 mV normal standby
> [    0.345947] VDAC: supplied by V2V1
> [    0.347717] VAUX2_6030: 1200 <--> 2800 mV at 1900 mV normal standby
>                          ^^^^^^^^

1900 mV here..

> [    0.349212] VAUX3_6030: 1000 <--> 3000 mV at 1300 mV normal standby
>                          ^^^^^^^^

and 1300 mV here.

