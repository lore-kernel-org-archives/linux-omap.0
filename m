From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2 0/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 16:04:35 +0200
Message-ID: <201002181604.36160.peter.ujfalusi@nokia.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100218150621.b88387a7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100218150621.b88387a7.jhnikula@gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 18 February 2010 15:06:21 ext Jarkko Nikula wrote:
> On Wed, 17 Feb 2010 16:45:58 +0200
> =

> Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:
> > The first patch implements McBSP sidetone feature on OMAP3 while the
> > second one provides ALSA interface for using it.
> =

> Do I have something wrong since I cannot adjust the controls? Both
> "McBSP2 Sidetone Channel [0|1]" show 50%.

Hmmm, at least there is no way to set the ch1 gain...
I'll comment in the patch.

> =

> I used line wrapped diff below.

-- =

P=E9ter
