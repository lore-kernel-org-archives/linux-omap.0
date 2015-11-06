From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Sat, 7 Nov 2015 09:19:25 +1100
Message-ID: <20151107091925.7dcd14a7@canb.auug.org.au>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tyler Baker <tyler.baker@linaro.org>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>, Olof Johansson <olof@lixom.net>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Fri, 6 Nov 2015 10:36:34 -0800 Kevin Hilman <khilman@kernel.org> wrote:
>
> On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> > which breaks the omap3 device tree build due to a wrong reference.
> >
> > I accidently queued this change via the power supply subsystem while
> > telling Marek at the same time, that it should go through Tony's tree.
> > Following that I did miss Stephen's messages about the build failure in
> > linux-next and since he switched to merging an older snapshot nobody
> > else noticed the problem in my tree. I didn't notice myself, since I
> > did not build any device tree files assuming none have changed by me.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>  
> 
> We also found this in kernelci.org build testing, and verified that
> this fixes the build.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Thanks Felipe for reporting, and thanks Sebastian for the quick fix.

I think "quick fix" is a bit rich.  I reported this to Sebastian on
Sept 29, Oct 2 , Oct 8, Oct 16, and Oct 21.  The only response I got
was from Marek Belisko on Oct 8 and 21.  I have been using the battery
tree (git://git.infradead.org/battery-2.6.git#master) from Sept 25, so
none of the commits after that have been in any linux-next release.

Yes, I am a little annoyed.  Do people have trouble receiving my emails?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
