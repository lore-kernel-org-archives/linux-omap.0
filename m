From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: Re: [PATCH v4] drivers: video: use module_platform_driver_probe()
Date: Thu, 4 Apr 2013 13:38:49 +0200
Message-ID: <CAHkwnC_AAJ5bcoH0=Zq8vVufKXqwC4WVtc9wY01h07FbZveGeg@mail.gmail.com>
References: <1363352558-6275-1-git-send-email-fabio.porcedda@gmail.com> <515AB113.6030700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:50074 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759178Ab3DDLjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 07:39:10 -0400
In-Reply-To: <515AB113.6030700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Tue, Apr 2, 2013 at 12:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-03-15 15:02, Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com> # atmel_lcdfb.c
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> # amifb.c
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>
>> Notes:
>>     v4:
>>      - add acked-by Nicolas & Laurent
>>      - fix amifb.c
>>     v3:
>>      - add missing drivers: amifb, atmel_lcdfb, vrfb
>>      - split patch set to each maintainer to easy up respin
>>     v2:
>>      - rebased over linux-next and remove already converted drivers
>>
>>  drivers/video/amifb.c          | 14 +-------------
>>  drivers/video/atmel_lcdfb.c    | 13 +------------
>>  drivers/video/omap2/vrfb.c     | 13 +------------
>>  drivers/video/sh_mipi_dsi.c    | 12 +-----------
>>  drivers/video/sh_mobile_hdmi.c | 12 +-----------
>>  5 files changed, 5 insertions(+), 59 deletions(-)
>
> Thanks, applied to fbdev branch.

Thanks for taking it.
I don't see this patch neither in linux-next nor in
git://gitorious.org/linux-omap-dss2/linux.git,
in which repository/branch is it?

Regards
--
Fabio Porcedda

>  Tomi
>
>
