From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 0/3] omap gpio add level idle,
 cpu_pm and drop runtime_irq_safe
Date: Tue, 25 Sep 2018 08:53:01 +0200
Message-ID: <CACRpkdao5j14OXAvL==008gnquvKpzuPwkK+vA2jTeyy9H+gcA@mail.gmail.com>
References: <20180920193532.7714-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 20, 2018 at 9:35 PM Tony Lindgren <tony@atomide.com> wrote:

> Linus, assuming people are happy with these, I'd appreciate an immutable branch
> with these in case we run into merge conflicts for arch/arm/mach-omap2 changes.

I created an immutable branch named "ib-omap" yesterday:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-omap

It passed build tests this morning so I merged this into my "devel" branch
for next.

Yours,
Linus Walleij
