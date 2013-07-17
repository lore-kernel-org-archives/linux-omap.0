From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/4] improved support for runtime muxing for pinctrl
Date: Wed, 17 Jul 2013 14:49:55 +0300
Message-ID: <51E684E3.2040104@ti.com>
References: <20130716090310.5541.36777.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130716090310.5541.36777.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 07/16/2013 12:05 PM, Tony Lindgren wrote:
> Hi all,
>
> As discussed earlier, the pinctrl support for changing some of the
> consumer device pins during runtime needs some improvment.
>
> Here are the patches to do that, I'll also post a minimal sample
> patch as a reply to this thread on how to do the muxing for
> runtime PM.

I've posted my patch and tested this patch series.
Seems everything is ok (except patch "pinctrl: Remove duplicate code in 
pinctrl_pm_select_state functions").
See http://www.spinics.net/lists/arm-kernel/msg259180.html

So,  Tested-By: Grygorii Strashko <grygorii.strashko@ti.com>

>
> Regards,
>
> Tony
>
> ---
>
> Tony Lindgren (4):
>        pinctrl: Remove duplicate code in pinctrl_pm_select_state functions
>        pinctrl: Allow pinctrl to have multiple active states
>        pinctrl: Add support for additional dynamic states
>        drivers: Add pinctrl handling for dynamic pin states
>
>
>   drivers/base/pinctrl.c                |   39 +++++
>   drivers/pinctrl/core.c                |  250 ++++++++++++++++++++++++++++-----
>   drivers/pinctrl/core.h                |   10 +
>   include/linux/pinctrl/consumer.h      |   46 ++++++
>   include/linux/pinctrl/devinfo.h       |    4 +
>   include/linux/pinctrl/pinctrl-state.h |   15 ++
>   6 files changed, 321 insertions(+), 43 deletions(-)
>

Regards,
-grygorii
