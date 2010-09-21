From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform
	support
Date: Tue, 21 Sep 2010 21:07:29 +0530
Message-ID: <AANLkTinqiknLaBmMj17fi31TsZ+eaSkCcgd-wbQvMpz-@mail.gmail.com>
References: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
	<87tylorl9i.fsf@deeprootsystems.com>
	<AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
	<87wrqg2xog.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87wrqg2xog.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

<SNIP>

>>>> Also the patch series updates various low level platform specific
>>>> serial data to support omap-uarts with hwmod framework and adds support
>>>> for uart4 on OMAP3630.
>>>
>>> This series is missing a couple things to work more broadly on all
>>> boards, specifically 3630-based boards.
>>>
>>> First, due to the current UART idle code base, you need to enable all
>>> OMAP UARTs 36xx. =A0Enabling less than all OMAP UARTs will break the
>>> current idle code. =A0As we discussed, the next phase we will move the
>>> idle management from this serial.c hackery into the omap-serial driver
>>> iteself. =A0Until then, you need to call omap_serial_init() on
>>> Zoom2/Zoom3. =A0Patch below[1]
>>>
>>> Also, you previously had a patch that updated omap_uart_idle_init() to
>>> handle 36xx and specifically UART4. =A0Without that, struct
>>> omap_uart_state is not setup correctly for UART4, and thus cannot be
>>> properly idled on 3630.
>>
>> ok fine, I will I incorporate initialize all uarts patch for zoom boards.
>>
>> Are you referring to this patch?
>> https://patchwork.kernel.org/patch/108066/
>>
>> Is this still needed if we have initialized all uarts?
>> This patch might not needed if we have initialized all uarts right?
>
> Right. =A0We don't need the above patchwork patch if all UARTs are
> initialized.
>
> The other patch I was referring to was the one that added UART4 support
> to omap_uart_idle_init() (added the wk_en, wk_st, padconf etc.) =A0I had a
> pending request for you to drop the muxmode from that patch, but the
> rest of it was still needed.
>
>>>
>>> Also, it's been a while since I tested this on OMAP2. =A0Please re-test=
 on
>>> OMAP2 with the whole series. =A0Also, please report here the other
>>> platforms this was tested on. =A0The final needs to be tested on OMAP2,=
 3
>>> and 4 before merge.
>>
>> Yes Sure,
>>
>> Just FYI this patch series was also tested on omap2,3,4.
>>
>
> OK, be sure to test Zoom3, because my testing on Zoom3 led to a crash as
> soon as idle was enabled due to the missing init of all UARTs.


This patch series applied on top of pm-core branch

commit 4c1f85cdc189d41ee53c1bc3957a908c91cffc00
Merge: ca1684b 96c4e27
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Thu Sep 16 15:29:06 2010 -0700

with below changes:

1) if (uart->timeout)
                uart->timeout =3D (30 * HZ);

2) #define DEFAULT_TIMEOUT 5 [temporary change for timeout]

I see ret count getting incremented on ZOOM3 even without "UART4 support
to omap_uart_idle_init()" patch.

I dont see any crash.

Logs Snip:

/ # mount -t debugfs debugfs /debug
/ #
/ #
/ # echo 1 > /debug/pm_debug/sleep_while_idle

/ # cat /debug/pm_debug/count
usbhost_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:0,RET:773,INA:0,ON:774,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:794,INA:0,ON:795,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:0,RET:796,INA:0,ON:797,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:796,INA:0,ON:797,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,=
RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (11)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (9)
core_l3_clkdm->core_pwrdm (5)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)



-- =

---
Regards,
Govindraj.R
