From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] pinctrl: single: Fix missing unlock on error path
Date: Fri, 13 Jul 2018 08:48:58 +0200
Message-ID: <CACRpkdaFmoqYO054CRaN0f_Dc9QiZ90Lx3hzVxndtfcJmZgi3w@mail.gmail.com>
References: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: ext Tony Lindgren <tony@atomide.com>, kernel-janitors@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2018 at 2:24 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Add the missing unlock before return from function
> in the error handling case.
>
> Fixes: 0f5972033509 ("pinctrl: single: Fix group and function selector use")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied on top of fixes, for fixes!

Yours,
Linus Walleij
