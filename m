From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv7 01/18] I2C: OMAP: make omap_i2c_unidle/idle functions
 depend on CONFIG_PM_RUNTIME
Date: Wed, 11 Apr 2012 17:29:07 +0530
Message-ID: <CAM=Q2csMkvbVwSav8d4KCXkcNS=oQGpPY2R-hiVzZvVPEngrog@mail.gmail.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
	<1334142776-10583-2-git-send-email-shubhrajyoti@ti.com>
	<20120411113254.GE12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61881 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab2DKL7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 07:59:08 -0400
In-Reply-To: <20120411113254.GE12064@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

Hi Felipe,

On Wed, Apr 11, 2012 at 5:02 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Apr 11, 2012 at 04:42:39PM +0530, Shubhrajyoti D wrote:
>> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_=
resume
>> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME=
=2E
>> This patch removes the omap_i2c_unidle/idle functions and folds them
>> into the runtime callbacks.
>>
>> This fixes the below warn when CONFIG_PM_RUNTIME is not defined
>>
>> =A0CC =A0 =A0 =A0arch/arm/mach-omap2/board-ti8168evm.o
>> drivers/i2c/busses/i2c-omap.c:272: warning: 'omap_i2c_unidle' define=
d but not used
>> drivers/i2c/busses/i2c-omap.c:293: warning: 'omap_i2c_idle' defined =
but not used
>> =A0 CC =A0 =A0 =A0net/ipv4/ip_forward.o
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> how about just moving them into the #ifdef ? /me thinks it's easier t=
o
> read with the function. Matter of taste though, it's not that much co=
de.

Kevin preferred folding into the  runtime functions.

http://www.spinics.net/lists/linux-omap/msg62764.html

Don't feel strongly though.

>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
