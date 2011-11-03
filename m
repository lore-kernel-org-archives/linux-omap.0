From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Linux 3.0 DSS support
Date: Thu, 03 Nov 2011 10:50:47 -0400
Message-ID: <4EB2AA47.1010306@gmail.com>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>	 <4E9BD71A.90703@ti.com>  <4EA5A677.3050704@logicpd.com>	 <1319528229.1684.20.camel@lappyti>	 <49A85CFF-CB0B-435C-BB54-12D247ABB6BE@dominion.thruhere.net> <1320313578.1859.55.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57389 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1KCOng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 10:43:36 -0400
Received: by gyc15 with SMTP id 15so304761gyc.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 07:43:36 -0700 (PDT)
In-Reply-To: <1320313578.1859.55.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Peter Barada <peter.barada@logicpd.com>, Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/03/2011 05:46 AM, Tomi Valkeinen wrote:
> On Thu, 2011-11-03 at 10:35 +0100, Koen Kooi wrote:
>> Op 25 okt. 2011, om 09:37 heeft Tomi Valkeinen het volgende geschreven:
>>
>>> Hi,
>>>
>>> On Mon, 2011-10-24 at 13:55 -0400, Peter Barada wrote:
>>>> In the above case (and my case where I'm looking for a 9Mhz pixel 
>>>> clock), fck_div is calculated at higher than 16 - and the video
>>>> output 
>>>> is wrong (i.e. no pixel clock and hsync runs at 32x the requested
>>>> rate). 
>>> DM37x TRM says:
>>>
>>> "DSS1_ALWON_FCLK: Issued from DPLL4. Its frequency can be a division by
>>> 1 to 16 of the frequency of the DPLL4 synthesized clock."
>>>
>>> I take it that DM37x is detected as cpu_is_3630()?
>>>
>>> The DSS driver currently handles only OMAPs, so for other SoCs the
>>> driver may contain lots of bugs like this.
>> dm3730 is just a different marketing name for omap3630, it should not have any functional changes.
> According to the TRM and experiments by Peter, it does.
Tomi,

I read Koen's comment to mean that functionally a dm3730 is the same as
a omap3630.
What I'm seeing is that the 3630 DSS hardware is more equivalent to the
OMAP3530 DSS hardware in respect to the maximum DSS F-clock divisor.

The code in the DSS clock calculation has multiple instances of:

              if (cpu_is_omap3630() || cpu_is_omap44xx())
<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/video/omap2/dss/dss.c;h=3e09726d32c7ae1f5a86e51830191a09d7574955;hb=43672a0784707d795556b1f93925da8b8e797d03#l554>                      
fck_div_max = 32;

I think this should be changed to:

              if (cpu_is_omap44xx())
<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/video/omap2/dss/dss.c;h=3e09726d32c7ae1f5a86e51830191a09d7574955;hb=43672a0784707d795556b1f93925da8b8e797d03#l554>                      
fck_div_max = 32;

as the code works as-is on OMAP35xx hardware.  But as I only have a
single 37xx/36xx configuration to test I don't know if other 36xx/37xx
parts allow fck_div_max to be larger than 16...

<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/video/omap2/dss/dss.c;h=3e09726d32c7ae1f5a86e51830191a09d7574955;hb=43672a0784707d795556b1f93925da8b8e797d03#l555>


-- 
Peter Barada
peter.barada@gmail.com

