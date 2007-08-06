From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: FSUSB Port 0 in OAMP2430 SDP
Date: Tue, 7 Aug 2007 01:40:37 +0530
Message-ID: <78d6ed630708061310y2febb009s3d8640c054f5e4f7@mail.gmail.com>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<31e679430708051718q6b760029te6bb80c21f805dde@mail.gmail.com>
	<78d6ed630708061154w5ed11bd3m5a8ee11e5a3e64fd@mail.gmail.com>
	<31e679430708061211n33200287wb057d6e520621462@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901967083@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901967083@dlee13.ent.ti.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>>I think more stuff happens in hardware then just setting those
>>registers. Probably the transceiver is applying some pull-up and/or
>>pull-down resistors when ID pin is grounded. I'd read musb & otg docs
>>again to remember what really happens there.

>>If you check OTG specs rev 1.3 it presents what happens when you
>>ground ID pin.

I was going through OTG specs 1.3. Its difficult to go through
completely but then it Pg 23 tells a bit which I was onterested in. It
tells that Vbus switcjing can also take place through an application.
It says that bus is powered up only when application tries to call ot
there is b_srp_init, In the first case if the application is trigering
the bus to power on then its definitely happening through software
only. Also it talks about bus powered USB device initialting the
session. Now it clearly says that it will post an event/interrupt.

But still you may be correct that lots of things might be hapening
within the transeiver  hardware like pull up/pull down but I  need to
know that do that so that I can program the Transceiver accordingly.

Thanks in advance

Regards

Amit
On 8/7/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > I'm pretty sure you'll need a self-powered hub anyway 'cause MUSB can
> > only provide 100mA and if you wanna power a non-otg usb device it uses
> > up to 500mA. The self-powered hub masks this limits to the controller
> > as it'll power the usb devices itself.
>
> I think you are both right and wrong.  Its been a few years since I looked, so their probably have been some changes.
>
> MUSB likely doesn't supply power to anyone.  The board's power supply will do this.  What its capacity is depends on how it was setup.  To be OTG stamp on it a device might need to stay at or below 100mA (might be self powered also).  For the omap-device to get the stamp it might have to at least supply 100.  Do both ends have the USB logo on them?  Do you need them to be?
>
> An OTG device to get certified need to support many devices ether.  You can have a white list which allows limited support.
>
> It might be you need to manually turn on some LDO or other on some detection interrupt.  There was one board with the fs-usb block which had this kind of logic I dealt with.  It had 2 ports, one gave just enough power for a target peripheral and another port gave lots of power.
>
> I seem to recall some noise about raising the limits but that may have been a dream.
>
> Regards,
> Richard W.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
