From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Updated OMAP 2 camera driver and N800 platform
	camera patches
Date: Fri, 31 Aug 2007 13:27:04 -0700
Message-ID: <20070831202703.GO12350@atomide.com>
References: <46C982CD.80802@nokia.com>
	<5d5443650708200959u7de311e2m1eda814ecc2e1540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650708200959u7de311e2m1eda814ecc2e1540@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070820 09:59]:
> Hi Sakari,
> 
> On 8/20/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> > Hi,
> >
> > Here are the new OMAP 2 camera driver and N800 platform camera patches.
> > I have posted the updates to V4L int if and TCM825x driver to the V4L
> > list already as they have been integrated into V4L tree at
> > <URL:http://linuxtv.org/hg/v4l-dvb> (excluding the new patches, sorry).
> >
> > The changes since the last update include the following:
> >
> > - Update to use vidioc_int_g_ifparm.
> >
> > - VIDIOC_DQBUF fix.
> >
> >      The driver assumed that every slave would return zero from
> >      vidioc_int_g_needs_reset. This doesn't hold true for the slaves that
> >      do not implement that ioctl at all.
> >
> > - Small cleanups, remove useless & characters.
> 
> Thanx for the update. I will rebase ov9640 code with above v4l2-int
> changes and test with this updated omap2 camera driver.

I've pushed Sakari's V4L stuff and other camera patches except for
one Trilok's patch which needs refreshing. Can you please check
that all the necessary stuff is in the tree now?

Tony
