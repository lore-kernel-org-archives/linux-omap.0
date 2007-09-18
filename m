From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] OMAP: Add OmniVision ov9640 sensor driver with new v4l2
	interface.
Date: Tue, 18 Sep 2007 11:47:08 +0530
Message-ID: <5d5443650709172317i7c1236cdkb1715afa2f80452d@mail.gmail.com>
References: <5d5443650709060541q5112eb7ei5132efbcc6be7d13@mail.gmail.com>
	<20070917183338.GI21226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070917183338.GI21226@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 9/18/07, Tony Lindgren <tony@atomide.com> wrote:
> * Trilok Soni <soni.trilok@gmail.com> [070906 05:44]:
> > Hi All,
> >
> > Copying the commit message:
> >
> > -------------------------------snip-----------------------
> > Subject: [PATCH] OMAP: Add OmniVision ov9640 sensor driver with new
> > v4l2 interface.
> >
> > - Add OmniVision ov9640 sensor driver with new I2C style bindings,
> >   converted to use new v4l2 sensor interface and moved
> >   platform specific data to board files.
> >
> > - Sensor used with H4 omap2420 doesn't give the correct capture
> >   output and need to be investigated.
> >
> > - Sensor detection works.
> > -------------------------------snip-------------------------
> >
> > So, it would be great if people having H4 can test and report the
> > problem we might have in existing sensor/camera controller driver to
> > get the correct capture output. Thanx.
> >
> > Please not that this driver is added in "drivers/media/video"
> > directory instead of the "omap" one, as we are not planning to take
> > extra directory to upstream for camera.
>
> Pushing this too. Are there files under drivers/media/video/omap that
> we can remove now?
>

Not until we test this current driver with OMAP1 and convert OMAP1
driver to new v4l2 sensor interface.  I don't have OMAP1 hardware, so
it would be great if someone having OSK/H3/H2 with ov9640 sensor can
test this current sensor driver after converting the existing omap1
cam controller driver with new v4l2 sensor interface.

-- 
--Trilok Soni
