From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Wed, 5 Aug 2009 09:45:21 +0300
Message-ID: <200908050945.22160.peter.ujfalusi@nokia.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<20090803181405.6249b843.jhnikula@gmail.com>
	<200908042246.09919.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200908042246.09919.jkrzyszt@tis.icnet.pl>
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
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun K S <arunks@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tuesday 04 August 2009 23:46:09 ext Janusz Krzysztofik wrote:

> I have temporarily modified those omap_mcbsp_pollwrite/_pollread() to do
> nothing but reporting, put them into omap_mcbsp_dai_trigger() as before a=
nd
> additionally into a newly created and registered omap_mcbsp_dai_prepare(),
> called before omap_start_dma(), and got the following result:
>
> For both playback start while capturing and capture start while playing,
> XSYNC_ERR/RSYNC_ERR is clear
> and XRDY/RRDY is ready,

This means that XRDY/RRDY is set (1)?

> respectively, both
> before and after omap_start_dma(). No DMA transfer is actually started, so
> the operation fails with i/o error.

In case of playback start while capture: What is the state of the XEMPTY bi=
t =

(SPCR2:2)? Is it 0? It should.

>
> My interpretation based on my SPRU592 and SPRU674 understanding:
>
> While starting the first stream, omap_mcbsp_start(), called by
> omap_mcbsp_dai_trigger(), instructs McBSP to start shifting bits in both
> directions, no matter which one has just been requested. After that, the
> direction, for which a corresponding DMA transfer has just been started
> from omap_pcm_trigger() with omap_start_dma(), starts doing its job, while
> the opposite direction, after shifting in one word in case of capture,
> issues a DMA event that is missed and waits for an I/O to occur.
>
> Then, when omap_pcm_trigger() starts DMA for the opposite direction, the
> DMA controller, configured for synchronized transfer, waits for a
> corresponding DMA event before it performs its first I/O operation. That
> event already occurred far before and will not occur again, so the transf=
er
> will not start without any intervention. This time, omap_mcbsp_start() is
> not called again for an already started hardware action (correct), so the=
re
> is no chance for the transfer to start that way.

I think the reason is quite simple: on OMAP1 the DMA request is edge sensit=
ive =

(compared to OMAP2 and OMAP3 where it is level based). This means:
When you start the capture, both RX and TX is started. Since the playback i=
s not =

running, no data will be written to the DXR register, McBSP asserts the DMA =

request line, but since there is no DMA configured for playback it  stays h=
igh =

(and McBSP will shift out 0). Now if you start the playback (using DMA) the=
 DMA =

engine waits for a pulse on the request line, which will not occur, the req=
uest =

line is asserted, so the DMA will not start pushing any data to the McBSP D=
XR =

register.
Now if you force write to the DXR register, than it de-asserts the DMA requ=
est =

line, when the DXR -> XSR copy has been done, McBSP asserts the DMA request =

line, which will kick the DMA engine to push data to DXR register and the =

playback will start.

>
> With my patch, performing an I/O operation by calling
> omap_mcbsp_pollwrite/_pollread() forces McBSP to issue next DMA event, th=
at
> initiates the transfer.

The danger with the pollwrite/pollread is:
If the stream is not mono, than you kind of ensure a certain channel shift =

(channel switch in case of stereo stream).

>
> While starting both streams (semi)simultaneously, it may happen that the
> DMA event for the opposite direction will occur after the DMA has just be=
en
> started for that direction as well and will not be missed, so both streams
> will run correctly.

Yep, this is kind of a race condition (in a good way): Most likely both DMA=
 has =

been started before the McBSP ports asserted their DMA request lines, so th=
e DMA =

engine will push or read the data correctly.

>
> Does it make sense, or am I missing something?
>
> If my analysis is correct, the best solution I can see would be starting
> McBSP transfer for one direction only, not both, so the opposite direction
> can be started when needed. That requires deeper and wider OMAP knowledge
> and a change in omap_mcbsp_start() API though. I am not in a position to
> deal with this myself, I'm afraid.

I agree, this would be the best solution for the problem.

>
> Thanks,
> Janusz
>
> PS: Not CCing arch/arm/plat-omap/mcbsp.c author as his email address is
> probably out-of-date.

-- =

P=E9ter
