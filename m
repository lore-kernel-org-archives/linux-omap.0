From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: FSUSB Port on OMAP2430 SDP
Date: Thu, 2 Aug 2007 00:33:59 +0530
Message-ID: <78d6ed630708011203j8e9e7a1q4ee053e39f538f5f@mail.gmail.com>
References: <78d6ed630707312218w60198970rd8e98f1feb8261f0@mail.gmail.com>
	<6E3DC4E6E09EF440B55B7AD683608D6D017BA969@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D017BA969@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Nishant

Thanks for the reply

>>Don't enable CONFIG_USB_OTG. That won't work without the gadget side
driver, plus its not >>tested.

I already tried testing with this configuration. Its not working.


>>Try plugging in some other device, or a powered hub. The board might
provide enough current for >>your device.

Along with the first configuration(disabling config _otg etc....),  I also
tried plugging in the USB mouse but its not getting powered ON and not
giving me any interrupts nor messages with demsg -c.
Actually I am connecting mini B plug to the mini AB receptcle of FSUSB port
0. The mini B plug to Standard A cable is only there available with me which
I got with the board to download my images through CSST from desktop. And I
have to connect standard female to standard female cable to the Standard A
end of the cable and at the other end I can connect devices like mass
storage device or USB mouse.
I am not able to get the mini A plug to standard B cable available in India(
which I am not sure if its mandatory)

Should I connect the powered hub at the other end of female cable. The
powered hubs have their own power mechanism ?

Can we handle the alternaitve to power through so that we can power up the
Vbus to 5 volts >?
I found some code in isp1301_omap.c where we are configuring the transceiver
bits through I2C but I am not  sure how its being done siince if its already
handled within the ode my port should get powered up

Thanks & Regards

Amit

On 8/1/07, Kamat, Nishant <nskamat@ti.com> wrote:
>
> Amit,
>
> > -----Original Message-----
> > From: Amit Gupta
> > Sent: Wednesday, August 01, 2007 12:19 AM
> >
> > As per the reference manual, I saw the FSUSB port 0 being OTG
> > port which has connections with FS - host controller and FS-
> > device controller. Also as you mentioned the routing of
> > signals beteween OTG and mini AB receptacle J51 happens
> > through ISP 1301(OTG transceiver). I have included :-
> >
> > CONFIG_USB_OTG , CONFIG_USB_OHCI_HCD,
> > CONFIG_USB_OMAP24XX_FS_PORT0 , CONFIG_ARCH_OMAP243X and
> > CONFIG_ISP1301_OMAP
> >
>
> Don't enable CONFIG_USB_OTG. That won't work without the gadget side
> driver, plus its not tested.
>
> Also don't enable CONFIG_USB_MUSB_HDRC (Mentor/Inventra HS USB), in case
> you have, as it uses the same pins as FS USB port 0.
>
> > As of now my device is not getting powered ON( the mass
> > storage poer LED is not glowing which reqires 5 volts )
> > itself and its not registering any of the interrupts. Kindly
> > tell me the reason for the same
> >
>
> Try plugging in some other device, or a powered hub. The board might
> provide enough current for your device.
>
> >
> > Also if possible, kindly let me know if I can configure any
> > of the other ports on OMAP 2430 SDP v4.0 as host ports.
> >
> > Thanks & Regards
> >
> > Aman
> >
> >
> >
> > On 7/31/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> > >
> > > Amit,
> > > I think that port is either host or client.  You have to
> > choose either
> > > host or Gadget, and not OTG.
> > >
> > > Make sure you have the ISP1301 enabled in the I2C drivers.  Do not
> > > select the TWL4030 USB transceiver.
> > >
> > > Under USB, make sure you only have host selected (deselect Gadget).
> > > Also make sure you select OHCI and NOT the Inventra.
> > >
> > > Steve K.
> > >
> > > -----Original Message-----
> > > From: linux-omap-open-source-bounces@linux.omap.com
> > > [mailto: linux-omap-open-source-bounces@linux.omap.com] On
> > Behalf Of
> > > Amit Gupta
> > > Sent: Monday, July 30, 2007 2:34 PM
> > > To: linux-omap-open-source@linux.omap.com
> > > Subject: FSUSB Port on OMAP2430 SDP
> > >
> > > Hello
> > >
> > > I am using OMAP 2430 SDP v4.0 and trying to configure the
> > FS USB port
> > > 0(J51
> > > on the main board) as host. I am using kernel v2.6.14
> > >
> > >
> > >
> > > I am not getting any of the interrupts after connecting the
> > cable/and
> > > device. And the device (mass storage device) is not getting
> > configured.
> > >
> > >
> > >
> > > *        Does the port need to configure as OTG port and
> > then make it as
> > > host? That's how it seems to me from the code.
> > >
> > >
> > >
> > > *        Do we need to make any changes in the files for
> > making it to
> > > work?
> > > Also kindly send the config file for the same.
> > >
> > > Thanks & Regards
> > >
> > > Amit
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
