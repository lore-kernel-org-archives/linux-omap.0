From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Sat, 7 Nov 2015 14:40:40 +1100
Message-ID: <20151107144040.2afa1228@canb.auug.org.au>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
 <20151107091925.7dcd14a7@canb.auug.org.au>
 <20151107024457.GA18676@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151107024457.GA18676@earth>
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
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Tyler Baker <tyler.baker@linaro.org>, Felipe Balbi <balbi@ti.com>, Olof Johansson <olof@lixom.net>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Sat, 7 Nov 2015 03:44:57 +0100 Sebastian Reichel <sre@kernel.org> wrote:
>
> Is there an easy way to check this, so that I can create a cronjob
> checkin it? Having an additional automatic "your tree differs from
> linux-next" would be helpful, since that would make me search for
> the problem/a mail from Stephen.

Well,

wget -q -O- http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/plain/Next/SHA1s | sed -n 's/^battery\t\t*//p'

will get you the SHA1 of the top of your branch that I merged into the
latest release.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
