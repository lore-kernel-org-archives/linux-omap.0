From: Sathya Prakash <a0393677@ti.com>
Subject: Re: [PATCH 1/1] OMAPDSS: Add sil9022 driver
Date: Tue, 9 Jul 2013 16:26:52 +0530
Message-ID: <51DBEC74.70406@ti.com>
References: <1373360825-25170-1-git-send-email-sathyap@ti.com> <CAGm1_kuVLrTPS2TYw=TRWOppbY4HW0tpYUJzWqyv7MapJTL-_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60307 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3GIK45 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 06:56:57 -0400
In-Reply-To: <CAGm1_kuVLrTPS2TYw=TRWOppbY4HW0tpYUJzWqyv7MapJTL-_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Srinivas Pulukuru <srinivas.pulukuru@ti.com>

Hi,

On Tuesday 09 July 2013 03:07 PM, Yegor Yefremov wrote:
> On Tue, Jul 9, 2013 at 11:07 AM, Sathya Prakash M R <sathyap@ti.com> wrote:
>> From: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
>>
>> Add driver for SIL9022 DPI-to-HDMI chip.
>>
>> Signed-off-by: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
>> [sathyap@ti.com: Ported the driver from 2.6.32 based internal
>> kernel to v3.10 kernel]
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> ---
>> This patch was tested using the legacy OMAP3630 based Zoom3 platform.
>> There is no DT support for Zoom , hence board file changes
>> made locally were used for validation purpose.
>> Further, DT support will be added for a newer SOC which uses
>> the sil9022 HDMI interface chip.
>>
>>   drivers/video/omap2/displays/Kconfig         |    8 +
>>   drivers/video/omap2/displays/Makefile        |    1 +
>>   drivers/video/omap2/displays/panel-sil9022.c | 1274 ++++++++++++++++++++++++++
>>   drivers/video/omap2/displays/panel-sil9022.h |  527 +++++++++++
>>   4 files changed, 1810 insertions(+)
>>   create mode 100644 drivers/video/omap2/displays/panel-sil9022.c
>>   create mode 100644 drivers/video/omap2/displays/panel-sil9022.h
> What about making this driver more general. We've tested this HDMI
> chip on am335x and there are also Freescal based devices using this
> chip (http://www.genesi-tech.com/products/efika and kernel repo
> http://github.com/genesi/linux-legacy).
Currently the panel driver is tied to the OMAPDSS and hence making
this driver more generic is a difficult job.
But the Common Display Framework (CDF) will surely help us in future
to get drivers like this easy to port across different platforms.
In the future, will make this driver part of CDF to help in making it 
more general.
Regards,
  Sathya Prakash M R
> Yegor

