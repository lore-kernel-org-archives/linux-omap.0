From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 16:46:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030555A662@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<1241619589.8928.2038.camel@sax-lx.fischerfamily.org>
	<200905070848.25904.peter.ujfalusi@nokia.com>
	<200905071408.14629.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905071408.14629.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Thursday, May 07, 2009 4:38 PM
> To: alsa-devel@alsa-project.org
> Cc: todd.fischer@ridgerun.com; Aggarwal, Anuj; linux-omap@vger.kernel.org
> Subject: Re: [alsa-devel] Beep sound in the end of audio file
> =

> On Thursday 07 May 2009 08:48:25 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> > On Wednesday 06 May 2009 17:19:49 ext Todd Fischer wrote:
> > > Hi,
> > >
> > > FWIW: while developing a GSTreamer presentation using a BegleBoard
> (rev
> > > C), I noticed the same "tuck" sound.  It also occurs a second or two
> > > after the GST application exits.  I assumed it was some power
> management
> > > code that was disabling the audio codec after it had gone idle, but n=
ever
> > > looked into it.  BeagleBoard also uses TWL4030.
> > >
> > > GST command: gst-launch audiotestsrc freq=3D1000 num-buffers=3D100 !
> alsasink
> > >
> > > /proc/version: Linux version 2.6.28-omap1 (ddompe@Aleph) (gcc version
> > > 4.3.1 (GCC) ) #2 Thu Mar 5 08:55:58 CST 2009
> >
> > The "tuck" is coming from the codec, when it is powered down (in the old
> > twl4030 codec found in omap-2.6.28 branch of linux-omap).
> > But, it still happens with the latest version, when the codec is muted
> > only. I can observe the "tuck" on Headset output, but not on the
> > PreDrive... The Headset enable and disable is implemented according to =
the
> > TRM, but it seams that additional tweaking is needed..
> =

> I need to revisit this...
> After more testing and debugging, it seams that I can not confirm the
> existence of the "tuck" (with the latest twl4030  codec code).
> As soon as I receive my Beagle board I will test it again (can anyone test
> this with latest ASoC code on Beagle?)...
> =

> [Anuj]: What kernel are you using where you have the beep?
[Aggarwal, Anuj] 2.6.29-rc3
> =

> --
> P=E9ter
