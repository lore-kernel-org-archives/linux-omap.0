From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by
 returning EPROBE_DEFER
Date: Mon, 30 Jul 2018 18:56:25 -0400
Message-ID: <20180730185625.14c0feca.drivshin@awxrd.com>
References: <20180728165914.15871-1-andreas@kemnade.info>
        <20180728203501.GA16194@lenoch>
        <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
        <20180729180804.GA18468@lenoch>
        <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, David Rivshin <drivshin@allworx.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 29 Jul 2018 20:19:08 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
> 
> > Am 29.07.2018 um 20:08 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller wrote:  
> >> Hi,
> >>   
> >>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> >>> 
> >>> Hi Andreas,
> >>> 
> >>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:  
> >>>> I got this in the kernel log:
> >>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> >>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> >>>> 
> >>>> the probe function has to wait until omap_dm_timer_probe() in
> >>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing  
> >>> 
> >>> There already is a patch by David Rivshin addressing the same issue...  
> >> 
> >> Here it is:
> >> 
> >> https://patchwork.ozlabs.org/patch/943148/
> >> 
> >> but hasn't arrived in linux-next.  
> > 
> > That's because there'll be v3.
> >   
> >> But it is questionable if a driver should dev_info() about doing deferred probing.
> >> IMHO, it should just do it which is how Andreas' patch works.  
> > 
> > See here: https://patchwork.ozlabs.org/patch/949659/  
> 
> Ah, I see (neither Andreas nor me did follow the original discussions
> and therefore came up independently with the same thoughts).

Seems a lot of us have tripped over this problem at roughly the same 
time. I'm hoping Thierry picks it up in time for the 4.19 merge window.

> So we will wait for the v3.

FYI, v3 has been posted: https://patchwork.ozlabs.org/patch/951299/
Let me know if you feel strongly enough about having no message
(vs dev_dbg) for me to spin a quick v4. Seems like each additional 
pair of eyes leans in that direction.

Ladislav, I realized just after I sent that I forgot to add your ack
to the commit message. Sorry for the oversight.

> 
> BR and thanks,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
