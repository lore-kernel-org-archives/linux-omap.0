From: "Wael Adel" <showairovic@gmail.com>
Subject: Re: OMAP5912 OSK
Date: Tue, 13 Mar 2007 12:12:23 +0200
Message-ID: <bd205c5f0703130312tbe2d827o8293925553103177@mail.gmail.com>
References: <bd205c5f0703130302g7cf590b1yfbe2c59f8aac99b6@mail.gmail.com>
	<5DF83221BE20114E9C331F665ACBC08002B660DF@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002B660DF@dbde01.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

this is a very good thanks a lot, but i have another question if u please ,
here is what i want to do exactly:

i want to make my computer communicate with the OMAP kit using usb,so i have
connected them using usb cable,
so the OMAP would b a  gadget (the slave) and the host of my computer would
b the master, right?

i just want the kit to read what the host send then replies by certain
answer.
so gadget_zero can make this for me ? or i should change anything in it?
thanks in advance.


On 3/13/07, Pandita, Vikram <vikram.pandita@ti.com> wrote:
>
>  You can run gadget zero as such with the netchip device VID/PID.
>
> The class driver for your device will be the usbtest.ko in the linux host
> that you connect to.
>
>
>
>
>   ------------------------------
>
> *From:* Wael Adel [mailto:showairovic@gmail.com]
> *Sent:* Tuesday, March 13, 2007 3:32 PM
> *To:* Pandita, Vikram
> *Cc:* linux-omap-open-source@linux.omap.com
> *Subject:* Re: OMAP5912 OSK
>
>
>
> so do u have any suggestion about this?
>
> i mean is there someone tries VID and PID and works well?
>
> thanks a lot for your help
>
>
>
> On 3/13/07, *Pandita, Vikram* <vikram.pandita@ti.com> wrote:
>
> Your gadget device descriptor can have any VID/PID that you wish.. but
> then the host to which you connect should recognize this pair and load the
> corresponding class driver
>
>
>   ------------------------------
>
> *From:* Wael Adel [mailto: showairovic@gmail.com]
> *Sent:* Tuesday, March 13, 2007 3:26 PM
> *To:* Pandita, Vikram
> *Subject:* Re: OMAP5912 OSK
>
>
>
> so u mean that i can put the VID and PID any numbers? please tell me this
> in a simple way, i m just a new in using omap kit
>
> thanks in advance.
>
>
>
> On 3/13/07, *Pandita, Vikram* < vikram.pandita@ti.com> wrote:
>
>
> My understanding is that OMAP device as such does not have any specific
> VID/PID. It is programmable. So you will have to program your gadget
> driver to provide your VID/PID.
>
> The host should have the corresponding CLASS driver for your gadget.
>
> Vikram
>
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Wael Adel
> > Sent: Tuesday, March 13, 2007 2:59 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: OMAP5912 OSK
> >
> > hi all,
> > i want to use the usb of the kit OMAP5912 ,
> > i want to make a usb gadget driver for it so:
> >
> > i have downloaded linux kernel 2.6.19 on it successffuly,
> > and choose omap_udc.c to be a module,
> > and zero.c also to be a module,(note that it would test the omap_udc)
> > but unfortunalley,the vendor id and product id is for another chip
> which
> > is
> > net2280.
> >
> > if u dont understand anything from what i say,just check $( kernel
> source
> > code )/drivers/usb/gadget to see two files:
> > 1. omap_udc.c         2.zero.c
> >
> > and my problem is that i want to know the product id and the vendor id
> for
> > the usb port in the OMAP5912?
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
>
