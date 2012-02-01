From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH V2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Wed, 01 Feb 2012 11:51:16 +0100
Message-ID: <4F291924.50702@denx.de>
References: <1324940912-18164-3-git-send-email-yanok@emcraft.com>
 <1325027377-13484-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1325027377-13484-1-git-send-email-yanok@emcraft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>, devicetree-discuss@lists.ozlabs.org, sasha_d@emcraft.com, grinberg@compulab.co.il, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 28/12/2011 00:09, Ilya Yanok wrote:
> This patch adds support for TeeJet Mt.Ventoux board based on TAM3517
> SOM. Supported devices:
>  - Serial
>  - Ethernet
>  - NAND
>  - USB host
>  - LCD
>  - Touchscreen
>  - CAN controller
>  - ADC128S converter
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> 
> Changes from V1:
> 
>  - Fixed indentation (use tabs not spaces)
>  - Fixed over 80 characters lines
>  - Added #if defined(CONFIG_SENSORS_ADCXX_MODULE) to allow adcxx to be a
>    module.
>  - Fixes for compilation with CONFIG_TOUCHSCREEN_ADS7846!=y
>   - Added defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
>   - Moved call to omap_ads7846_init to separate small function
>   - Register fixed regulator used for touchscreen only if the driver is
>     enabled
>  - Changed board name (MT_VENTOUX -> Mt.Ventoux)

Hi Tony,

can I ask you about the status of these patches ? I have not seen open
comments, do you think they can be merged in your tree ?

Thanks,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
