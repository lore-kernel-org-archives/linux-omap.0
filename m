From: Archit Taneja <a0393947@ti.com>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Tue, 7 Aug 2012 12:05:53 +0530
Message-ID: <5020B749.8060303@ti.com>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi> <1344273868.12136.50.camel@deskari> <5020009C.1080308@ti.com> <20120806221424.GD1298@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39448 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab2HGGh2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 02:37:28 -0400
In-Reply-To: <20120806221424.GD1298@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Tuesday 07 August 2012 03:44 AM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Aug 06, 2012 at 11:06:28PM +0530, Archit Taneja wrote:
>>> On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
>>>> I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
>>>> kernel, it's just full of flicker/noise.
>>>>
>>>> According to git-bisect, the problem is introduced by the commit:
>>>>
>>>>      commit f476ae9dab3234532d41d36beb4ba7be838fa786
>>>>      Author: Archit Taneja <archit@ti.com>
>>>>      Date:   Fri Jun 29 14:37:03 2012 +0530
>>>>
>>>>      OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface
>
> [...]
>
>> The diff I have shared introduces the register writes back. This
>> should make it work like before. But we need to figure out which
>> parameter write needs to be done immediately. If this works, could
>> you remove each dispc register write turn by turn, and point out
>> which is the culprit one?
>
> Thanks, the following one makes the display to work again:
>
> diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
> index 5d31699..3c9f598 100644
> --- a/drivers/video/omap2/dss/sdi.c
> +++ b/drivers/video/omap2/dss/sdi.c
> @@ -46,6 +46,9 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
>   	sdi.mgr_config.video_port_width = 24;
>   	sdi.mgr_config.lcden_sig_polarity = 1;
>
> +	dispc_mgr_set_clock_div(dssdev->manager->id,
> +				&sdi.mgr_config.clock_info);
> +

Thanks for finding this. It's a bit peculiar why this is happening. The 
DISPC_DIVISOR is a shadow register for sure.

I don't know much about SDI, but it looks like the SDI PLL needs the 
free running pixel clock from the LCD manager. To achieve this, we set 
PCKFREEENABLE. The thing I don't understand is that whether the free 
running pixel clock at this point would be derived out of the old LCD 
and PCD values, or the new ones? It should have been old since LCD and 
PCD are shadowed registers.

In other words, I am suspecting that the field PCKFREEENABLE does a copy 
of the LCD and PCD dividers from the shadow registers to the working 
registers.

The regdump shows that there were issues in SDI initialization.

Tomi,

Any ideas about this?

Archit
