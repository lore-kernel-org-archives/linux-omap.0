From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] can: Add D_CAN raminit support to am335x-evm
Date: Wed, 9 Jan 2013 13:16:37 +0100
Message-ID: <50ED5FA5.9020305@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi Anil,

On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> This patch series adds d_can raminit support to c_can/d_can driver,
> which is required to init/de-init D_CAN message RAM (holds message
> objects). Added corresponding DT changes to get resource of RAMINIT
> register and device instance.
> 
> These patches were tested on AM335x-EVM along with pinctrl data addition
> patch, which is not added to am335x-evm.dts (only supports CPLD profile#0)
> because d_can1 is supported under CPLD profile#1.
> 
> AnilKumar Ch (3):
>   can: c_can: Add d_can raminit support
>   ARM: dts: AM33XX: Add d_can instances to aliases
>   ARM: dts: AM33XX: Add memory resource to d_can node

I've just applied both DTS patches with Acked-by from Marc in my
for_3.9/dts branch.

Regards,
Benoit
