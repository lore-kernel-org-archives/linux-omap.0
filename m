From: Mircea Gherzan <mgherzan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Sun, 11 Mar 2012 23:30:54 +0100
Message-ID: <4F5D279E.9010800@gmail.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com> <20120309183150.GH12083@atomide.com> <4F5D057A.3080601@gmail.com> <CAHd==dp1GNov4gqMzPLkJzX1A205HUMhTPtg28399FcPQFZH0A@mail.gmail.com>
Reply-To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <pandaboard+bncCLTEjYjyBRCjz_T6BBoEPv-Lvw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAHd==dp1GNov4gqMzPLkJzX1A205HUMhTPtg28399FcPQFZH0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/pandaboard/post?hl=en_US>, <mailto:pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:pandaboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/pandaboard?hl=en_US>
Sender: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:pandaboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+575825281776+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Pavan Savoy <pavan.savoy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Am 11.03.2012 21:13, schrieb Pavan Savoy:
> On Sun, Mar 11, 2012 at 2:05 PM, Mircea Gherzan <mgherzan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Am 09.03.2012 19:31, schrieb Tony Lindgren:
>>> Hi Luca,
>>>
>>> * Mircea Gherzan <mgherzan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [120306 14:23]:
>>>> The "uim" deamon requires sysfs entries that are filled in using
>>>> this platform data.
>>>>
>>>> Signed-off-by: Mircea Gherzan <mgherzan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
>>>>  include/linux/ti_wilink_st.h           |    2 ++
>>>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
>>>> index b1d74d6..339e781 100644
>>>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>>>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include <linux/i2c/twl.h>
>>>>  #include <linux/regulator/machine.h>
>>>>  #include <linux/regulator/fixed.h>
>>>> +#include <linux/ti_wilink_st.h>
>>>>  #include <linux/wl12xx.h>
>>>>
>>>>  #include <mach/hardware.h>
>>>> @@ -56,12 +57,21 @@
>>>>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
>>>>
>>>>  /* wl127x BT, FM, GPS connectivity chip */
>>>> -static int wl1271_gpios[] = {46, -1, -1};
>>>> +static struct ti_st_plat_data wilink_platform_data = {
>>>> +    .nshutdown_gpio = 46,
>>>> +    .dev_name       = "/dev/ttyO1",
>>>> +    .flow_cntrl     = 1,
>>>> +    .baud_rate      = 3000000,
>>>> +    .chip_enable    = NULL,
>>>> +    .suspend        = NULL,
>>>> +    .resume         = NULL,
>>>> +};
>>>> +
>>>>  static struct platform_device wl1271_device = {
>>>>      .name   = "kim",
>>>>      .id     = -1,
>>>>      .dev    = {
>>>> -            .platform_data  = &wl1271_gpios,
>>>> +            .platform_data  = &wilink_platform_data,
>>>>      },
>>>>  };
>>>>
>>>> diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
>>>> index 2ef4385..3ca0269 100644
>>>> --- a/include/linux/ti_wilink_st.h
>>>> +++ b/include/linux/ti_wilink_st.h
>>>> @@ -25,6 +25,8 @@
>>>>  #ifndef TI_WILINK_ST_H
>>>>  #define TI_WILINK_ST_H
>>>>
>>>> +#include <linux/skbuff.h>
>>>> +
>>>>  /**
>>>>   * enum proto-type - The protocol on WiLink chips which share a
>>>>   *  common physical interface like UART.
>>>> --
>>>
>>> Just checking.. Can you please take a look at this patch
>>> and confirm that this is how things are supposed to be done?
>>>
>>> To me passing some third driver's dev_name in pdata seems
>>> pretty weird.. But then again maybe I just don't know how
>>> this is supposed to work.
>>
>> This is what the ti_st driver expects in the platform data structure.
>> More precisely, in kim_probe():
>>
>>        /* copying platform data */
>>        strncpy(kim_gdata->dev_name, pdata->dev_name,UART_DEV_NAME_LEN);
>>        kim_gdata->flow_cntrl = pdata->flow_cntrl;
>>        kim_gdata->baud_rate = pdata->baud_rate;
>>        pr_info("sysfs entries created\n");
>>
>> So IMHO the patch is a valid fix. However, one more patch [1] is still
>> required to get BT and WLAN working on the PandaBoard.
> 
> The patch looks alright to me.
> Yes, the UART to which BT chip is connected (along with other
> technologies for which shared transport is required), the baud rate
> which the UART supports & also a flag so as to check whether it
> supports flow control - ideally is supposed to come from boot-loader,
> device tree sort of configuration - if not can be hard-coded in the
> relevant platform specific files like in this case.
> 
> This is picked up from ST as platform data as is read from the
> user-space daemon, because unfortunately none of these configurations
> can be done in kernel (the right way for TTY).
> 
> 1 more patch or an addition to this patch to add the wl1271_device &
> the btwilink device is also required to get ST probe & BT probe.
> The btwilink driver is a platform device because UART devices don't
> have a probe mechanism unlike say usb, i2c..

This issue has been addressed in a previous patch [1].

[1] http://www.spinics.net/lists/linux-omap/msg65181.html
