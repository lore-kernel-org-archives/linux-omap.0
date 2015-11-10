From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Re: Minimal support for dm814x
Date: Tue, 10 Nov 2015 11:23:35 +0100
Message-ID: <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
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

On 10 Nov 2015, at 09:50, Matthijs van Duin <matthijsvanduin@gmail.com> wro=
te:
> On 9 November 2015 at 16:06, Tony Lindgren <tony@atomide.com> wrote:
>> The PLL support is still missing, so it relies on the bootloader
>> configured PLL values for now. I'm hoping to post PLL support patches ov=
er
>> next few weeks and then we can have that and more devices working for v4=
.5.
> =

> Ah, yes, configuring a DPLL-LJ is fun.. figuring out how to write the
> desired ratio as M/(M2*(1+N)) while simultaneously satisfying all
> constraints on M, N, M2, refclk, and dco. :-)

Yes, indeed. We have the additional requirement of being able to adjust the=
 frequency (by a relatively small amount) without loss of lock. Recalculati=
ng the DCO mode and M,N,M2 from scratch each time based on the target frequ=
ency, like was done in the 2.6.37 based tree from TI was not acceptable, so=
 we try to change m2 first to see if we can reach the target frequency and =
fall back to recalculate parameters from scratch if that fails.

BTW, are you aware of section 2.1.2 of =93TMS320DM814x DaVinci Digital Medi=
a Processors Silicon Revisions 3.0, 2.1=94? <http://www.ti.com/lit/er/sprz3=
43c/sprz343c.pdf>

Regards
=97
Delio
