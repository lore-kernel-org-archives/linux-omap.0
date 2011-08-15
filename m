From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/4] ASoC: OMAP4: McPDM: Fix legacy support
Date: Mon, 15 Aug 2011 14:28:53 +0300
Message-ID: <2097801.ze7cveM5xx@barack>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
	<1454327.U3ERne0amE@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1454327.U3ERne0amE@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Brown <broonie@opensource.wolfsonmicro.com>, "Guiriec,
	Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 09 August 2011 09:27:17 Ujfalusi, Peter wrote:
> Hi Tony,
> =

> On Tuesday 02 August 2011 13:34:13 Ujfalusi, Peter wrote:
> > Hello,
> > =

> > The OMAP4 McPDM driver in upstream has been broken for some time...
> > This series fixes that, and enables basic audio playback/capture over
> > the
> > mcpdm interface.
> =

> Would you have time to look at this series?
> Specially patch 1 (maybe 2 as well).
> We are planning to send this series through audio for 3.1.

Do you have time to look at this series.
Currently the mcpdm (omap4 audio) is broken in upstream without this series=
, =

and I'd like to have it fixed in time for 3.1.
 =

> > Two patch in this series has been taken from the "OMAP4/ASoC: New McPDM
> > driver" series (patch 1, and 2) [1]. Since I was on holiday, I did not
> > had time to rewrite the driver rewrite patch, but I feel that fixing
> > the basic audio support for OMAP4 is needed.
> > The aim here is to have working audio in upstream kernel for 3.1, and
> > have the new McPDM driver stack up for the 3.2 release.

Thank you,
P=E9ter
