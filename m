From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Wed, 29 Jul 2015 11:57:42 +0300
Message-ID: <55B89586.9070008@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437996250-2913-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/27/2015 02:24 PM, Kishon Vijay Abraham I wrote:
> vsel_reg and enable_reg of the pbias regulator descriptor should actually
> have the offset from syscon. However after the pbias device tree node
> is moved as a child node of syscon, vsel_reg and enable_reg has the
> absolute address because of the address translation that happens while
> creating device from device tree node.
> So avoid using platform_get_resource and use of_get_address in order to
> get only the offset (untranslated address) and populate these in
> vsel_reg and enable_reg.
>
> Cc: <stable@vger.kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

For dra7-evm:
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>


-- 
regards,
-grygorii
