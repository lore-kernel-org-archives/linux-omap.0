From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: always send stop after nack
Date: Tue, 16 Jul 2013 14:01:11 +0300
Message-ID: <51E527F7.4080007@ti.com>
References: <51E50217.1000507@yahoo.es> <20130716090300.GG8880@arwen.pp.htv.fi> <51E5137B.7000302@yahoo.es> <20130716094212.GL8880@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130716094212.GL8880-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Hein, Felipe

On 07/16/2013 12:42 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 16, 2013 at 05:33:47PM +0800, Hein Tibosch wrote:
>> On 7/16/2013 5:03 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Jul 16, 2013 at 04:19:35PM +0800, Hein Tibosch wrote:
>>>> Hi Vikram,
>>>>
>>>> On a OMAP4460, i2c-bus-3:
>>>>
>>>> A driver (lm75) is causing many 'timeout waiting for bus ready' errors.
>>>> SDA remains high (as it should), but SCL remains low after a NACK.
>>>> The bus becomes _unusable for other clients_.
>>>>
>>>> While probing, "lm75" writes a command, followed by a read + stop,
>>>> but the write command is NACK'd. The chip does accept other writes/reads,
>>>> it just refuses to ack invalid commands.
>>>>
>>>> Can you tell me if the patch below would make any sense? Or is it the
>>>> responsibility of the client to reset the i2c_smbus?
>>> patch below breaks repeated start.
Felipe, I'd very appreciate if you'd be able to provide the use case
which will fail with such solution?

>> Hi,
>>
>> No, after the NACK, no more commands are being processed,
>> including a repeated start. omap_i2c_xfer() returns -EREMOTEIO
>> without ever freeing the bus.
>>
>> The bus is left in an impossible state with SCL constantly low
>> and all next commands (to different chips) will therefore get
>> a -ETIMEDOUT
>>
>> With this patch, the bus will become idle again and new commands
>> can be processed normally
I think, this is valid fix, but it was done here already:)
http://patchwork.ozlabs.org/patch/249790/
"i2c: omap: query STP always when NACK is received"

And nacked in the same way :(
But! I've back-ported my patch on TI Android product kernel 3.4, did
sanity test and I didn't see any issues with my patch :))

>
> but you mentioned that if you have IGNORE_NAK set, everything is fine,
> since lm75 will get a return value of 0 and things will work just fine,
> right ?
>
> Also, you also said that the chip 'refuses to ack invalid commands', why
> are you sending invalid commands to start with ? This could be a bug in
> i2c-omap.c, sure, but let's try to figure out why IGNORE_NAK helps and
> why is lm75 driver sending invalid commands.
>

The problem is, that lm75 device is SmBus compatible and its driver has
.detect() function implemented. During detection it tries to scan some
registers which might be not present in current device - in my case
it's tmp105.

For example to read regA in tmp105 following is done:
1) do write in "Index" register (val RegA index) (I2C 1st message)
2) do read (I2C 2d message)
the message 1 is Nacked by device in case if register index is wrong, 
but i2c-omap don't send NACK (or STP). As result, bus stack in Bus Busy 
state.

For SMBus devices the specification states (http://smbus.org/specs/)
"4.2.Acknowledge (ACK) and not acknowledge (NACK)":
- "The slave device detects an invalid command or invalid data. In this
case the slave device must not acknowledge the received byte. The
master upon detection of this condition must generate a STOP condition
and retry the transaction"

Regards,
-grygorii
