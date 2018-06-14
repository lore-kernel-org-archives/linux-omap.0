From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
Date: Thu, 14 Jun 2018 10:33:32 +0200
Message-ID: <CACRpkdYo9Tmes7sXCFWSMKpYXpEKDXkfqp33EBHziHeT=CpdfA@mail.gmail.com>
References: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 7, 2018 at 2:24 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The divisions (and multiplications) can be avoided by changing the loops
> to use increments of mux_bytes instead of 1.
> While at it, remove the unneeded casts when assigning void pointers.
>
> This saves +100 bytes of kernel size on arm32/arm64.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied for v4.19.

Yours,
Linus Walleij
