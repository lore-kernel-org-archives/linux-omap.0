From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 0/4] OMAP serial device tree support
Date: Wed, 14 Dec 2011 07:47:54 -0600
Message-ID: <4EE8A90A.10206@gmail.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53943 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab1LNNsA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 08:48:00 -0500
In-Reply-To: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, tony@atomide.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On 12/14/2011 05:55 AM, Rajendra Nayak wrote:
> v3 is rebased on top of the latest serial runtime
> patches[1] and boot tested with/without DT on OMAP4
> SDP and OMAP4 Panda boards.
> 
> Patches can be found here..
> git://gitorious.org/omap-pm/linux.git for-dt/serial
> 
> I also had to pull in a fix[2] for DT testing (already in linux-omap
> master) which was missing as the serial runtime branch[1]
> was based on an older master commit.
> 
> Changes in v3:
> -1- Rebased on latest serial runtime patches
> -2- Minor typr fixes
> 
> Changes in v2:
> -1- Got rid of binding to define which uart is console
> -2- Added checks to default clock speed to 48Mhz
> -3- Added compatible for each OMAP family
> -4- Used of_alias_get_id to populate port.line
> 
> [1] git://gitorious.org/runtime_3-0/runtime_3-0.git for_3_3/lo_rc4_uartruntime
> [2] http://www.spinics.net/lists/arm-kernel/msg150751.html
> 
> Rajendra Nayak (4):
>   omap-serial: Get rid of all pdev->id usage
>   omap-serial: Use default clock speed (48Mhz) if not specified
>   omap-serial: Add minimal device tree support
>   ARM: omap: pass minimal SoC/board data for UART from dt
> 
>  .../devicetree/bindings/serial/omap_serial.txt     |   10 +++
>  arch/arm/boot/dts/omap3.dtsi                       |   31 ++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   28 +++++++
>  arch/arm/mach-omap2/board-generic.c                |    1 -
>  drivers/tty/serial/omap-serial.c                   |   80 +++++++++++++++----
>  5 files changed, 132 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt

Looks good. For the series:

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

