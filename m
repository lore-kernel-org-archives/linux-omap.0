From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 17:34:10 +0900
Message-ID: <aec7e5c30906050134u1bcfc326p15691d90b6902d68@mail.gmail.com>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	 <20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
	 <20090605101816.6bbe496e@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:26674 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbZFEIeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 04:34:09 -0400
Received: by yw-out-2324.google.com with SMTP id 5so807905ywb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 01:34:11 -0700 (PDT)
In-Reply-To: <20090605101816.6bbe496e@hskinnemoen-d830>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-pm@lists.linux-foundation.org, pavel@ucw.cz, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Fri, Jun 5, 2009 at 5:18 PM, Haavard
Skinnemoen<haavard.skinnemoen@atmel.com> wrote:
> Magnus Damm wrote:
>> +static struct dev_pm_ops dw_dev_pm_ops =3D {
>> + =A0 =A0 .suspend_noirq =3D dw_suspend_noirq,
>> + =A0 =A0 .resume_noirq =3D dw_resume_noirq,
>> +};
>
> Can this be const?

Hm, adding const generates a warning for me. At on SuperH with
gcc-4.3.3 (Sourcery G++ Lite 4.3-143):

[modified dev_pm_ops to const in sh_keysc.c]

  CC      drivers/input/keyboard/sh_keysc.o
drivers/input/keyboard/sh_keysc.c:299: warning: initialization
discards qualifiers from pointer target type

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
