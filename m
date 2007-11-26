From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: 3430SDP USB driver
Date: Mon, 26 Nov 2007 15:44:44 -0400
Message-ID: <31e679430711261144r3dbe3e3dk18075c3a4ab94e09@mail.gmail.com>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFC@zeus.Combra.se>
	<D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
	<200711261134.37463.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200711261134.37463.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com, Carl Benson <Carl.Benson@combra.se>
List-Id: linux-omap@vger.kernel.org

Hi,

On Nov 26, 2007 3:34 PM, David Brownell <david-b@pacbell.net> wrote:
> On Monday 26 November 2007, Carl Benson wrote:
> >
> > Hi. Unable to compile support for USB on 3430SDP ES1.0. Seems
> > like the struct urb has changed somewhere between 2.6.22 and
> > 2.6.23 and that the driver is lagging behind?
>
> You should be able to configure peripheral-only support.
>
> There were some usbcore changes which haven't yet been
> fully addressed.  Felipe updated Tony's patch for that,
> and I don't know the status ... the kernel I produced
> from Friday's GIT wouldn't boot, and I didn't make time
> to sort it out yet.

Only gadget should work for now. Altough there's no target
for building musb on 3430 boards.
What I'm doing is writing my own board-3430sdp-usb.c and
hacking drivers/usb/musb/Makefile to build omap2430.c with
3430 boards just out of testing purposes.

Still not working and I got busy with other tasks. Will get back to (m)usb
work on next week.

>
> - Dave
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
