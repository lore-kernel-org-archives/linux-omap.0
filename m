From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Thu, 18 Jul 2013 00:54:20 +0200
Message-ID: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <linux-arm-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

Here's a small patch set that replaces PWM polarity numerical constants with
macros in DT.

The series is the result of splitting the original patch into four patches
that

- add the flag macro (both in a header file and in the PWM DT binding core
  documentation)
- use the macro in the PWM core code
- update existing DT bindings to refer to the PWM DT bindings core
  documentation
- update existing DT sources to use the new macro

I believe I've taken all comments received so far into account. Most notable
changes include

- splitting the original patch
- removing the PWM_POLARITY_NORMAL flag, which wasn't a flag but was defined
  as 0
- renaming the PWM_POLARITY_INVERSED DT flag to PWM_POLARITY_INVERTED
- not relying on DT flags and PWM C flags having identical names and values

Laurent Pinchart (4):
  pwm: Add PWM polarity flag macro for DT
  pwm: Use the DT macro directly when parsing PWM DT flags
  pwm: Update DT bindings to reference pwm.txt for cells documentation
  ARM: dts: Use the PWM polarity flags

 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt    |  8 +++-----
 Documentation/devicetree/bindings/pwm/imx-pwm.txt          |  4 ++--
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt          |  4 ++--
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt         |  5 ++---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt  |  4 ++--
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt      | 10 +++-------
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt       |  8 +++-----
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt     |  8 +++-----
 Documentation/devicetree/bindings/pwm/pwm.txt              |  7 ++++---
 Documentation/devicetree/bindings/pwm/spear-pwm.txt        |  5 ++---
 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt       |  4 ++--
 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt    |  4 ++--
 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt       |  8 +++-----
 arch/arm/boot/dts/am335x-evmsk.dts                         |  3 ++-
 arch/arm/boot/dts/wm8850-w70v2.dts                         |  3 ++-
 drivers/pwm/core.c                                         |  7 +++----
 include/dt-bindings/pwm/pwm.h                              | 14 ++++++++++++++
 17 files changed, 54 insertions(+), 52 deletions(-)
 create mode 100644 include/dt-bindings/pwm/pwm.h

-- 
Regards,

Laurent Pinchart
