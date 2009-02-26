From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 EVM
Date: Thu, 26 Feb 2009 09:36:54 +0200
Message-ID: <200902260936.54301.peter.ujfalusi@nokia.com>
References: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com>
	<20081125145257.GD12414@sirena.org.uk>
	<20090225202559.GO4368@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090225202559.GO4368@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext George G. Davis" <gdavis@mvista.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, Mark Brown <broonie@sirena.org.uk>, ext Anuj Aggarwal <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Misael Lopez Cruz <mesak82@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 February 2009 22:25:59 ext George G. Davis wrote:
> Hi,
>
> On Tue, Nov 25, 2008 at 02:52:58PM +0000, Mark Brown wrote:
> > On Tue, Nov 25, 2008 at 01:21:20PM +0200, Jarkko Nikula wrote:
> > > Or if those EVM's & SDP's can route TWL4030 audio connections more
> > > flexible than Beagle but somewhat similar manner, then probably have
> > > one single machine driver for all EVM's?
> > >
> > > Otherwise it doesn't make very much sense to have n similar machine
> > > drivers where only functions and variable names differ.
> >
> > Yes, it looks like a lot of these drivers could be redone along the
> > lines of s3c24xx_uda134x.c with platform data specifying the differences
> > between the boards.
>
> Is someone working on updating ASoC drivers for OMAP TWL4030 based
> boards as recommended above?  Just curious since I already made the
> mistake of creating my own OMAP3 EVM ASoC driver w/o checking the
> list first.  : /

Well, I have checked the s3c24xx_uda134x.c and the corresponding uda134x.c =

codec driver. In case of the uda134x codec - since it does not have DAPM =

implementation, the board file does not need to deal with the output/input =

pins.
In case of boards using the TWL4030 codec it is not that simple IMHO.
You see TWL4030 has nine output 'pins' and six (plus 2x stereo digital mic) =

input 'pins'. =

So, yes it is doable, but will it make things cleaner and more manageable?
Few things came to my mind, which needs to be addressed:
1. Who is the master (OMAP McBSP or TWL4030)?
2. What is the reference clock in the given board
3.  Connected pins (or not connected pins)
4.  I2S or TDM mode (this is not implemented yet, but it is coming at some =

point)

It easy to provide 1, 2 and 4. But when it comes to 3... One needs to build=
 up =

the DAPM routes in the common board file for the supported boards, which ag=
ain =

doable based on - for example  - some model/board ID, but I think it will l=
ook =

ugly.

Or I might over complicate things ;) =


> --
> Regards,
> George

-- =

P=E9ter
