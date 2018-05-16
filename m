From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl context
Date: Wed, 16 May 2018 08:22:41 -0700
Message-ID: <20180516152241.GF98604@atomide.com>
References: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
 <1526449230-27618-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1526449230-27618-3-git-send-email-j-keerthy@ti.com>
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
Cc: t-kristo@ti.com, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180516 05:43]:
> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. This simplifies some of the AM33XX
> PM code as some of the pinctrl registers are lost when the per power
> domain loses power. The pincrtl code can perform the necessary
> save/restore.
> 
> This will also be necessary for hibernation and RTC only sleep, as all
> pinctrl registers all lost.

I think for now you can get away with just adding suspend and resume
calls where suspend calls pdata->context_may_be_lost() and saves
context as needed. And you do want to still call context_may_be_lost()
as Android configured kernel does suspend and resume constantly..

Then the cpu_notifier() can be added later on as needed once the
cpuidle patches are ready.

Regards,

Tony
