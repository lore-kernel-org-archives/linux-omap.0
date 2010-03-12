From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay (latency)
	handling in soc/omap
Date: Fri, 12 Mar 2010 08:18:30 +0200
Message-ID: <201003120818.30290.peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100311222655.GP2900@atomide.com>
	<186E584F-F553-44F0-A49D-361BB76E0EE4@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <186E584F-F553-44F0-A49D-361BB76E0EE4@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Friday 12 March 2010 00:43:41 ext Mark Brown wrote:

> I can do, though there was some debate about how useful the
> information the hardware returns actually is - could folks confirm
> what the consensus there was, please?

Yeah, that thread went silent without final go or no go...

I do agree with Eero, that the BUFFSTAT register is not the most reliable s=
ource =

of information, but I still believe that the way we are going to use it wil=
l =

give pretty close to the reality estimation on the statuses.
Eero also mentioned timestamp based estimation, which I think can also be u=
sed =

in this way:
In element mode, we just return the delay as the whole size of the buffer (=
which =

is not accurate when we initially fill the buffer, and when we drain it at =
the =

end, but it is not a real problem).
In threshold mode, than we can take timestamp at DMA completion interrupts,=
 and =

calculate the delay based on the FIFO size (FIFO size - samples played out =
since =

the last timstamp). This can also give false numbers at the start of the =

playback (for few periods, until the buffer utilization settles).

So the timestamp based solution looks good, but it is only usable when the =
codec =

is running synchronously. It will definitely falls apart as soon as we use =
a =

codec like tlv320dac33 in burst mode (FIFO on the codec as well).
We could have ~100 ms between DMA interrupts, so the countdown for McBSP FI=
FO =

usage is already broken.
Furthermore since there is no way at the moment to actually synchronize the =

omap-mcbsp, omap-pcm and tlv320dac33 (in DMA, McBSP threshold, McBSP mode a=
nd =

DAC33 mode sense), there could be cases, that this big silence on the bus (=
when =

DAC33 is playing from it's buffer) is not happening exactly after the DMA f=
illed =

up the McBSP FIFO, but a bit later (could be just one sample away from the =
next =

McBSP threshold event), which means that the McBSP FIFO is nowhere near to =
be =

full.
In this case the BUFFSTAT register would give good estimation, than any =

timestamp based solution for McBSP FIFO.

All in all, I think the usage of the BUFFSTAT register is a good compromise=
 for =

all cases, and it is needed for the cases, where the codec also have buffer=
 of =

it's own.
Never the less, we can also add the timestamp based estimation later, but w=
e =

need to make sure, that those can be picked somehow for the given setup.

-- =

P=E9ter
