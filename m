From: Tony Lindgren <tony@atomide.com>
Subject: Re: next/master boot: 257 boots: 11 failed, 229 passed with 16
 offline, 1 conflict (next-20190604)
Date: Sun, 9 Jun 2019 23:41:45 -0700
Message-ID: <20190610064145.GS5447@atomide.com>
References: <5cf685d0.1c69fb81.e3d89.43ae@mx.google.com>
 <20190604160018.GI2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190604160018.GI2456@sirena.org.uk>
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Mark Brown <broonie@kernel.org> [190604 16:00]:
> On Tue, Jun 04, 2019 at 07:53:04AM -0700, kernelci.org bot wrote:
> 
> Today's -next fails to boot omap2plus_defconfig on Beagle XM:
> 
> >     omap2plus_defconfig:
> >         gcc-8:
> >           omap3-beagle-xm:
> >               lab-baylibre: failing since 1 day (last pass: next-20190531 - first fail: next-20190603)
> 
> The boot fails silently with no output after the bootloader:
> 
>     https://kernelci.org/boot/id/5cf655fc59b5149acad51504/
> 
> which isn't much to go on, it does seem to have been OK in
> multi_v7_defconfig though.

Thanks for the report, adding Kevin to Cc. I think this is the same
board that seems to have started randomly failing?

Regards,

Tony
