From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 08:48:25 +0300
Message-ID: <200905070848.25904.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030555A348@dbde02.ent.ti.com>
	<1241619589.8928.2038.camel@sax-lx.fischerfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1241619589.8928.2038.camel@sax-lx.fischerfamily.org>
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
To: "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 May 2009 17:19:49 ext Todd Fischer wrote:
> Hi,
>
> FWIW: while developing a GSTreamer presentation using a BegleBoard (rev C=
),
> I noticed the same "tuck" sound.  It also occurs a second or two after the
> GST application exits.  I assumed it was some power management code that
> was disabling the audio codec after it had gone idle, but never looked in=
to
> it.  BeagleBoard also uses TWL4030.
>
> GST command: gst-launch audiotestsrc freq=3D1000 num-buffers=3D100 ! alsa=
sink
>
> /proc/version: Linux version 2.6.28-omap1 (ddompe@Aleph) (gcc version 4.3=
.1
> (GCC) ) #2 Thu Mar 5 08:55:58 CST 2009

The "tuck" is coming from the codec, when it is powered down (in the old =

twl4030 codec found in omap-2.6.28 branch of linux-omap).
But, it still happens with the latest version, when the codec is muted only.
I can observe the "tuck" on Headset output, but not on the PreDrive...
The Headset enable and disable is implemented according to the TRM, but it =

seams that additional tweaking is needed..

-- =

P=E9ter
