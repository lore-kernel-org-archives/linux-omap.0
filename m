From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: dma request
Date: Sun, 21 May 2006 09:10:53 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E08637F@DLEE09.ent.ti.com>
References: <3634de740605210424w207391f4v191462789a7dff59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Maximus <john.maximus@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Maximus,
Here is a quick view of what this means:
>    what is the difference between element count and frame count?.
buffer size=3Db
frame count =3Df
element count =3D e
data type =3D d
implies
Size of 1 element =3D number of bytes send by DMA per read/write =
operation =3D d
Size of 1 Frame =3D number of elements send by DMA per dma request =3D =
e=3D e*d bytes
Size of 1 transfer (also called block)=3D number of bytes transfered by =
DMA in a transfer =3D f =3D f*e*d bytes.

>   how it is computed?.
For the sake of explanation, I shall use a scenario where the dma =
transfers data from memory to a peripheral (using frame sync).
1. we first decide on what should be the basic transfer unit to the =
peripheral, it is like deciding should i use a writeb,writew/writel to =
write to the data register of the peripheral(implying a 8/16/32 bit =
write op to the peripheral's data register).  This forms the data type =
in DMA which is the size of a single element which will be transfered by =
the DMA.
2. now some peripherals have internal FIFOs'. So everytime a dma request =
appears from the peripheral to the DMA, it implies, that the peripheral =
would want e elements to be transfered to it's fifo. this is the =
number(e) that we program to the element count.=20
3. when we have a buffer of size b, and we have programmed an element =
size 'd' and a element count 'e', this implies that we need to send =
b/(d*e) frame more. this is the frame count.=20
=20
with element sync mode of operation, the dma is concerned with the =
number of bytes per element to be transfered, so if u put element =
count=3Db/d and frame count=3D1, or element count =3D1 and frame =
count=3Db/d, it will still work.
=20
The TRM contain detailed info on DMA ops, that can act as a better =
explanation I hope.

Regards,
Nishanth Menon
