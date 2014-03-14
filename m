From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/18] edma/ASoC: dmaengine PCM for AM335x and AM447x
Date: Fri, 14 Mar 2014 11:38:58 +0200
Message-ID: <5322CE32.2000102@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <20140313134601.GU366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140313134601.GU366@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, joelf@ti.com, vinod.koul@intel.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, mporter@linaro.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2014 03:46 PM, Mark Brown wrote:
> On Thu, Mar 13, 2014 at 11:18:22AM +0200, Peter Ujfalusi wrote:
> =

>> With this series AM335x and AM447x will use the dmaengine PCM for audio.=
 The
>> daVinci devices will keep using the davinci-pcm for now since I do not h=
ave
>> means to test them but the code is written in a way that they can be swi=
tched
>> to use the edma-pcm easily (DA850/OMAP-L138 has been tested and audio was
>> working fine).
> =

> Can you please not resend the ASoC portions of this series until the
> EDMA portion is stable (and ideally committed)?  I'm not quite sure why
> but every EDMA patch series seems to go through lots of iterations which
> gets rather noisy - my initial reaction to seeing EDMA in a subject is
> to just delete the thread.

Sure, I'm not planning to spam alsa-devel however the switch to dmaengine P=
CM
for AM335x/AM447x needs the edma patches, otherwise it is not going to work.
AFAIK I have not sent patch to edma as of now so I have no idea how long it
takes to get stuff in (the good thing is that the edma part does not touch =
DT,
which is alone can reduce the number of iterations).
Anyway, what I can - and already did is:
Reorder the ASoC patches and I can leave out the switch to dmaengine PCM pa=
tch
for davinci-mcasp for now. The edma-pcm and the other patches for McASP can=
 go
in right away (I will not add the edma-pcm to the Makefile/Kconfig to avoid
issues).

I will detach the edma stuff and follow it up outside of alsa-devel.

The only thing I'm afraid off is that it is going to take two release cycle=
 to
get this in: first cycle edma part, next cycle for the ASoC to switch to use
the edma-pcm.

-- =

P=E9ter
