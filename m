From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
Date: Fri, 14 Sep 2018 11:09:10 +0200
Message-ID: <CACRpkdbjkL=Aq1ktMFT1jwOrOwby5xZgh-GC0JAheR9UU71Ajg@mail.gmail.com>
References: <20180911183729.17110-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180911183729.17110-1-tony@atomide.com>
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
Cc: Alexandre Courbot <gnurou@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2018 at 8:37 PM Tony Lindgren <tony@atomide.com> wrote:

> Linus, once people are happy with these, can you maybe set up an
> immutable branch with both patches in it?

Sure thing, just awaiting the final ACKed version.

There are some more OMAP patches floating I see, so maybe
a branch with all of them on for testing purposes and coordination?

Yours,
Linus Walleij
