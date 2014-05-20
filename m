From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/6] usb: musb: core: Handle Babble condition only
 in HOST mode
Date: Tue, 20 May 2014 10:02:47 +0530
Message-ID: <537ADAEF.9060105@ti.com>
References: <1400506776-2816-1-git-send-email-george.cherian@ti.com>	<1400506776-2816-2-git-send-email-george.cherian@ti.com> <CADYTM3bd8Bq5QTn-HC4jYX-owEw_sF1DOtXsc-cMDqKHGJHXjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADYTM3bd8Bq5QTn-HC4jYX-owEw_sF1DOtXsc-cMDqKHGJHXjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Bin,
On 5/19/2014 9:24 PM, Bin Liu wrote:
> Hi,
>
> On Mon, May 19, 2014 at 8:39 AM, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> wrote:
>> BABBLE and RESET share the same interrupt. The interrupt
>> is considered to be RESET if MUSB is in peripheral mode and
>> as a BABBLE if MUSB is in HOST mode.
>>
>> Handle babble condition iff MUSB is in HOST mode.
>>
>> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/musb/musb_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 61da471..eff3c5c 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -849,7 +849,7 @@ b_host:
>>          }
>>
>>          /* handle babble condition */
>> -       if (int_usb & MUSB_INTR_BABBLE)
>> +       if (int_usb & MUSB_INTR_BABBLE && is_host_active(musb))
>>                  schedule_work(&musb->recover_work);
> I guess my following comments are for Daniel's patch as while which
> initially added the babble work.
>
> Should this if statement be merged into the previous 'if(int_usb &
> MUSB_INTR_RESET)' one, which handles the same interrupt and already
> handles host and device mode respectively.

Initially I too had the babble handling as part of  'if(int_usb & 
MUSB_INTR_RESET)'
one. But during my tests I hit a corner case where in we hit a BABBLE 
condition
on disconnect. In such case the babble interrupt can be handled only if 
we have a seperate
check, else its considered as a BUS RESET.

When all devices are disconnected  MUSB_DEVCTL_HM = 0 and the code 
always enter the
else path. In this path it treats the BABBLE as a BUS RESET.

> Regards,
> -Bin.
>
>>   #if 0
>> --
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
-George

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
