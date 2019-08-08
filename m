From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Thu, 8 Aug 2019 23:46:45 +0200
Message-ID: <CAK8P3a2TOcjxwCBGkZAhMAf9HuTL=FAB1e0=FAg+oHB0U1nJ0A@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-14-arnd@arndb.de>
 <20190808214257.GF178933@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190808214257.GF178933@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 8, 2019 at 11:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Arnd,
>
> On Thu, Aug 08, 2019 at 11:22:22PM +0200, Arnd Bergmann wrote:
> > By using the new linux/soc/ti/omap1-io.h header instead,
> > compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
> > conversion of omap1 may eventually be possible.
> >
> > The warning in the header file gets removed in order to
> > allow CONFIG_COMPILE_TEST.
>
> Given that we want to migrate people off this driver everywhere but
> OMAP1 I wonder why we would want to improve compile coverage of it.

Mainly for consistency: I'm converting all omap1 drivers in this series to
not rely on mach/* headers and to let them be compiled standalone.
The other drivers don't have a replacement, so I could treat this different
from the rest and skip the Kconfig and platform_data changes if you
prefer.

        Arnd
