From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping
 from cpuidle
Date: Fri, 27 Jul 2012 13:13:23 +0530
Message-ID: <5012469B.1070003@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>	 <1342764284-8143-3-git-send-email-rnayak@ti.com>	 <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>	 <5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban>	 <87obn3798o.fsf@ti.com> <50113B3C.4090608@ti.com>  <87boj2s9hi.fsf@ti.com> <1343327231.30247.151.camel@sokoban> <5012395F.3040903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38524 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751240Ab2G0Hna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 03:43:30 -0400
Received: by yenr9 with SMTP id r9so3579290yen.22
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 00:43:28 -0700 (PDT)
In-Reply-To: <5012395F.3040903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com

Hi Tero,

On Friday 27 July 2012 12:16 PM, Rajendra Nayak wrote:
> However a quick test with just your latest usecounting series (without
> any of my RFC patches) seems to make me think I am still missing
> something.
>
> If you see the counts below for usbhost and dss, they both seem to
> go in and out of RET with every MPU transition. Which means the
> dependencies are still set.
>
> # cat /debug/pm_debug/count
> usbhost_pwrdm
> (ON),OFF:0,RET:138,INA:0,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm
> (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
>
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm
> (ON),OFF:0,RET:138,INA:0,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:132,INA:6,ON:139,RET-LOGIC-OFF:0
> mpu_pwrdm
> (ON),OFF:0,RET:132,INA:6,ON:139,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm
> (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
>
>
> However if I look at the dss registers, I don;t see any fclks are
> enabled.
>
> # ./readmem 0x48004E00
> 0x00000000 <- All FCLK disabled.
>
> # ./readmem 0x48004E10
> 0x00000001 <- ICLK enabled
>
> # ./readmem 0x48004E44
> 0x00000006 <- dependencies are set with MPU and IVA
>
> # ./readmem 0x48004E48
> 0x00000003 <- clkdm is under HWSUP.
>
> Any idea why this could be happening?

I think I know what the problem is now.

omap3_pm_init calls clkdm_allow_idle for all clkdms, while autoidle on
all iclks is still disabled. This causes autodeps to be set as the iclks
are accounted for in the usecount.
(hwmod would have done a clk_enable() on the iclks and left them enabled
as OCPIF_SWSUP_IDLE isn't set)

static void omap3_clkdm_allow_idle(struct clockdomain *clkdm)
{
         if (atomic_read(&clkdm->usecount) > 0)
                 _clkdm_add_autodeps(clkdm);

         omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
                                 clkdm->clktrctrl_mask);
}

A little later after omap3_pm_init, we enable autoidle for all iclks.
omap2_clkt_iclk_allow_idle decrements the usecount, but leaves the
autodeps still set.

This seems to be causing the dss and usb to also transition along with
MPU.

We will need some way to also clear and set autodeps in
omap2_clkt_iclk_allow_idle/deny_idle.

regards,
Rajendra




