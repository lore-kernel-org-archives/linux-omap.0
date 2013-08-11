From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: [PATCH] Add support for Newflow NanoBone board
Date: Sun, 11 Aug 2013 09:27:22 +0100
Message-ID: <52074AEA.4070205@newflow.co.uk>
References: <51DB0B85.7000102@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:54154
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752316Ab3HKI1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Aug 2013 04:27:24 -0400
In-Reply-To: <51DB0B85.7000102@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

On 08/07/13 19:57, Mark Jackson wrote:
> NanoBone Specification:
> -----------------------
> CPU:
>   TI AM335x @ 720MHz
> 
> Memory:
>   256MB DDR3
>   128MB NOR flash
>   128KB FRAM
> 
> Ethernet:
>   2 x 10/100 connected to SMSC LAN8710 PHY
> 
> USB:
>   1 x USB2.0 Type A
> 
> I2C:
>   2Kbit EEPROM (Microchip 24AA02)
>   RTC (Maxim DS1338)
>   GPIO Expander (Microchip MCP23017)
> 
> Expansion connector:
>   6 x UART
>   1 x MMC/SD
>   1 x USB2.0
> 
> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> ---
>  MAINTAINERS                       |    6 +
>  arch/arm/boot/dts/Makefile        |    1 +
>  arch/arm/boot/dts/am335x-nano.dts |  388 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 395 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-nano.dts

Any comments on this new board file ?
