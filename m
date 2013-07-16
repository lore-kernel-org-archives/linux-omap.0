From: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: always send stop after nack
Date: Tue, 16 Jul 2013 17:33:47 +0800
Message-ID: <51E5137B.7000302@yahoo.es>
References: <51E50217.1000507@yahoo.es> <20130716090300.GG8880@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130716090300.GG8880-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 7/16/2013 5:03 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 16, 2013 at 04:19:35PM +0800, Hein Tibosch wrote:
>> Hi Vikram,
>>
>> On a OMAP4460, i2c-bus-3:
>>
>> A driver (lm75) is causing many 'timeout waiting for bus ready' errors.
>> SDA remains high (as it should), but SCL remains low after a NACK.
>> The bus becomes _unusable for other clients_.
>>
>> While probing, "lm75" writes a command, followed by a read + stop,
>> but the write command is NACK'd. The chip does accept other writes/reads,
>> it just refuses to ack invalid commands.
>>
>> Can you tell me if the patch below would make any sense? Or is it the
>> responsibility of the client to reset the i2c_smbus?
> patch below breaks repeated start.
Hi,

No, after the NACK, no more commands are being processed,
including a repeated start. omap_i2c_xfer() returns -EREMOTEIO
without ever freeing the bus.

The bus is left in an impossible state with SCL constantly low
and all next commands (to different chips) will therefore get
a -ETIMEDOUT

With this patch, the bus will become idle again and new commands
can be processed normally

Hein
