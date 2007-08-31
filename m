From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ov9640: Add OmniVision ov9640 driver - new interface
Date: Fri, 31 Aug 2007 13:27:44 -0700
Message-ID: <20070831202744.GP12350@atomide.com>
References: <5d5443650708200321h6fa11423j24f48a565dacbbdb@mail.gmail.com>
	<262354.79141.qm@web8503.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <262354.79141.qm@web8503.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <trilok_soni@yahoo.co.in>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <trilok_soni@yahoo.co.in> [070823 05:29]:
> Hi,
> 
> --- Trilok Soni <soni.trilok@gmail.com> wrote:
> 
> > Hi Sakari,
> > 
> > On 8/20/07, Sakari Ailus <sakari.ailus@nokia.com>
> > wrote:
> > > ext Trilok Soni wrote:
> > > > Hi All,
> > >
> > > Hi, Trilok!
> > >
> > > > I have attached two patches which converts the
> > ov9640 driver to use
> > > > the new v4l2 sensor interface. Sensor detection
> > is working with H4 but
> > > > the output is not anywhere near to correct, so
> > someone with H4 please
> > > > check and give inputs.
> > > >
> > > > Patches are implemented and tested against
> > mainline kernel and OMAP2
> > > > camera driver posted by Sakari to v4l mailing
> > list [1].
> > >
> > >  > +#define NUM_IOCTLS 16
> > > ...
> > >  > +     /* Just an experiment --- don't use *_cb
> > functions yet. */
> > >  > +     ov9640_ioctl_desc[i++] =
> > vidioc_int_dev_init_cb(&ioctl_dev_init);
> > >  > +     BUG_ON(i >= NUM_IOCTLS);
> > >
> > > These are leftovers from the
> > check-slave-interface-types experiment
> > > which probably should be removed. This applies to
> > TCM825x as well.
> > >
> > 
> > I will remove that and update the patch once camera
> > output is correct.
> > 
> 
> I have attached the updated ov9640 patch with
> v4l2_ifparm addition and some cosmetic changes, sensor
> still not working except detection.

Trilok, can you please refresh this patch?

Tony
