From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
Date: Thu, 7 Jun 2018 23:26:02 -0700
Message-ID: <20180608062602.GK5738@atomide.com>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [180607 13:40]:
> The divisions (and multiplications) can be avoided by changing the loops
> to use increments of mux_bytes instead of 1.
> While at it, remove the unneeded casts when assigning void pointers.
> 
> This saves +100 bytes of kernel size on arm32/arm64.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.

Makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>

Keerthy can you please test?

Regards,

Tony
