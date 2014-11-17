From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 19:12:29 +0200
Message-ID: <CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
	<20141117162209.GE7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:52387 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbaKQRMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 12:12:30 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so1762713wgh.26
        for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2014 09:12:29 -0800 (PST)
In-Reply-To: <20141117162209.GE7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

Thanks very much for suggestions,
I am able to wakeup the uart (though it takes about 10 seconds till it wakeup).
Anyway, after wakeup when I try to see the state I get:
~ # cat /dbg/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:3,INA:4,ON:7,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (11)
usbhost_clkdm->usbhost_pwrdm (3)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (2)
core_l4_clkdm->core_pwrdm (12)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state0/time
811807044
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state2/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state3/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state4/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state5/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state6/time
0

Do you have any suggestion, how I can understnad why it did not get
into retention and how to continue from this point ?

Thanks very much,
Ran

On Mon, Nov 17, 2014 at 6:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [141116 12:13]:
>> Hello,
>>
>> I'm using OMAP3530 with custom board. I have enabled all power mode
>> features as described in PSP wiki, but it still fails to enter any
>> state different from state0.
>
> Works for me with pretty much all omap3 boards I have here with
> mainline kernel since v3.17 using omap2plus_defconfig. And the
> following script to idle uarts and enable off-idle (or retention).
>
> USB needs to be disconnected and EHCI probably still cannot be
> enabled.
>
>> The next thing was trying to get the uart to sleep (though there might
>> be also problems with other domains ?) .
>>
>> On trying to enable uart as wakeup source I get the following:
>>
>> echo enabled >  /sys/devices/platform/omap/omap_uart.2/power/wakeup
>>
>> cat  /sys/devices/platform/omap/omap_uart.2/power/wakeup
>>
>> #> disabled      (?????)
>>
>> echo 1 >  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>> ~ # [   85.006622] omap_device: omap_uart.2: new worst case deactivate
>> latency 0: 61035
>> [   85.559844] omap_device: omap_uart.2: new worst case activate
>> latency 0: 61035
>> [  982.415161] omap_device: omap_uart.2: new worst case deactivate
>> latency 0: 91552
>>
>> < console hangs here >
>
> Sounds like you need to enable the wake-up interrupt for the UART.
> See the interrupts-extended entry for many omap3-*.dts files:
>
> interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
>
> If you get it working, care to update the instructions in the wiki
> too?
>
> Regards,
>
> Tony
>
> 8< ----------------------
> #!/bin/bash
>
> uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
> for uart in $uarts; do
>         echo 3000 > $uart/autosuspend_delay_ms 2>&1
> done
>
> uarts=$(find /sys/class/tty/ttyO*/power/ -type d 2>/dev/null)
> for uart in $uarts; do
>         echo enabled > $uart/wakeup 2>&1
>         echo auto > $uart/control 2>&1
> done
>
> echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
