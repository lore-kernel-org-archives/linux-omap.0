From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: FSUSB Port 0 in OAMP2430 SDP
Date: Mon, 6 Aug 2007 15:11:46 -0400
Message-ID: <31e679430708061211n33200287wb057d6e520621462@mail.gmail.com>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<31e679430708051718q6b760029te6bb80c21f805dde@mail.gmail.com>
	<78d6ed630708061154w5ed11bd3m5a8ee11e5a3e64fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630708061154w5ed11bd3m5a8ee11e5a3e64fd@mail.gmail.com>
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
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 8/6/07, Amit Gupta <amit_jobs05@inbox.com> wrote:
> Hello
>
> Thanks a lot for a prompt reply.
>
> I understand that things can work out in the linux code if i ground the ID pin.
>
> But logically speaking can you tell me what actuallly happpens if i
> ground the ID pin . As per my understanding, it will just set the
> ID_GND bit in the interrrupt staus register in the ISP1301 transceiver
> and the interrupt will be generated in the OMAP2430 ie IRQ_OTG(78)
> would be set. And once the interrupt is generated , it is upto the
> linux code of the driver ie. isp1301_omap.c to configure the
> transceiver(using I2C) in a certain manner so that the power up takes
> place and Vbus becomes high. Setting the vbus_drv bit alone is not
> solving the issue. We need to set 1 or 2 more registers before setting
> this bit.

I think more stuff happens in hardware then just setting those
registers. Probably the transceiver is applying some pull-up and/or
pull-down resistors when ID pin is grounded. I'd read musb & otg docs
again to remember what really happens there.

If you check OTG specs rev 1.3 it presents what happens when you ground ID pin.

> This seqence I am looking forward to(ISP 1301 transceiver
> configuration for host mode).
>
> Also as per my understanding for ISP1301 transceiver to configure as a
> host only Vbus driving is required but this should happen after
> configuring some other dependent registers.
> Kindly help me in knowing the same so that I can configure the FSUSB
> port 0 as host port only.
>
> Can the powered hub be concerned as an alternative to the above
> sequence since if i am only trying to power up the port and hence the
> device through a setting in the transeiver then this can be done by
> means of the powered hub(which will power all the ports) and hence
> enumeration can take place there afterwards.

I'm pretty sure you'll need a self-powered hub anyway 'cause MUSB can
only provide 100mA and if you wanna power a non-otg usb device it uses
up to 500mA. The self-powered hub masks this limits to the controller
as it'll power the usb devices itself.

afaik, a powered hub do not back-feed ports. So you'd need to hack it
also in order to provide 5V back to OMAP2430SDP. I was doing this with
N800 when it wasn't being able switch to host just by software. You
can hack a hub and try this also. After that, please report us so we
can see what's happening with OMAP2430SDP ;-)

thanks in advance

>
> Thanks & Regards
>
> Amit
>
>
>
> On 8/6/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> > On 8/4/07, Amit Gupta <amitjobs05@gmail.com> wrote:
> > > Hi
> > >
> > > Thanks for the series of prompt replies.
> > >
> > > I am still struck up in the code. I have gonr through the code of
> > > isp1301_omap.c.
> > > The Vbus_drv bit has already been set in the linux code in the
> > > isp1301_set_host() in the following statement :-
> > >
> > > isp1301_set_bits(isp, ISP1301_OTG_CONTROL_1, OTG1_VBUS_DRV);
> > >
> > > So this means the care has already been taken care of setting the Vbus
> > > to 5 volts.
> > > And as per the statement above this line states the care has already
> > > been taken care
> > > of using mini A plug /mini B plug in the mini AB receptacle.
> > >
> > > So the question arises that why is my port not getting powered up.
> > > I am not sure what exactly needs to be done if I want to configure the
> > > FSUSB port 0 as host port only since I am not aware of the OTG
> > > configuratins/state machines.
> > > And i am not sure how ISP1301_omap.c takes care of the host , device
> > > and OTG configurations seperately.
> >
> > afaik OMAP2430SDP uses MUSB core inside OMAP chip. MUSB is an OTG core
> > and it changes roles by detecting the state of the id pin. This
> > detection is made on hardware not on software so it'll be a lot easier
> > to hack a mini-B cable and ground its id pin in order to convert it to
> > mini-A connector. This way, musb will know you're trying to become usb
> > host.
> >
> > >
> > > Can any one suggest me settings I need to do within the ISP-1301 for
> > > OMAP to act as host only since my OMAP gost controller is already
> > > configured and is sending SOF interrupt messages but my port is not
> > > getting powered up.
> >
> > SOF can happen on device also. Use the hacked-miniB cable and try again, please
> >
> > >
> > > Also kindly tell me the current capablity support for the port. Will
> > > it be able to power up the USB mouse.
> >
> > As an OTG controller, it can only provide 100mA current on the bus...
> > this is not enough for a usb mouse. But you can use a powered HUB
> > connected to fsusb port and the mouse connected through the hub
> >
> > >
> > > Also how are the connections for FSUSB port 1 . Are they through
> > > ISP-1301 transceiver only ?
> > >
> > > Thanks & Regards
> > >
> > > Amit
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >
> >
> >
> > --
> > Best Regards,
> >
> > Felipe Balbi
> > felipebalbi@users.sourceforge.net
> >
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
