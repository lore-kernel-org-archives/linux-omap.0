From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Thu, 11 Feb 2010 17:02:54 +0200
Message-ID: <201002111702.54783.peter.ujfalusi@nokia.com>
References: <1265829784-19224-1-git-send-email-swirl@gmx.li>
	<1265885388.3179.8.camel@odin>
	<20100211131418.9521c603.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100211131418.9521c603.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, Thomas Weber <swirl@gmx.li>, "weber@corscience.de" <weber@corscience.de>, "tony@atomride.com" <tony@atomride.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday 11 February 2010 13:14:18 ext Jarkko Nikula wrote:
> On Thu, 11 Feb 2010 10:49:48 +0000
> =

> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > I do agree this makes good sense for boards that are very similar and
> > have different audio options/config, but in this case the ASoC mach
> > drivers are identical (atm). Imo it just makes more sense to keep the
> > one Kconfig.
> =

> Yeah, after thinking twice, we don't have zillions of options for e.g.
> Intel HDA either. If we ever figure out some common OMAP+TWL4030
> driver, the defconfigs are anyway have to modify so it's better stay
> with the original patch:

Well, I really doubt that we can find a way to have a common driver for thi=
s =

combination. You can attach quite a big variety of amps to the outputs (som=
e =

controlled with GPIO, some like the tpa6130 has i2c interface, etc).
To have some kind of "infrastructure" to support all of the possible scenar=
ios =

is just does not worth the effort IMHO.

> =

> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025129=
.h
> tml
> =

> Sorry about line noise, Thomas :-)
> =


-- =

P=E9ter
