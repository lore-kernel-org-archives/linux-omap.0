From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 16:46:52 +0530
Message-ID: <505C4CA4.6020507@ti.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com> <20120921110050.GC16003@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120921110050.GC16003@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com
List-Id: linux-omap@vger.kernel.org

On Friday 21 September 2012 04:30 PM, Felipe Balbi wrote:
> On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
>> Overrun also causes an internal flag to be set, which disables furth=
er
>> reception. Before the next frame can
>> be received, the MPU must:
>> =E2=80=A2 Reset the RX FIFO.
>> =E2=80=A2 clear the internal flag.
>>
>> In the uart mode a dummy read is needed. Add the same.
> Very nice patch but I think commit log can be a bit more verbose.
ok
> Please make the problem a little clearer. Why do we even get that
> interrupt fired if BRK_ERROR_BITS aren't set ?
I did not get this point.

it it is !  BRK_ERROR_BITS I return.

If it is and there is data in the fifo then a read is done.
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> - functional testing on omap4sdp
>> - Verified idle and suspend path hits off on beagle.
>>
>>  drivers/tty/serial/omap-serial.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index a0d4460..bc22a2b 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct u=
art_omap_port *up)
>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned in=
t lsr)
>>  {
>>  	unsigned int flag;
>> +	unsigned char ch =3D 0;
>> +
>> +	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
>> +		return;
>> +
>> +	if (likely(lsr & UART_LSR_DR))
>> +		ch =3D serial_in(up, UART_RX);
> Maybe add a comment before this condition stating why this character
> read is necessary ?
OK.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
