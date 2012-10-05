From: Archit Taneja <archit@ti.com>
Subject: Re: omap DSS cmdline resolution not working for HDMI?
Date: Fri, 5 Oct 2012 16:53:03 +0530
Message-ID: <506EC317.1050208@ti.com>
References: <20121004175604.GE3874@atomide.com> <1349435094.2401.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2JELXJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 07:23:09 -0400
In-Reply-To: <1349435094.2401.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 05 October 2012 04:34 PM, Tomi Valkeinen wrote:
> On Thu, 2012-10-04 at 10:56 -0700, Tony Lindgren wrote:
>> Hi,
>>
>> FYI, looks like for some reason DSS command line is not
>> working for HDMI while it works for DSS. On my panda es
>> I'm trying to set my motorola lapdock resolution from
>> cmdline with:
>>
>> omapdss.def_disp=hdmi omapfb.mode=hdmi:1366x768@60
>>
>> But it does not seem to do anything and resolution is
>> VGA. If I change the cable to DVI port this works:
>>
>> omapdss.def_disp=dvi omapfb.mode=dvi:1366x768@60
>>
>> Any ideas? This is with current linux next.
>
> That's because our HDMI only supports certain timings. To be honest, I
> don't really understand this restriction, as I believe the hardware
> should be able to use more or less any timings just like DVI.
>
> The 1366x768@60 mode is parsed with fbdev functions, which returns a
> video timings. These timings are then given to the HDMI driver, which
> tries to find matching timings from its timing table. And when it
> doesn't find a match, it fails.
>
> This is a known problem, and the hdmi driver would really need some love
> in other aspects also. I'm not sure what would be the best way to
> improve this without doing major rewrites. Perhaps the check in the hdmi
> driver could be more relaxed, but that needs some careful thought.
>
>> I can change the HDMI resolution OK from userspace with:
>>
>> echo "1" > /sys/devices/platform/omapdss/display1/enabled
>> echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
>> echo "tv" > /sys/devices/platform/omapdss/overlay0/manager
>> echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
>> echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/display1/timings
>
> That's because the above line has timings that are in the hdmi driver's
> table. They are somewhat different than what fbdev gives for
> "1366x768@60".
>
>> The reason to use HDMI instead of DVI here is that HDMI
>> also has the speakers on the lapdock ;)
>>
>> Then I'm able to switch between HDMI panel and DVI panel
>> just fine using overlay0. I don't know if getting both
>> HDMI and DVI to work the same time using overlay1 is
>> supposed to work, but trying use overlay1 produces the
>> following:
>
> HDMI and DVI cannot be used reliably at the same time, due to a HW issue
> we've had unresolved for a long time. Luckily, it was solved this week
> and we'll have a patch for next merge window to get this working.
>
>> echo "1" > /sys/devices/platform/omapdss/display0/enabled
>> echo "0" > /sys/devices/platform/omapdss/overlay1/enabled
>> echo "lcd2" > /sys/devices/platform/omapdss/overlay1/manager
>> echo "1" > /sys/devices/platform/omapdss/overlay1/enabled
>> echo "170666,1920/336/128/208,1200/38/1/3" > /sys/devices/platform/omapdss/display0/timings
>>
>> [  816.446044] omapdss DPI: Could not find exact pixel clock. Requested 23500 kHz, got 23630 kHz
>> [  881.639221] omapdss APPLY: timeout in wait_pending_extra_info_updates
>> [  958.946594] ------------[ cut here ]------------
>> [  958.953277] WARNING: at drivers/bus/omap_l3_noc.c:97 l3_interrupt_handler+0xc0/0x184()
>> [  958.965576] L3 standard error: TARGET:DMM2 at address 0x0
>> ...
>
> Having said the above, I don't quite know where this error comes from...
> Tiler (DMM) is not even used by omapfb.

There is a timeout in wait_pending_extra_info_updates() which happens 
before. That's something that shouldn't have occurred.

The overlay1 disable would have led to extra info being dirty. The 
unsetting of the manager led to the call of 
wait_pending_extra_info_updates(). This function noticed that there is 
an extra_info update on going, and waited for the completion, but never 
got it. I'm not sure why that's happened.

Archit

