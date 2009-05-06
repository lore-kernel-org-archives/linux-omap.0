From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Beep sound in the end of audio file
Date: Wed, 6 May 2009 19:30:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030555A348@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<200905060833.10998.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905060833.10998.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Wednesday, May 06, 2009 11:03 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org
> Subject: Re: Beep sound in the end of audio file
> =

> Hello,
> =

> On Tuesday 05 May 2009 20:03:57 ext Aggarwal, Anuj wrote:
> > Hi,
> >
> > After playing out any audio file on OMAP3 EVM, having TWL4030 codec,
> > I am hearing a beep sound. I have also tried implementing a mute functi=
on
> > in which I disabled all the inputs/outputs but still that didn't help.
> >
> > Any idea how this can be avoided?
> =

> I have not heard from this kind of problem so far, which does not mean, t=
hat
> it does not exist ;)
> Can you describe the beep sound?
[Aggarwal, Anuj] It's kind of a "tuck" sound coming in the end, after 1 or =
 2 seconds.
> =

> After a quick look I can not pin point the soc board file used with the
> omap3evm board. Is it in the tree?
[Aggarwal, Anuj] No, it is not. Reason being we already have beagle & =

sdp3430 there, which are both similar to omap3evm, which I pushed. =

So mine got rejected. We had some discussions on how to handle this
scenario but nothing got finalized.
> =

> Does the beep happens in these cases also (after stopping it with Ctrl+C):
> aplay -f dat /dev/zero
> aplay -f dat /dev/urandom
[Aggarwal, Anuj] Yes, it comes in both the cases.
> =

> =

> CC-ing alsa-devel...
> =

> >
> > Thanks and Regards,
> > Anuj Aggarwal
> >
> > Platform Support Products
> > Texas Instruments Incorporated
> =

> =

> --
> P=E9ter
