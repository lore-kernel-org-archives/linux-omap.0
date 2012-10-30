From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-EEPROM: Export memory accessor
Date: Tue, 30 Oct 2012 12:12:47 -0700
Message-ID: <509026AF.7000206@gmail.com>
References: <1351699009-4217-1-git-send-email-panto@antoniou-consulting.com> <50902079.30406@gmail.com> <4AF9EE5B-D1C1-45E7-B2FD-E96151F5772A@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF9EE5B-D1C1-45E7-B2FD-E96151F5772A-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/30/2012 11:51 AM, Pantelis Antoniou wrote:
> Hi David,
>
> On Oct 30, 2012, at 8:46 PM, David Daney wrote:
>
>> On 10/31/2012 08:56 AM, Pantelis Antoniou wrote:
>>> Various platforms need access to the EEPROM in other
>>> places besides their platform registration callbacks.
>>> Export the memory accessor to the i2c_client
>>
>> i2c_clients are *not* intrinsically memory, so adding this to the generic i2c_client structure doesn't really make sense.   What would the semantics of this interface be with respect to temperature sensors and GPIO expanders?
>>
>> NACK.
>>
>
> It's only filled in for EEPROM devices. There's no other I2C memory read interface for kernel clients.


Basically you are tacking on a registery of memory devices to some 
random data structure that has nothing to do with memory.

Instead ...

>
>>
>>> and implement
>>> it for the at24 driver.
>>>
>>> And before you ask, no, the platform callback can't be used
>>> for anything that depends on DT.
>>
>> Why can't you just allocate (and populate) a struct at24_platform_data for the device if it isn't supplied by whatever created the device?
>>
>>
>>
>
> There are no platform_data in the case of device tree only generic-boards. Everything is configured via the DT and there are
> no callbacks. DT is a purely data driver concept.
>
> I'm open to suggestions on how to read an EEPROM from another kernel client, when there's no such thing as platform_data anymore.
>

... you need some sort of collection memory devices that can be queried 
by phandle and/or some other handle.

Any device that implements the struct memory_accessor interface could 
add itself to the collection, then code that needs to use the 
memory_accessor interface would look up the proper target for the 
operation by phandle or whatever other handle the system is using.

Similar to how of_phy_find_device() works.

I don't know if it would be possible to create a 'memory_accessor' bus, 
but that is one idea I had.

David Daney


> Regards
>
> -- Pantelis
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
