From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
	locks for dma_op_mode
Date: Wed, 28 Oct 2009 07:52:23 +0200
Message-ID: <200910280752.23859.peter.ujfalusi@nokia.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
	<20091027160000.f276e706.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091027160000.f276e706.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 October 2009 16:00:00 ext Jarkko Nikula wrote:
> On Tue, 27 Oct 2009 13:07:23 +0200
> =

> Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:
> > Otherwise, that spinlocking is highly unnecessary and things are
> > far better without than with it. The only case it could be useful
> > is in SMPs, but OMAPs are not such quite yet - and when they
> > are, things will need to be re-though anyway.
> =

> Following commit is suggesting that mcbsp code *must* be SMP safe
> already now:
> =

> commit a5b92cc348299c20be215b9f4b50853ecfbf3864
> Author: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Date:   Tue Jul 28 18:57:10 2009 +0530
> =

>     ARM: OMAP4: Add McBSP support

Yeah, but I think this locking issue has nothing to do with SMP safe or not.
On playback start in omap_mcbsp_request the mcbsp->free is cleared.
Further modification to the dma_op_mode in dma_op_mode_store is not allowed=
 if =

the mcbsp port is in use, thus the dma_op_mode is protected against change =
while =

the port is in use (ensuring that the mode is same in omap34xx_mcbsp_reques=
t and =

omap_mcbsp_get_dma_op_mode functions). This alone makes the use of spinlock =

around the dma_op_mode unnecessary.

-- =

P=E9ter
