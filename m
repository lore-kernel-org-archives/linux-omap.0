From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
Date: Mon, 18 Jul 2016 15:07:57 +0300
Message-ID: <5c538963-ae46-54fc-27bf-dbae81443215@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160718103137.GG5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718103137.GG5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 07/18/16 13:31, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2016 at 03:42:35PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> The following series with the final patch will add support for sDMA =
Linked List
>> transfer support.
>> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family)=
=2E
>> If the descriptor load feature is present we can create the descript=
ors for each
>> SG beforehand and let sDMA to walk them through.
>> This way the number of sDMA interrupts the kernel need to handle wil=
l drop
>> dramatically.
>=20
> I suggested this a few years ago, and I was told by TI that there was
> no interest to implement this feature as it had very little performan=
ce
> effect.

I can not comment on this... Few years ago I was not involved with the =
DMA
drivers so I don't have any idea why would anyone object to have the li=
nked
list (or descriptor load) mode in use whenever it is possible.
I was not even aware of the linked list mode of sDMA 3 weeks back, but =
while
reading the TRM - for the interleaved mode mainly it sounded like a goo=
d idea
to implement this.
Not really sure about the raw performance impact, but for interactivity=
 it
does help. I remember running 'emerge --sync' on BeagleBoard was pain a=
s it
took hours and the board was mostly unusable during that time. With the=
 linked
list mode the same takes reasonable time and I can still poke around in=
 the board.

> Do I take it that TI have changed their position on this feature?

I was not aware of any position on this from TI - as I mentioned I was =
not
involved with DMA. It could be that the position from 'TI' is still wha=
t it
was. Or changed. But as I have been asked to look after TI DMA drivers
upstream and I believe that the linked list mode is a good thing to hav=
e -
which is backed by my experiences. My position is that linked list supp=
ort is
cool.

--=20
P=E9ter
