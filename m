From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Wed, 14 Oct 2015 10:35:21 -0500
Message-ID: <561E7639.40506@ti.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com>
 <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com>
 <87r3kyd3xw.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3kyd3xw.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/13/2015 01:22 PM, Felipe Balbi wrote:
> Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
>> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
>> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>> We have a problem, when using more than 12 FTDI ports. Kernels tried:
>>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>>
>>> Below the USB topology:
>>>
>>> # lsusb -t
>>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>>>      |__ Port 1: Dev 2, If 0, Class=, Driver=hub/4p, 480M
>>>          |__ Port 1: Dev 9, If 0, Class=, Driver=hub/4p, 480M
>>>              |__ Port 1: Dev 10, If 0, Class=, Driver=ftdi_sio, 12M
>>>              |__ Port 2: Dev 11, If 0, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 2: Dev 11, If 1, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 2: Dev 11, If 2, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 2: Dev 11, If 3, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 3: Dev 12, If 0, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 3: Dev 12, If 1, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 3: Dev 12, If 2, Class=, Driver=ftdi_sio, 480M
>>>              |__ Port 3: Dev 12, If 3, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 2: Dev 4, If 0, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 2: Dev 4, If 1, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 2: Dev 4, If 2, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 2: Dev 4, If 3, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 3: Dev 7, If 0, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 3: Dev 7, If 1, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 3: Dev 7, If 2, Class=, Driver=ftdi_sio, 480M
>>>          |__ Port 3: Dev 7, If 3, Class=, Driver=ftdi_sio, 480M

How many EPs does each FTDI device require? at least one INT EP, right? 
If I read it right, the topology above has 2 hubs, and 16 high-speed 
FTDI and 1 full-speed FTDI. So it requires at least 18 high-speed INT 
EPs. MUSB driver only has 11 high-speed EPs for mode-4 which is the EP 
configuration used by default. I am wondering how those devices got 
enumerated properly.

>>>
>>> When using 12 ports and performing serial test (a pair of ports is
>>> connected via null-modem cable and a rather short string ca. 90
>>> characters will be sent alternating at 1200 and 115200b/s, testing
>>> scripts are written in Python and running as own processes per a pair
>>> of ports) there are no timeouts, i.e. all sent characters will be
>>> received. As soon as I open ports 13 and 14 I start to get arbitrary
>>> timeouts  (from test software point of view) on all ports.
>>>
>>> In order to check, if ftdi_sio has primary to do with this issue, I've
>>> performed the same test on a PC and PandaBoard Rev. A2 (EHCI port) and
>>> there were no issues with 16 ports. So it seems to have something to
>>> do with am335x + musb + number of end points.
>>>
>>> Any idea? Let me know, if you need our test script.
>>
>>  From time to time I get following warnings (4.3.0-rc5):
>>
>> musb_host_rx 1915: RX1 dma busy, csr 2020
>> musb_host_rx 1915: RX4 dma busy, csr 2020
>> musb_host_rx 1915: RX7 dma busy, csr 2220
>> musb_host_rx 1915: RX1 dma busy, csr 2020
>>
>> Though they are not timely related to serial test timeouts.
>
> yeah, I don't think MUSB can easily handle that. IIRC, endpoint
> scheduling in MUSB is rather bad. While we have enough endpoints to
> handle this case, you might be running into some IP (or driver) issues.
>
> Bin, have you ever tested this many serial devices on AM335x ?

No, I never tested this many devices. It could be resource limitation, 
but the log above is about CPPI, so I recommend to test with CPPI 
disabled to isolate if this is MUSB issue or CPPI.

Regards,
-Bin.

>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
