From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 00/18] OMAP: DSS2: Intro
Date: Mon, 31 Aug 2009 12:23:51 +0300
Message-ID: <4A9B96A7.5040005@gmail.com>
References: <1251462337-12531-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753494AbZHaJ0f@vger.kernel.org>
In-Reply-To: <1251462337-12531-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/28/2009 03:25 PM, Tomi Valkeinen wrote:
> This patch set implement new display subsystem driver (DSS2) and omap=
fb driver
> for OMAP2/3. The patches have been reviewed on linux-omap and linux-f=
bdev-devel
> mailing lists. The patches can also be found from
> http://gitorious.org/linux-omap-dss2/linux
>
> The patches include DSS documentation patch that includes more instru=
ctions for
> module parameters, sysfs files etc.
>
> The patches enable DSS2 for OMAP3430 SDP board. DSS2 is used in vario=
us boards,
> for example Nokia N900, Beagle Board and Overo.
>
> I don't currently have any OMAP2 board to test DSS2, but it has worke=
d on OMAP2
> and the possible fixes needed should be minimal.
>
> OMAP1 is not supported, and so the old DSS needs to be used on OMAP1 =
boards.
>
> DSS2 is partly based on the old omapfb driver by Imre Deak, and Imre =
has also
> contributed to DSS2 quite a bit. Ville Syrj=C3=A4l=C3=A4 has been con=
tributing to scaling
> and tv-out work. Also some contributions have been made by Hardik Sha=
h, Vaibhav
> Hiremath, and perhaps some others that I have forgotten =3D).

Tony, Andrew,

how could we merge this code (unless there are requests to change somet=
hing, which
does not seem to be the case.). It seems like there is no maintainer wh=
o could
merge this. Or there is? Would Tomi need to send a direct pull request =
to Linus,
or this could got via Tony?

We are using DSS2 in Nokia for about a year already. N900 is using this
code, for example. Other (non-Nokia) projects are using DSS2 as well.
The code was public for long time and was sent several times for review=
=2E

In any case,

Tested-by: Artem Bityutskiy <artem.bityutskiy@nokia.com>

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
