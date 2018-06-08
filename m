From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
Date: Fri, 8 Jun 2018 12:18:05 +0530
Message-ID: <6f7fd157-8d49-d61d-c959-1f60c4dc5e8e@ti.com>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
 <20180608062602.GK5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180608062602.GK5738@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Friday 08 June 2018 11:56 AM, Tony Lindgren wrote:
> * Geert Uytterhoeven <geert+renesas@glider.be> [180607 13:40]:
>> The divisions (and multiplications) can be avoided by changing the loops
>> to use increments of mux_bytes instead of 1.
>> While at it, remove the unneeded casts when assigning void pointers.
>>
>> This saves +100 bytes of kernel size on arm32/arm64.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Compile-tested only.
> 
> Makes sense to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Keerthy can you please test?

Tested on AM437x-gp-evm for Deep Sleep0.

Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>

Thanks Geert!

> 
> Regards,
> 
> Tony
> 
