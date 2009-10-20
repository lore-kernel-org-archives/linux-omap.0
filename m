From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/4=5D_MFD=3A_twl4030=3A_add?=
 =?iso-8859-1?q?_twl4030=5Fcodec_MFD_as_a_new_child=09to_the_core?=
Date: Tue, 20 Oct 2009 14:16:15 +0300
Message-ID: <200910201416.15172.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091020100334.GA28592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091020100334.GA28592@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 October 2009 13:03:34 ext Mark Brown wrote:
> On Mon, Oct 19, 2009 at 03:42:17PM +0300, Peter Ujfalusi wrote:
> > New MFD child to twl4030 MFD device.
> > This MFD device will be used by the drivers, which needs resources
> > from the twl4030 codec like audio and vibra.
> >
> > The platform specific configuration data is passed along to the
> > child drivers (audio, vibra).
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> >
> > +config TWL4030_CODEC
> > +	bool "Support codec part of the TWL4030 family chips"
> =

> This seems like something that users shouldn't really have to worry
> about selecting explicitly - might it be better to have it selected by
> the drivers that use it instead?  It feels like it's an implementation
> detail of the driver.

Yes, first I had the TWL4030_CODEC selected in the sound/soc/codecs/Kconfig=
, but =

for some reason I have decided to add user selectable config option instead=
 and =

use the depends on in the codecs Makefile.
I'll make the change as you suggested.


-- =

P=E9ter
