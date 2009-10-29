From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
	locks for dma_op_mode
Date: Thu, 29 Oct 2009 08:35:51 +0200
Message-ID: <200910290835.51475.peter.ujfalusi@nokia.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910280752.23859.peter.ujfalusi@nokia.com>
	<1256712814.30157.388.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1256712814.30157.388.camel@eenurkka-desktop>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 28 October 2009 08:53:34 Nurkkala Eero.An (EXT-Offcode/Oulu) w=
rote:
> Yeah, maybe I took the SMP safeness into play without looking any code,
> my bad =3D) I was remembering a different version of this McBSP thing, now
> that I looked into it, it looked different.
> =

> Right, I reviewed the code, and it was first looking really bad at
> sound/soc/omap/omap-mcbsp.c, where it calls omap_mcbsp_get_dma_op_mode()
> from different places. However, it's not an issue because in:
> arch/arm/plat-omap/mcbsp.c : dma_op_mode_store(),
> the dma_op_mode is written only if the mcbsp is unoccupied. So it is SMP
> safe.
> =

> ..and a single read is always atomic, so this is buggy code:
> =

> 301         spin_lock_irq(&mcbsp->lock);
> 302         dma_op_mode =3D mcbsp->dma_op_mode;
> 303         spin_unlock_irq(&mcbsp->lock);
> 304
> 305         return dma_op_mode;
> =

> The spinlocks are unnecessary. In the above example, you get the same
> with just "return mcbsp->dma_op_mode;"
> =

> -> Peter's patch is a good cleanup.

Jarkko: are we going to take this?


-- =

P=E9ter
