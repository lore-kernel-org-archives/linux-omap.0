From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 10/13] ARM: OMAP5: board-generic: Add device tree support.
Date: Mon, 7 May 2012 19:38:39 +0530
Message-ID: <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-11-git-send-email-r.sricharan@ti.com>
	<4FA7CDC1.9050301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:58680 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756620Ab2EGOIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 10:08:45 -0400
Received: by lahc1 with SMTP id c1so3871306lah.26
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 07:08:39 -0700 (PDT)
In-Reply-To: <4FA7CDC1.9050301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com

Hi Benoit,
  Thanks for the reviews.

>
>> Adding the minimal support for OMAP5 soc with device tree.
>
>
> You should probably split that patch since you are doing several thin=
gs that
> are not OMAP5 related.
>
> Do a patch that move the omap_init_irq into the INTC and GIC code fir=
st.
>
> Then, you can add a patch to add the OMAP5_DT machine entry.
>
  ok, will split this then accordingly.

[snip]

>> @@ -185,6 +185,8 @@ void omap3_intc_prepare_idle(void);
>> =A0void omap3_intc_resume_idle(void);
>> =A0void omap2_intc_handle_irq(struct pt_regs *regs);
>> =A0void omap3_intc_handle_irq(struct pt_regs *regs);
>> +void omap_of_init_irq(void);
>
>
> In order to be consistent with the GIC function and even the previous=
 ones,
> you should name the exported one:
>
> +void omap_intc_of_init(void);
>
 Ok, will take care of this rename.


>>
>> @@ -279,6 +280,16 @@ int __init omap_intc_of_init(struct device_node
>> *node,
>
>
> And thus rename that one that become a private function without the o=
map_
> prefix.
>
 ok..

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
