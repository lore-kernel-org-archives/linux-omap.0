From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: OMAP2: AM33XX: Add cpufreq support
Date: Fri, 31 Aug 2012 15:07:18 +0530
Message-ID: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
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
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add cpufreq support to AM33XX family of devices by adding OPP
information, clock entry with cpu0 name and voltage supplies
to cpu0.

These patches have been tested on AM335x-EVM, AM335x-Bone and
these patches are based on cpufreq-cpu0 driver
http://marc.info/?l=linux-arm-kernel&m=134457735413293&w=2

AnilKumar Ch (2):
  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
  arm/dts: AM33XX: Add device tree OPP table

 arch/arm/boot/dts/am335x-bone.dts    |    6 ++++++
 arch/arm/boot/dts/am335x-evm.dts     |    6 ++++++
 arch/arm/boot/dts/am33xx.dtsi        |   15 +++++++++++++++
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 4 files changed, 28 insertions(+)

-- 
1.7.9.5
