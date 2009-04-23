From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 12:20:14 +0300
Message-ID: <200904231220.14465.peter.ujfalusi@nokia.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
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
To: ext twebb <taliaferro62@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 22 April 2009 20:58:01 ext twebb wrote:
> Problem 2:
> Test tone is being presented by the user application, providing a 1Khz
> tone sampled at 44.1Khz. The data are S16_LE, right channel only. Left
> channel is quiet. The data seems to slip back and forth from left to
> right channel. This is reproducable and verified with a scope trace.
>
> Anybody have any ideas what might be going wrong here?  Traces for
> codec reg dump and mcbsp are attached.

As Jarkko already asked: are you seeing the channel switch while running or=
 is =

it happens on playback start?

AFAIK this phenomena can be also seen on Beagle board.

I have done some investigation regarding to these, but so far I can not say =

that I know what causes it.

BTW: these are separate issues (startup switch and runtime switch).

> Thanks,
> twebb

-- =

P=E9ter
