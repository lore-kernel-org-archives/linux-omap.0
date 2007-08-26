From: "Matt Callow" <mc-lists@tesco.net>
Subject: Re: merging camera_core and omap16xxcam files
Date: Sun, 26 Aug 2007 16:04:12 +1000
Message-ID: <5937bed10708252304s42e2f47fg207ee86a6fd618f2@mail.gmail.com>
References: <5937bed10708231615q39a9cc38xe3152b949dfecd27@mail.gmail.com>
	<786804.14179.qm@web8512.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <786804.14179.qm@web8512.mail.in.yahoo.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 24/08/07, Trilok Soni <trilok_soni@yahoo.co.in> wrote:
> Hi Matt,
>
> --- Matt Callow <mc-lists@tesco.net> wrote:
>
> > On 23/08/07, Trilok Soni <trilok_soni@yahoo.co.in>
> > wrote:
> > > Hi All,
> > >
> > > As we don't see multiple hardware interfaces
> > attached
> > > to omap1 camera_core.c from the long time except
> > for
> > > the present omap16xxcam.c, I would like take code
> > from
> > > omap16xxcam.c to camera_core.c and dma code to
> > > omap16xxdma.c. This will help us while going to
> > > upstream and then using new v4l2_int interface and
> > new
> > > ov9640 sensor driver which I had submitted few
> > days
> > > back.
> > >
> > > Please let me know if some one is having other
> > > hardware interfaces implemented but not submitted
> > to
> > > list e.g omap850cam.c, omap5910cam.c etc.
> > >
> > I've written a driver for omap1510, which is based
> > on omap16xxcam.c.
> > I've not submitted it as a patch yet as it needs
> > some more work.  It's
> > available here
> >
> http://the.earth.li/pub/e3/2.6.19/ams-delta-camera.patch
> > AFAIKR I had to make some changes to the DMA chains
> > to make it work
> > with the 1510.
> > It also includes a driver for the Ov6650  sensor.
> > (It was written specifically for the Amstrad E3
> > http://www.amstrad.com/products/emailers/e3.html)
> >
>
> Thanx for the information, and I will look into the
> patches, if time permits I will convert them to latest
> kernel version with some cleanup and atleast to the
> state where they can be compiled.

That would be great, but if you don't have time I'll look at re-doing
the patches after you have made your changes.

>
> If you don't mind, I will forward your reply to
> mailing list for others information and archive.

No problem - I meant to send my original reply to the list anyway

Matt
