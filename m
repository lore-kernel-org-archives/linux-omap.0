From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 20:38:36 +0530
Message-ID: <CAM=Q2cu6B3w4OHOo3+X4bSK1wp_HXiK3wTqnYVSRQFqeSke6TA@mail.gmail.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
	<87a9wjfohd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87a9wjfohd.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 7:48 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
[...]
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> - functional testing on omap4sdp
>> - Verified idle and suspend path hits off on beagle.
>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> This fixes the console hang I was seeing on 3530/Overo.
Thanks for the test.

Could you test the v2
http://www.spinics.net/lists/arm-kernel/msg197050.html

I have removed the redundant check.
Thanks,


>
> Thanks,
>
> Kevin
>
>>  drivers/tty/serial/omap-serial.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index a0d4460..bc22a2b 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>>  {
>>       unsigned int flag;
>> +     unsigned char ch = 0;
>> +
>> +     if (!(lsr & UART_LSR_BRK_ERROR_BITS))
>> +             return;
>> +
>> +     if (likely(lsr & UART_LSR_DR))
>> +             ch = serial_in(up, UART_RX);
>>
>>       up->port.icount.rx++;
>>       flag = TTY_NORMAL;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
