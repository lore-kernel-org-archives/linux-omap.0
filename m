From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: dra7: scm_conf node cleanup
Date: Tue, 28 Jul 2015 17:33:46 +0300
Message-ID: <55B792CA.8070902@ti.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/27/2015 01:27 PM, Roger Quadros wrote:
> Hi,
>
> This series cleans up the scm_conf node.
>
> v2:
> - split patch. use only core_sma_sw registers for the new scm_conf child.

Series looks ok to me, so:

Acked-by: Tero Kristo <t-kristo@ti.com>

>
> cheers,
> -roger
>
> Roger Quadros (3):
>    ARM: dts: dra7: Remove ctrl_core and ctrl_general nodes
>    ARM: dts: dra7: fix pinmux@1400 resource length
>    ARM: dts: dra7: Add scm_conf@1c04 node
>
>   arch/arm/boot/dts/dra7.dtsi | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
