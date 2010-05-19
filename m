From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode
	updates for ASoC
Date: Wed, 19 May 2010 11:31:57 +0300
Message-ID: <201005191131.58167.peter.ujfalusi@nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<20100519081325.6e341075.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100519081325.6e341075.jhnikula@gmail.com>
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
Cc: Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Wednesday 19 May 2010 08:13:25 ext Jarkko Nikula wrote:
> On Tue, 18 May 2010 21:13:10 +0100
> =

> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > I've also added a patch to remove the mcbsp DMA op mode sysfs set
> > functionality. I think DMA op mode is very specific to the mcbsp client
> > driver _only_ and shouldn't really be changed by userspace. Please let
> > me know if you use this feature and I'll drop this patch.
> =

> I've used to say that the DMA op mode is more like use-case not machine
> specific but I'm not sure is my point valid onemore. I've used to think
> that low-latency processing would need accurate DMA pointer (op
> mode =3D=3D element) while mp3 playback would need low power consumption
> (op mode =3D=3D threshold).

Yeah, it used to be so clear ;)
I see these:
element mode: if user want to have constant latency [1]
threshold mode: variable latency, but possibility to save power [2]

[1] The McBSP is kept full during playback (and empty during capture)
The DMA pointer moves word-by-word

[2] The McBSP FIFO fill rate changes (full, drain, refill, full, drain...)
The DMA pointer moves in bursts.
Between burst memories can relax, core, MPU also in theory.
Smart idle helps to conserve more power here

> Peter: what's the status today how well can we do low-latency
> processing with threshold mode? IRCC, with your FIFO delay query
> patches, can we estimate the DMA pointer position with enough accuracy?

The DMA pointer is easy, and it was know before as well, but according to m=
y =

tests, the McBSP FIFO caused delay reporting is fairly accurate.
I'll ask my users, if they have done some additional tests.

-- =

P=E9ter
