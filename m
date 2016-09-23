From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
Date: Fri, 23 Sep 2016 13:19:43 +0300
Message-ID: <8b8a49cd-ca7b-4580-58ba-3e05d933853e@ti.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
 <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/23/16 10:20, Peter Ujfalusi wrote:
> On 09/22/16 21:07, Tony Lindgren wrote:
>> Hi,
>>
>> Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
>> support bulk access") breaks at least omap4-duovero.
> =

> That's odd. I see no such errors on omap4 PandaBoard-ES nor on omap5 uEVM.
> The IRQ status is one register so even in bulk access it is one read. So =
the
> use_single_rw should have no effect on the access.
> =

> The only time when regmap would try to use bulk access to twl6040 is when=
 we
> execute regcache_sync() on it after resuming the chip and this would fail=
 at
> the first time when it tries to restore more than one consecutive registe=
rs.
> =

> I just tested things on next-20160915 and I see no errors at all.

Retested on next-20160923 and I see no issue on Panda-ES or omap5-uevm.

My guess is that you receive an interrupt from twl6040 while the chip is
powered down, the regmap is set to cache only. But this has nothing to do w=
ith
the bulk or non bulk access... Looking at the commit logs and git blame I s=
ee
no recent change in the driver(s) for twl6040 which changed the way it loads
and/or powers up/down.

-- =

P=E9ter
