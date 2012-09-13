From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] lis3: lis3lv02d_i2c: Add device tree support
Date: Thu, 13 Sep 2012 21:24:43 +0530
Message-ID: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
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
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

First patch adds device tree support to lis3lv02d_i2c driver and
second patch adds platform data for lis331dlh driver to am335x
EVM. These patches were tested on AM335x-EVM.

AnilKumar Ch (2):
  lis3: lis3lv02d_i2c: Add device tree support
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm

 arch/arm/boot/dts/am335x-evm.dts       |   42 ++++++++++++++++++++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |   13 ++++++++++
 2 files changed, 55 insertions(+)

-- 
1.7.9.5
