From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: FSUSB Port on OMAP2430 SDP
Date: Wed, 1 Aug 2007 15:57:24 -0400
Message-ID: <31e679430708011257m3a739f97te3911dda97471974@mail.gmail.com>
References: <78d6ed630708011203j8e9e7a1q4ee053e39f538f5f@mail.gmail.com>
	<6E3DC4E6E09EF440B55B7AD683608D6D01836ABA@dlee13.ent.ti.com>
	<78d6ed630708011242m7adadb5albd41f3ff8c489601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630708011242m7adadb5albd41f3ff8c489601@mail.gmail.com>
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

On 8/1/07, Amit Gupta <amit_jobs05@inbox.com> wrote:
> Hi Nishant
>
> Thanks for the quick response.
>
> Ok, so you mean to say powered hub would not solve the problem.And the linux
> FS - USB port host code is written assuming we attach Mini A plug
> .
> >>Hacking of isp1301_omap.c is not very clear to me ?

It's probably easier to hack the cable and ground id-pin with a small
spot of weld...

>
> As per the ISP1301 data sheet at:-
> http://balloonboard.org/hardware/300/ds/ISP1301.pdf
>
> Do I need to set the OTG Control registerS Vbus_drv bit  ? and should I do
> the same within the isp1301_set_host() of isp1301_omap.c. That is what seems
> to me? but still i am not sure about the transceiver logic, whether it wil
> read the id pin continously and power up/down the vbus accordingly ?
>
> Thanks & Regards
>
> Amit
>
>
> On 8/2/07, Kamat, Nishant <nskamat@ti.com> wrote:
> >
> > Amit
> >
> > -----------------------------------------
> > From: Amit Gupta
> > Sent: Wednesday, August 01, 2007 2:04 PM
> >
> > > Actually I am connecting mini B plug to the mini AB receptcle of FSUSB
> > port 0.
> >
> > Oh, that's the problem. A mini-A cable has to be plugged in to go to host
> > mode.
> >
> >
> > > I am not able to get the mini A plug to standard B cable available in
> > India( which I am not sure if its mandatory)
> >
> > Its mandatory according to the USB spec, and the way the isp1301_omap.c
> > driver detects the A-device/B-device mode. However, for testing purposes you
> > might be able to hack isp1301_omap.c to allow working as a host with mini-B
> > cable plugged in.
> >
> >
> > > Should I connect the powered hub at the other end of female cable.
> >
> > Won't help unless you use the mini-A - to standard-A female adapter, or do
> > the hack as mentioned above.
> >
> > > The powered hubs have their own power mechanism ?
> >
> > Yes, powered hubs don't need the host to supply current for their
> > operation.
> >
> >
> > Regards,
> > Nishant
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
