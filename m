From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Linux 3.0 DSS support
Date: Wed, 02 Nov 2011 11:42:23 -0400
Message-ID: <4EB164DF.506@gmail.com>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>	 <4E9BD71A.90703@ti.com>  <4EA5A677.3050704@logicpd.com> <1319528229.1684.20.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58260 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab1KBPfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 11:35:21 -0400
Received: by gyb13 with SMTP id 13so247730gyb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Nov 2011 08:35:21 -0700 (PDT)
In-Reply-To: <1319528229.1684.20.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Barada <peter.barada@logicpd.com>, Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/25/2011 03:37 AM, Tomi Valkeinen wrote:
> Hi,
>
> On Mon, 2011-10-24 at 13:55 -0400, Peter Barada wrote:
>> In the above case (and my case where I'm looking for a 9Mhz pixel 
>> clock), fck_div is calculated at higher than 16 - and the video
>> output 
>> is wrong (i.e. no pixel clock and hsync runs at 32x the requested
>> rate). 
> DM37x TRM says:
>
> "DSS1_ALWON_FCLK: Issued from DPLL4. Its frequency can be a division by
> 1 to 16 of the frequency of the DPLL4 synthesized clock."
>
> I take it that DM37x is detected as cpu_is_3630()?
>
> The DSS driver currently handles only OMAPs, so for other SoCs the
> driver may contain lots of bugs like this.
Yes, cpu_is_omap3630() returns true on a DM3730.  I'll rework the patch
(I think all that is needed is to drop the "cpu_is_omap3630() ||" from
the test - then fck_div_max will remain at 16 for the DM3730.

-- 
Peter Barada
peter.barada@gmail.com

