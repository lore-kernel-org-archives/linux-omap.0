From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Fri, 6 Nov 2015 10:36:34 -0800
Message-ID: <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446826430-3705-1-git-send-email-sre@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>, Tyler Baker <tyler.baker@linaro.org>, Felipe Balbi <balbi@ti.com>, Olof Johansson <olof@lixom.net>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrote:
> This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> which breaks the omap3 device tree build due to a wrong reference.
>
> I accidently queued this change via the power supply subsystem while
> telling Marek at the same time, that it should go through Tony's tree.
> Following that I did miss Stephen's messages about the build failure in
> linux-next and since he switched to merging an older snapshot nobody
> else noticed the problem in my tree. I didn't notice myself, since I
> did not build any device tree files assuming none have changed by me.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

We also found this in kernelci.org build testing, and verified that
this fixes the build.

Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks Felipe for reporting, and thanks Sebastian for the quick fix.

Kevin
