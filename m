From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl context
Date: Wed, 23 May 2018 10:30:48 +0200
Message-ID: <CACRpkdbh6kpRaGaY7aux5L=JcgQi-pOtRxp9wsrYvrZ7ZSa3pA@mail.gmail.com>
References: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 17, 2018 at 6:40 AM, Keerthy <j-keerthy@ti.com> wrote:

> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. The context is lost during rtc only
> suspend with ddr in self-refresh on am43xx. Currently the save/restore
> is being done unconditionally. This will be optimized later with a
> pdata-quirk function which will allow is to save/restore only when doing
> the rtc only mode with ddr in self refresh.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Changes in v2:

Patch applied with Tony's ACK.

Yours,
Linus Walleij
