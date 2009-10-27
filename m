From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
	locks for dma_op_mode
Date: Tue, 27 Oct 2009 13:17:52 +0200
Message-ID: <200910271317.52638.peter.ujfalusi@nokia.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1256641643.30157.339.camel@eenurkka-desktop>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 October 2009 13:07:23 Nurkkala Eero.An (EXT-Offcode/Oulu) wro=
te:
> On Tue, 2009-10-27 at 12:00 +0100, Ujfalusi Peter (Nokia-D/Tampere)
> =

> wrote:
> > The use of the spin lock, which supposed to protect the the
> > dma_op_mode causing "INFO: inconsistent lock state" on
> > playback start.
> > Remove the spin locks around the dma_op_mode, when it's
> > purpuse is to protect the dma_op_mode.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> =

> You may wish to double read the message above, as it's quite
> confusing =3D)

Yes it is ;)
I have left one spinlock around the dma_op_mode, when it also protects the =

mcbsp->active, so that is why that last sentence.


-- =

P=E9ter
