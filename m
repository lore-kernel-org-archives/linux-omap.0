From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATH 0/3] ARM: OMAP1: Camera: Updates API usage and removes
	unused files
Date: Thu, 29 Nov 2007 08:38:53 -0400
Message-ID: <a0580c510711290438j7ee8e3abnda84f82b3ff09c26@mail.gmail.com>
References: <1195683785-32132-1-git-send-email-edubezval@gmail.com>
	<20071128022511.GH11825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071128022511.GH11825@atomide.com>
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
Cc: Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Sorry for the delayed answer.

On Nov 27, 2007 10:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Eduardo Valentin <edubezval@gmail.com> [071121 14:24]:
> >        This patch set updates v4l2 API usage and removes unused
> > files on camera code for omap1. Here is an overall description:
> >
> >        There are two updates on v4l2 API usage: on the use of videobuf and
> > v4l2-int-device deattach.
> >
> >        As the ov9640 is already moved to the v4l2-int-device API and
> > the camera code for omap1 too, this patch set also removes unused and
> > duplicated files. The info from this removed files already moved to board
> > specific files and to other files (see previous related patches).
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >
> >        Here is its  overall diffstat:
> >  b/drivers/media/video/omap/Kconfig         |    3
> >  b/drivers/media/video/omap/camera_core.c   |   11
> >  b/drivers/media/video/omap/camera_core.h   |    3
> >  drivers/media/video/omap/camera_core.c     |   13
> >  drivers/media/video/omap/h3_sensor_power.c |   63 -
> >  drivers/media/video/omap/h3sensorpower.h   |   17
> >  drivers/media/video/omap/h4_sensor_power.c |   76 -
> >  drivers/media/video/omap/h4sensorpower.h   |   17
> >  drivers/media/video/omap/ov9640.h          |  179 ----
> >  drivers/media/video/omap/sensor_if.h       |   50 -
> >  drivers/media/video/omap/sensor_ov9640.c   | 1221 -----------------------------
> >  11 files changed, 14 insertions(+), 1639 deletions(-)
> >
>
> Pushing thise series today. Is there anything else that can be removed
> now regarding the camera stuff?

The code for the omap1 is clean. All unused files were removed.
However, I'd ask what you think about merging the code of

drivers/media/video/omap/camera_core.[c,h]
drivers/media/video/omap/omap16xxcam.[c,h]

and removing the drivers/media/video/omap/ directory. I'm suggesting
this change 'cause the code for omap2 is outside this directory.

>
> Tony
>



-- 
Eduardo Bezerra Valentin
