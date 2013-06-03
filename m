From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: [GIT PULL v2] ARM: dts: OMAP fixes for 3.10-rc5
Date: Mon, 3 Jun 2013 16:36:42 +0200
Message-ID: <51ACA9FA.9000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Please pull three DTS fixes for the next -rc.

Thanks,
Benoit



The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
  Linus Torvalds (1):
        Linux 3.10-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git dts-fixes-for-3.10

Kevin Hilman (1):
      ARM: dts: omap4-panda|sdp: Fix mux for twl6030 IRQ pin and msecure line

Lars Poeschel (1):
      ARM: dts: AM33xx: Fix properties on gpmc node

Suman Anna (1):
      ARM: dts: OMAP5: Fix missing PWM capability to timer nodes

 arch/arm/boot/dts/am33xx.dtsi             |    4 ++--
 arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi              |    3 +++
 4 files changed, 45 insertions(+), 2 deletions(-)
