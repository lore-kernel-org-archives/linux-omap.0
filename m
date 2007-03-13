From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: OMAP5912 OSK
Date: Tue, 13 Mar 2007 15:34:27 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002B660DF@dbde01.ent.ti.com>
References: <bd205c5f0703130302g7cf590b1yfbe2c59f8aac99b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <bd205c5f0703130302g7cf590b1yfbe2c59f8aac99b6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Wael Adel <showairovic@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You can run gadget zero as such with the netchip device VID/PID.

The class driver for your device will be the usbtest.ko in the linux
host that you connect to.

=20

=20

________________________________

From: Wael Adel [mailto:showairovic@gmail.com]=20
Sent: Tuesday, March 13, 2007 3:32 PM
To: Pandita, Vikram
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: OMAP5912 OSK

=20

so do u have any suggestion about this?

i mean is there someone tries VID and PID and works well?

thanks a lot for your help

=20

On 3/13/07, Pandita, Vikram <vikram.pandita@ti.com> wrote:=20

Your gadget device descriptor can have any VID/PID that you wish.. but
then the host to which you connect should recognize this pair and load
the corresponding class driver=20

=20

________________________________

From: Wael Adel [mailto: showairovic@gmail.com]=20
Sent: Tuesday, March 13, 2007 3:26 PM=20
To: Pandita, Vikram
Subject: Re: OMAP5912 OSK

=20

so u mean that i can put the VID and PID any numbers? please tell me
this in a simple way, i m just a new in using omap kit

thanks in advance.

=20

On 3/13/07, Pandita, Vikram < vikram.pandita@ti.com
<mailto:vikram.pandita@ti.com> > wrote:=20


My understanding is that OMAP device as such does not have any specific
VID/PID. It is programmable. So you will have to program your gadget=20
driver to provide your VID/PID.

The host should have the corresponding CLASS driver for your gadget.

Vikram

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Wael Adel=20
> Sent: Tuesday, March 13, 2007 2:59 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OMAP5912 OSK
>
> hi all,
> i want to use the usb of the kit OMAP5912 ,=20
> i want to make a usb gadget driver for it so:
>
> i have downloaded linux kernel 2.6.19 on it successffuly,
> and choose omap_udc.c to be a module,
> and zero.c also to be a module,(note that it would test the omap_udc)=20
> but unfortunalley,the vendor id and product id is for another chip=20
which
> is
> net2280.
>
> if u dont understand anything from what i say,just check $( kernel
source
> code )/drivers/usb/gadget to see two files:=20
> 1. omap_udc.c         2.zero.c=20
>
> and my problem is that i want to know the product id and the vendor id
for
> the usb port in the OMAP5912?
> _______________________________________________=20
> Linux-omap-open-source mailing list=20
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

=20

=20
