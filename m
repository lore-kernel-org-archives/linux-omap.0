From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
Date: Wed, 12 Oct 2011 19:08:51 +0530
Message-ID: <CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com> <87vcrv2xox.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87vcrv2xox.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 11:54 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Modify the omap_uart_can_sleep function to check uart is active
>> or not to be used by pm code to enter low power states.
>
> Doesn't the driver now control when the UART clocks are gated (using
> runtime PM autosuspend)?
>
> IMO, this check should be completely removed and the driver should
> be managing this with the autosuspend timeout.
>
>> Removing this check can cause console response little sluggish.
>
> Sluggish in what way?
>

response is slower like when we type something or cat debugfs/pm_count
see things little slower on console, there is no character loss.

Happens even though we have not set the autosuspend timeout and uart
clocks are active,
which basically means allowing mpu to enter retention keeping uart acti=
ve.

this delay in response or sluggishness is not there on my 3430SDP or
3630zoom board but I was able to see this behavior on a beagle board(xm=
 rev c).

retaining this uart_can_sleep check in omap3_can_sleep ensures a better
console user experience. (not allowing mpu to enter retention
until uart clocks are cut)


> If the driver is runtime suspended, it should only be sluggish for th=
e
> first character. =A0After that, the autosuspend timeout should preven=
t it
> from feeling sluggish.
>
>> However no characters will be lost until uart clocks are gated
>> and woken up using rx-pad. UART interface clocks can be auto gated
>> this can make response on uart slower. This behaviour was observed
>> only on some of OMAP3 boards(beagleboard xm rev c).
>>
>> Reported-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c | =A0 21 +++++++++------------
>> =A01 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 6725caf..ccf3550 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -156,23 +156,20 @@ static void omap_uart_smart_idle_enable(struct=
 omap_uart_state *uart,
>>
>> =A0int omap_uart_can_sleep(void)
>> =A0{
>> - =A0 =A0 struct omap_uart_state *uart;
>> - =A0 =A0 int can_sleep =3D 1;
>> -
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!uart->clocked)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 u8 i, ret =3D true;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!uart->can_sleep) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 can_sleep =3D 0;
>> + =A0 =A0 for (i =3D 0; i < num_uarts; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_uart_hwmod_lookup(i);
>
> This is a heavy operation to add for *every* entry into idle.
>

removing uart_list caused this ops, retaining uart_list
will ensure this will be replaced with list_for_each_entry
as done in existing code.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
