From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Mon, 24 Jun 2013 14:06:52 +0200
Message-ID: <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 21, 2013 at 5:03 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Hence, add pinctrl handling in omap_device core:
> 1) on PM runtime resume
> - switch pinctrl state to "default" (todo: "active")
> 2) on PM runtime suspend
> - switch pinctrl state to "idle"
> 3) during system wide suspend
> - switch pinctrl state to "sleep" or "idle" if omap_device core disables device
> - switch pinctrl state to "sleep" if device is disabled already
> 4) during system wide resume
> - switch pinctrl state to "default" (todo: "active") if omap_device core has
>   disabled  device during suspend
> - switch pinctrl state to "idle" if device was already disabled before suspend

I don't understand step 4.

I get the creeps about whether the system is runtime suspended
or runtime resumed when we come to resume proper, so I need
Kevin to have a look at this.

Apart from that it looks good.

Stephen and Tony are trying to figure out the details of whether "active"
is necessary or not in a related thread I think.

Yours,
Linus Walleij
