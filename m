From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Minimal support for dm814x
Date: Wed, 18 Nov 2015 06:22:27 +0100
Message-ID: <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
 <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
 <20151112174155.GM3218@atomide.com>
 <CAALWOA9o80rhaqwaa6=XxmNN1FcWzHDXiaqkqFVO81CAMX=04w@mail.gmail.com>
 <CAALWOA-29pK=GbNKhdY=4oJzhnueVxNAPruu9Uacqi5vMJN=OA@mail.gmail.com>
 <20151113145216.GC2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151113145216.GC2517@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: linux-omap@vger.kernel.org

On 13 November 2015 at 15:52, Tony Lindgren <tony@atomide.com> wrote:
> I think this is the most recent TI git repo for dm81xx changes:
>
> http://arago-project.org/git/projects/?p=linux-omap3.git;a=summary

Yeah, although I usually prefer to look at the
linux-ipnc-rdk-dm81xx.git and linux-dvr-rdk-dm81xx.git that descend
from it since they include some fixes that the last TI kernel doesn't.
(However they may also include patches specific to the ipnc/dvr
hardware, so some caution is needed.)

Since arago can be sluggish I just mirrored all three branches on github:
https://github.com/dutchanddutch/ti81xx-linux
I've also fixed an obnoxious commit in the ipnc-rdk which changed all
files to mode 755, since this made comparisons rather unpleasant.

The PLL code looks pretty mediocre to me. In particular, they make no
effort whatsoever to configure an exact ratio. It seems their
algorithm uses whatever predivider was already programmed, selects the
minimum postdivider that puts the DCO clock within valid range, and
then approximates the dco/refclk ratio using the fractional
multiplier.

This works in principle, but both minimizing the DCO and (often
needlessly) using the fractional multiplier seem like recipes to
maximize the clock jitter. Mind you, I don't know how much jitter
we're talking about here, I don't recall having seen specs about this.

I also have some concerns about the correctness of the implementation.
I haven't analyzed it in any detail, but repeated occurrences of
expressions of the form   (unsigned long long)( foo * bar )   make me
doubt whether the author realizes this is utterly pointless and will,
for 32-bit arguments, still perform a 32-bit multiplication.

Matthijs
