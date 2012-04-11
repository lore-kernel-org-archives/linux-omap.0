From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Wed, 11 Apr 2012 10:39:56 +0200
Message-ID: <4F85435C.1060305@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com> <1323863746-18145-5-git-send-email-rnayak@ti.com> <CAB-zwWjSSsR0XMrntkEmHDtgJ_zDxgJh6KX=TsSKggd9mCgsVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAB-zwWjSSsR0XMrntkEmHDtgJ_zDxgJh6KX=TsSKggd9mCgsVQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Omar,

On 4/11/2012 2:16 AM, Ramirez Luna, Omar wrote:
> Hi,
>
> On Wed, Dec 14, 2011 at 5:55 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> Pass minimal data needed for console boot, from dt, for
>> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
>> static initialization from generic board file.
> ...
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 63b5416..a508ed5 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -69,7 +69,6 @@ static void __init omap_generic_init(void)
>>         if (node)
>>                 irq_domain_add_simple(node, 0);
>>
>> -       omap_serial_init();
>>         omap_sdrc_init(NULL, NULL);
>>
>>         of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>> --
>> 1.7.1
>
> I'm fairly new to DT and I'm trying to boot it with pandaboard and
> k3.3, however above hunk deletes omap serial initialization, which
> causes a panic on boot, because pdata is NULL:
>
> static void serial_omap_start_tx(struct uart_port *port)
> {
> ...
>                  if (pdata->set_noidle)
>
> Perhaps because this change skips the following path:
>
> omap_serial_init->omap_serial_board_init->omap_serial_init_port
>
> Where pdata is built in omap_device_build.
>
> I'm just trying to confirm that I'm not alone or doing some silly
> thing before getting in depth with the code.

Yes, it is a known issue and the fix was unfortunately was not merged 
during -rc phases but is fixed in 3.4 and should be fixed in 3.3 stable 
branch as well. I received the notification from Greg KH 2 weeks ago 
about the stable: Patch "tty: serial: OMAP: Fix oops due to NULL pdata 
in DT boot" has been added to the 3.3-stable tree

You should just switch to 3.4-rc2 or get the patch if you are stuck to 3.3.

Regards,
Benoit
