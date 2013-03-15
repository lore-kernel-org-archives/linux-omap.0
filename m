From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: Re: [PATCH v3] drivers: video: use module_platform_driver_probe()
Date: Fri, 15 Mar 2013 11:11:38 +0100
Message-ID: <CAHkwnC-WnqXQacjab9KOxkB0NeWJt_iHGSO19QYMhi9p8wOOgg@mail.gmail.com>
References: <1363338019-13092-1-git-send-email-fabio.porcedda@gmail.com> <5142E9D8.5060801@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:59691 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3COKMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 06:12:00 -0400
In-Reply-To: <5142E9D8.5060801@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Fri, Mar 15, 2013 at 10:28 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 03/15/2013 10:00 AM, Fabio Porcedda :
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> For atmel_lcdfb.c:
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Thanks Fabio.
>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---

If you prefer a patch for each driver I will split the patch.

Best regards
Fabio Porcedda

>> Notes:
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
>>
>> diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
>> index 7fa1bf8..03e2de2 100644
>> --- a/drivers/video/amifb.c
>> +++ b/drivers/video/amifb.c
>> @@ -3788,19 +3788,7 @@ static struct platform_driver amifb_driver = {
>>       },
>>  };
>>
>> -static int __init amifb_init(void)
>> -{
>> -     return platform_driver_probe(&amifb_driver, amifb_probe);
>> -}
>> -
>> -module_init(amifb_init);
>> -
>> -static void __exit amifb_exit(void)
>> -{
>> -     platform_driver_unregister(&amifb_driver);
>> -}
>> -
>> -module_exit(amifb_exit);
>> +return module_platform_driver_probe(amifb_driver, amifb_probe);
>>
>>  MODULE_LICENSE("GPL");
>>  MODULE_ALIAS("platform:amiga-video");
>> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
>> index 12cf5f3..654e102 100644
>> --- a/drivers/video/atmel_lcdfb.c
>> +++ b/drivers/video/atmel_lcdfb.c
>> @@ -1150,18 +1150,7 @@ static struct platform_driver atmel_lcdfb_driver = {
>>       },
>>  };
>>
>> -static int __init atmel_lcdfb_init(void)
>> -{
>> -     return platform_driver_probe(&atmel_lcdfb_driver, atmel_lcdfb_probe);
>> -}
>> -
>> -static void __exit atmel_lcdfb_exit(void)
>> -{
>> -     platform_driver_unregister(&atmel_lcdfb_driver);
>> -}
>> -
>> -module_init(atmel_lcdfb_init);
>> -module_exit(atmel_lcdfb_exit);
>> +module_platform_driver_probe(atmel_lcdfb_driver, atmel_lcdfb_probe);
>>
>>  MODULE_DESCRIPTION("AT91/AT32 LCD Controller framebuffer driver");
>>  MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
>> diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
>> index 10560ef..5261229 100644
>> --- a/drivers/video/omap2/vrfb.c
>> +++ b/drivers/video/omap2/vrfb.c
>> @@ -397,18 +397,7 @@ static struct platform_driver vrfb_driver = {
>>       .remove         = __exit_p(vrfb_remove),
>>  };
>>
>> -static int __init vrfb_init(void)
>> -{
>> -     return platform_driver_probe(&vrfb_driver, &vrfb_probe);
>> -}
>> -
>> -static void __exit vrfb_exit(void)
>> -{
>> -     platform_driver_unregister(&vrfb_driver);
>> -}
>> -
>> -module_init(vrfb_init);
>> -module_exit(vrfb_exit);
>> +module_platform_driver_probe(vrfb_driver, vrfb_probe);
>>
>>  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
>>  MODULE_DESCRIPTION("OMAP VRFB");
>> diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
>> index 701b461..6cad530 100644
>> --- a/drivers/video/sh_mipi_dsi.c
>> +++ b/drivers/video/sh_mipi_dsi.c
>> @@ -581,17 +581,7 @@ static struct platform_driver sh_mipi_driver = {
>>       },
>>  };
>>
>> -static int __init sh_mipi_init(void)
>> -{
>> -     return platform_driver_probe(&sh_mipi_driver, sh_mipi_probe);
>> -}
>> -module_init(sh_mipi_init);
>> -
>> -static void __exit sh_mipi_exit(void)
>> -{
>> -     platform_driver_unregister(&sh_mipi_driver);
>> -}
>> -module_exit(sh_mipi_exit);
>> +module_platform_driver_probe(sh_mipi_driver, sh_mipi_probe);
>>
>>  MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
>>  MODULE_DESCRIPTION("SuperH / ARM-shmobile MIPI DSI driver");
>> diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
>> index 930e550..bfe4728 100644
>> --- a/drivers/video/sh_mobile_hdmi.c
>> +++ b/drivers/video/sh_mobile_hdmi.c
>> @@ -1445,17 +1445,7 @@ static struct platform_driver sh_hdmi_driver = {
>>       },
>>  };
>>
>> -static int __init sh_hdmi_init(void)
>> -{
>> -     return platform_driver_probe(&sh_hdmi_driver, sh_hdmi_probe);
>> -}
>> -module_init(sh_hdmi_init);
>> -
>> -static void __exit sh_hdmi_exit(void)
>> -{
>> -     platform_driver_unregister(&sh_hdmi_driver);
>> -}
>> -module_exit(sh_hdmi_exit);
>> +module_platform_driver_probe(sh_hdmi_driver, sh_hdmi_probe);
>>
>>  MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
>>  MODULE_DESCRIPTION("SuperH / ARM-shmobile HDMI driver");
>>
>
>
> --
> Nicolas Ferre



-- 
Fabio Porcedda
