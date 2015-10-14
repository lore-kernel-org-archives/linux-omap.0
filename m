From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Wed, 14 Oct 2015 11:41:56 -0500
Message-ID: <561E85D4.4040208@ti.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com>
 <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com>
 <87r3kyd3xw.fsf@saruman.tx.rr.com> <561E7639.40506@ti.com>
 <87h9ltbg0i.fsf@saruman.tx.rr.com> <561E7B6D.80605@ti.com>
 <87eggxbeou.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87eggxbeou.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,

On 10/14/2015 11:25 AM, Felipe Balbi wrote:
>
> Hi,
>
> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>> On 10/14/2015 10:56 AM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>>> Hi,
>>>>
>>>> On 10/13/2015 01:22 PM, Felipe Balbi wrote:
>>>>> Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
>>>>>> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
>>>>>> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>>>>>> We have a problem, when using more than 12 FTDI ports. Kernels tried:
>>>>>>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>>>>>>
>>>>>>> Below the USB topology:
>>>>>>>
>>>>>>> # lsusb -t
>>>>>>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>>>>>>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>>>>>>>        |__ Port 1: Dev 2, If 0, Class=, Driver=hub/4p, 480M
>>>>>>>            |__ Port 1: Dev 9, If 0, Class=, Driver=hub/4p, 480M
>>>>>>>                |__ Port 1: Dev 10, If 0, Class=, Driver=ftdi_sio, 12M
>>>>>>>                |__ Port 2: Dev 11, If 0, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 2: Dev 11, If 1, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 2: Dev 11, If 2, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 2: Dev 11, If 3, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 3: Dev 12, If 0, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 3: Dev 12, If 1, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 3: Dev 12, If 2, Class=, Driver=ftdi_sio, 480M
>>>>>>>                |__ Port 3: Dev 12, If 3, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 2: Dev 4, If 0, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 2: Dev 4, If 1, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 2: Dev 4, If 2, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 2: Dev 4, If 3, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 3: Dev 7, If 0, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 3: Dev 7, If 1, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 3: Dev 7, If 2, Class=, Driver=ftdi_sio, 480M
>>>>>>>            |__ Port 3: Dev 7, If 3, Class=, Driver=ftdi_sio, 480M
>>>>
>>>> How many EPs does each FTDI device require? at least one INT EP, right?
>>>> If I read it right, the topology above has 2 hubs, and 16 high-speed
>>>> FTDI and 1 full-speed FTDI. So it requires at least 18 high-speed INT
>>>> EPs. MUSB driver only has 11 high-speed EPs for mode-4 which is the EP
>>>> configuration used by default. I am wondering how those devices got
>>>> enumerated properly.
>>>
>>> dynamic EP allocation, but that has its own limitations.
>>>
>> MUSB does not support dynamic EP allocation for INT/ISOCH.
>
> I remember isoc doesn't, not sure about int. Do you remember where that
> part of the code is off the top of your head ?
>

The MUSB EP allocation is in musb_schedule() in musb_host.c.

It does not have specific policy for INT/ISOCH, but the issue is that 
for periodic EP, it got allocated during device enumeration but freed 
only when the device is disconnected. So practically there is no dynamic 
EP allocation for INT/ISOCH.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
