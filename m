From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [GIT PULL 4/4] omap crossbar support for v3.15
Date: Tue, 11 Mar 2014 18:11:56 +0530
Message-ID: <531F0494.1040105@ti.com>
References: <pull-1393802089-910509>
 <5313bcc5.a8fc440a.467f.7ba2SMTPIN_ADDED_MISSING@mx.google.com>
 <20140309073347.GL16310@quad.lixom.net> <20140310163620.GB4882@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140310163620.GB4882@atomide.com>
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
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,

On Monday 10 March 2014 10:06 PM, Tony Lindgren wrote:
> * Olof Johansson <olof@lixom.net> [140308 23:36]:
>> On Sun, Mar 02, 2014 at 03:14:49PM -0800, Tony Lindgren wrote:
>>> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>>>
>>>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/crossbar-signed
>>>
>>> for you to fetch changes up to 9594274201ac3c67d5c569aae63792e58bcd33e6:
>>>
>>>   Merge branch 'crossbar_3.14_rc1' of git://github.com/Sricharanti/sricharan into omap-for-v3.15/crossbar (2014-02-28 13:35:02 -0800)
>>>
>>> ----------------------------------------------------------------
>>>
>>> Add support for GIC crossbar that routes interrupts on newer omaps.
>>>
>>> Looks like people wanted these merged via the omap tree as it's
>>> the only user for the GIC crossbar.
>>>
>>> ----------------------------------------------------------------
>>> Sricharan R (4):
>>>       DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable irqs
>>>       DRIVERS: IRQCHIP: CROSSBAR: Add support for Crossbar IP
>>>       ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
>>>       ARM: DRA: Enable Crossbar IP support for DRA7XX
>> Whoa, lots of caps on those driver subjects. I don't think we need those
>> in the future, lower case is just fine (and DRIVERS: usually isn't used).
> Oops yeah I had them as "irqchip: crossbar" and "irqchip: irq-gic" in
> my earlier branch for v3.14 that did not get merged, but this time I
> pulled from Sricharan.
>
> Scricharan, maybe use less yelling naming for any follow-up patches?
>  
  Will make sure that there are no caps in the follow up patches.

Regards,
 Sricharan
