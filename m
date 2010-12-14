From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities,
	pads and links
Date: Tue, 14 Dec 2010 16:30:39 +0100
Message-ID: <4D078D9F.1060700@ladisch.de>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>	<201012141300.57118.laurent.pinchart@ideasonboard.com>	<4D0771CB.3020809@ladisch.de>
	<201012141525.02463.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201012141525.02463.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Laurent Pinchart wrote:
> On Tuesday 14 December 2010 14:31:55 Clemens Ladisch wrote:
> > Laurent Pinchart wrote:
> > > On Monday 13 December 2010 17:10:51 Clemens Ladisch wrote:
> > >> EXT_SPEAKER also includes headphones; there might be made a case for
> > >> having those as a separate subtype.
> > > 
> > > Shouldn't headphones be represented by an EXT_JACK_ANALOG ?
> > 
> > Headphone jacks are jacks; there are also USB headphones.
> 
> So EXT_SPEAKER are speakers not connected through a jack (USB, internal
> analog, ...) ?

Yes.

When there is jack, the driver often does not know what is connected.

> > >> EXT_BROADCAST represents devices like TV tuners, satellite receivers,
> > >> cable tuners, or radios.
> > > 
> > > There's clearly an overlap with V4L here.
> > 
> > These come from the USB audio spec.  Video devices are indeed likely to
> > be more detailed than just a single audio source. :)
> 
> Does EXT_BROADCAST represent the TV tuner (or satellite receiver, cable tuner,
> radio tuner, ...) itself, or the connection between the tuner and the rest of
> the device ? Most TV tuner are currently handled by V4L2 and would thus turn
> up as V4L2 subdevs (I'm not sure if that's what we want in the long term, but
> it's at least the current situation).

>From the point of view of an audio device, this would be just some audio
source, much like a connector.  We don't need this if there is some
better V4L entitity that the USB audio entity can be mapped to.


Regards,
Clemens
