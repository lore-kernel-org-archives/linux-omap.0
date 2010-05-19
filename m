From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode
	updates for ASoC
Date: Wed, 19 May 2010 15:09:06 +0300
Message-ID: <201005191509.06739.peter.ujfalusi@nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<201005191436.52149.peter.ujfalusi@nokia.com>
	<20100519114640.GP4265@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100519114640.GP4265@besouro.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Wednesday 19 May 2010 14:46:40 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> On Wed, May 19, 2010 at 01:36:51PM +0200, Ujfalusi Peter (Nokia-D/Tampere=
) =

wrote:
> > On Wednesday 19 May 2010 13:52:27 Valentin Eduardo (Nokia-D/Helsinki) w=
rote:
> > > > The DMA pointer is easy, and it was know before as well, but
> > > > according to my tests, the McBSP FIFO caused delay reporting is
> > > > fairly accurate. I'll ask my users, if they have done some
> > > > additional tests.
> > > =

> > > OK. fair enough. What if you really want to avoid the delay at all?
> > =

> > You can't. the McBSP FIFO can not be bypassed.
> > The only thing one can do is to take it into consideration.
> =

> hmmm well, you can still do not use the fifo completely. Use only partial=
ly
> depending on latency requirement would still be possible.

Ah, you mean the idea, where in DMA completion interrupt we configure the M=
cBSP =

threshold to maximum, and on McBSP FIFO empty interrupt, we configurre back=
 the =

threshold to what the level we want to use from McBSP, and start the DMA?
This all has to be done 'manually', and if there is _any_ latency in the ke=
rnel, =

than we have channel switch, glitch, pause, and whatnot..
I remember, we tried that, and well, did not worked that reliable.

-- =

P=E9ter
