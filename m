From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Re: Minimal support for dm814x
Date: Wed, 18 Nov 2015 12:09:42 +0100
Message-ID: <78B56424-A35F-495E-B9AA-1638AC37359D@audioscience.com>
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
 <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
 <D5E377BD-5AAE-4302-B2C3-2B17A00892B5@audioscience.com>
 <CAALWOA8bEeLtO-QmyiS9H-z2-pToc-HY3HPuTEsmvZ2BSWf75Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAALWOA8bEeLtO-QmyiS9H-z2-pToc-HY3HPuTEsmvZ2BSWf75Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 18 Nov 2015, at 11:01, Matthijs van Duin <matthijsvanduin@gmail.com> wro=
te:
> On 18 November 2015 at 09:26, Delio Brignoli <dbrignoli@audioscience.com>=
 wrote:
>>> This works in principle, but both minimizing the DCO and (often
>>> needlessly) using the fractional multiplier seem like recipes to
>>> maximize the clock jitter. Mind you, I don't know how much jitter
>>> we=92re talking about here, I don't recall having seen specs about this.
>> =

>> We haven=92t seen any specs either but testing shows that changing DCO m=
ode causes
>> the PLL to lose lock at least temporarily.
> =

> Losing lock on reconfiguration is entirely a separate matter from
> clock jitter.

Sure, I just wanted to report a case in which the implementation you mentio=
n does something which may be undesirable.

> The fractional multiplier works by essentially by
> alternating between the nearest integer multiplier values. This will
> be smoothed out by the loop filter, but it=92s not going to vanish.

[=85]

> Now DPLLLJ will presumably do better, but without actual specs the
> safe option is to avoid the fractional multiplier altogether.

Still FYI, using adpll_ti814x.c from the linux-omap3 tree from the Arago pr=
oject (i.e. the one you are talking about) hacked to prefer searching for n=
eighbouring m2 values to DCO switching works OK for us (i.e. resulting jitt=
er is low enough for our audio applications).

=97
Delio
