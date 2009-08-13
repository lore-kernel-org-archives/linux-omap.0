From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
	selection
Date: Thu, 13 Aug 2009 09:01:24 +0300
Message-ID: <200908130901.25420.peter.ujfalusi@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<20090812144547.eb4bf7f2.jhnikula@gmail.com>
	<1250077713.16045.31.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250077713.16045.31.camel@eenurkka-desktop>
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
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 August 2009 14:48:33 Nurkkala Eero.An (EXT-Offcode/Oulu) wr=
ote:
> On Wed, 2009-08-12 at 13:45 +0200, ext Jarkko Nikula wrote:
> > The threshold based transfer will cause that omap_pcm_pointer will
> > loose a bit its accuracy. Probably irrelevant but still better to play
> > safe at least over one kernel release before making it default.
>
> No, it doesn't loose accuracy =3D) It's as accurate with both modes.
> The difference is, that the other does things in bursts;

In element mode it is kind of easy to estimate where the hardware actually =
in =

the playback case (aplay -f dat /dev/zero):

omap_pcm_pointer returns 669, than the HW is around
669-512=3D157 (plus few samples).

In threshold mode you only know that the HW is playing in between 0-512, =

512-1024 somewhere.

I know neither of these are accurate and these examples are quite =

oversimplified, but there is a difference and that difference is quite =

significant.

> that's called evolution rather than regression =3D)

Note that evolution can also introduce regression...

> That's how things will be in the future =3D)

I agree with you on this, since the threshold mode provides quite good powe=
r =

saving benefits.
But on the other hand it would be still better to keep the element mode as =

default for at least one release cycle.
If no report is coming about problems, than we can make the threshold mode =
for =

McBSP2 as the default

-- =

P=E9ter
