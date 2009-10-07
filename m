From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
	codec
Date: Wed, 7 Oct 2009 10:32:36 +0300
Message-ID: <200910071032.36999.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
	<67059DBF19D7214F9C66BB0EA91BA90E90C2F931@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90C2F931@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Krishnamoorthy,
	Balaji T" <balajitk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 October 2009 19:53:03 ext Lopez Cruz, Misael wrote:
> Peter Ujfalusi wrote:
> > How does the twl4030 series would fit with this modification?
> > I have also added the twl4030 codec as a child for the twl
> > MFD, but I have not finished the cleanup of the codec fully.
> =

> twl6030 codec data won't conflict with twl4030's as it's dependent of
> TWL6030_CORE. We can add parallely the required data for twl4030 codec.

I see. I think I'll wait till the twl6030 codec and it's dependencies are i=
n =

place, than I can start adding the needed code for the twl4030 codec as wel=
l.

Obviously this is needed for the clean up of twl4030 codec and get it to mo=
re =

sane form.

Thanks,
P=E9ter
