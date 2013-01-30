From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] cpsw: Fix interrupt storm among other things
Date: Wed, 30 Jan 2013 15:51:30 +0200
Message-ID: <60C298DC-2DE8-4A44-B00C-E3B09ABE701E@antoniou-consulting.com>
References: <1359378668-26536-1-git-send-email-panto@antoniou-consulting.com> <5107B650.5090901@ti.com> <3DE2C638-6AE8-4BC9-AD68-3AAA40CD6233@antoniou-consulting.com> <5108E1C6.9020201@ti.com> <0FB10FF4-6639-472E-943C-61CEDB0336E0@antoniou-consulting.com> <5108FC31.3000507@ti.com> <27A3106E-3FDB-43DB-AAC9-DC2DA768AF9E@antoniou-consulting.com> <B5906170F1614E41A8A28DE3B8D121433ED03FE1@DBDE01.ent.ti.com> <0422CC2C-3D0D-4BB5-A90D-D3D337E44DD0@antoniou-consulting.com> <B5906170F1614E41A8A28DE3B8D121433ED04134@DBDE01.ent.ti.com> <F3F6248B-4DF4-418E-AD1F-F41E14CC85B2@antoniou-consulting.com> <B5906170F1614E41A8A28DE3B8D121433ED041A8@DBDE01.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED041A8@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Porter, Matt" <mporter@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "Kridner, Jason" <jdk@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Vaibhav,

On Jan 30, 2013, at 3:47 PM, Bedia, Vaibhav wrote:

> Hi Antoniou,
> 
> On Wed, Jan 30, 2013 at 19:07:19, Pantelis Antoniou wrote:
>> Hi Vaibhav,
>> 
>> On Jan 30, 2013, at 3:29 PM, Bedia, Vaibhav wrote:
>> 
>>> On Wed, Jan 30, 2013 at 18:14:30, Pantelis Antoniou wrote:
>>>> Hi Vaibhav,
>>>> 
>>>> On Jan 30, 2013, at 2:38 PM, Bedia, Vaibhav wrote:
>>>> 
>>>>> On Wed, Jan 30, 2013 at 16:38:50, Pantelis Antoniou wrote:
>>>>> [...]
>>>>>> 
>>>>>> TBH I haven't found a simple way to print out the silicon revision number.
>>>>>> Anyone on the list know a quick and dirty method? 
>>>>>> 
>>>>> 
>>>>> You can dump the DEVICE_ID register @ 0x44e10600.
>>>>> Bits 31:28 should be 0 for PG1.0 and 1 for PG2.0.
>>>>> 
>>>> 
>>>> Thanks this works perfectly:
>>>> 
>>>> original-bone:
>>>> root@beaglebone:~# devmem2 0x44e10600 w
>>>> Read at address  0x44E10600 (0xb6ff4600): 0x0B94402E
>>>> 
>>>> bone-black:
>>>> root@beaglebone:~# devmem2 0x44e10600 w
>>>> Read at address  0x44E10600 (0xb6fcc600): 0x1B94402E
>>>> 
>>> 
>>> I just re-read the mail-chain and I am confused here.
>>> So the patch in question is meant for Bone-A4 which has
>>> PG1.0?
>>> 
>> 
>> It is a general bug fix. The problem was discovered only on 
>> the bone black which has PG2.0 silicon. The driver has been
>> tested and it works on the original bone with PG1.0 as well.
>> 
> 
> But Mugunthan mentioned that he doesn't see this on an EVM
> with PG2.0 silicon... is there any board dependency here?
> 

I don't know, but I doubt it. How about we wait for Mugunthan to
send us what are the DEVICE_ID contents for his board.

> Regards,
> Vaibhav

Regards

-- Pantelis
