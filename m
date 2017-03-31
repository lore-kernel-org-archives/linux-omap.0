From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] omap devicetree changes for v4.12
Date: Fri, 31 Mar 2017 12:12:25 +0200
Message-ID: <CAK8P3a3Z3P1o-uOmqBYvj0rOXAxdKafx=MQC3V-rwS1O+AgNHQ@mail.gmail.com>
References: <6532414973510376186@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6532414973510376186@unknownmsgid>
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
Cc: linux-omap@vger.kernel.org, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 29, 2017 at 7:09 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/dt-v2-signed
>
> for you to fetch changes up to da72e4936445e1081e1223fc58470644da8e8cdb:
>
>   Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-03-28 14:00:55 -0700)
>
> ----------------------------------------------------------------
> Devicetree changes for omaps for v4.12 merge window:
>
> - Add hecc node for am35x
>
> - Add onenand support for omap3-igep
>
> - Add bluetooth binding for n900/n9/n950
>
> - Configure clocks and SATA for dm81xx
>
> - Update operating points tables for am33xx, am43xx and dra7
>
> - Update SPI flash documentation for w25q64
>
> - Configure SPI NOR for am335x-icev2
>
> - Mux uart0 for am437x-gp-evm
>
> - Add thermal zones for omap3, omap4, omap5, dra7
>
> - Configure LEDs for am335x-baltos
>
> - A series of droid 4 changes to configure various devices
>   such as keypad, regulators, gpio-keys, rtc, power button,
>   compass, accelerometer, touchscreen, backlight, poweroff,
>   tmp105, HDMI, LCD panel and LEDs, EHCI, and micro-SD

Pulled into next/dt, thanks!

     Arnd
