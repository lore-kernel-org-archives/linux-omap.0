From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: [PATCH v2] Add support for Newflow NanoBone board
Date: Fri, 23 Aug 2013 13:46:12 +0100
Message-ID: <52175994.3050508@newflow.co.uk>
References: <520790CB.2040905@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:51592
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755011Ab3HWMqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Aug 2013 08:46:14 -0400
In-Reply-To: <520790CB.2040905@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: martinez.javier@gmail.com, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com

On 11/08/13 14:25, Mark Jackson wrote:
> NanoBone Specification:
> -----------------------
> CPU:
>   TI AM335x
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
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Any comments on this patch set ?
