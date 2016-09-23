From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
Date: Fri, 23 Sep 2016 08:24:14 -0700
Message-ID: <06e0406c-3ff0-a069-a48a-0b1b82872f98@oracle.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
 <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
 <20160923142634.zkaqxmiif22kws2e@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160923142634.zkaqxmiif22kws2e@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 9/23/2016 7:26 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160923 00:21]:
>> On 09/22/16 21:07, Tony Lindgren wrote:

[...]

>> On which linux-next version you are seeing this?
>
> This was with next-20160922. But testing it again this is just another
> regression caused by "softirq: fix tasklet_kill() and its users", so adding
> Santosh to Cc.
>
> So no need to revert $subject patch.
>
So your driver also looks like fiddling with tasklet core structures if
you got impacted because of the core change. After the merge window
am going to take stab at bad users of tasklet but below is
quick snap shot conversation I had with Thomas and Andrew...

------------------------------------------------------------------
B1;2802;0cOn Wed, 21 Sep 2016, Santosh Shilimkar wrote:
 > I requested you to include this patch but now am not sure anymore.
 > Looks like there are almost 30 more users which are directly
 > tweaking 'tasklet_struct' fields and calling other APIs. Hunting them
 > and fixing them probably would be an exercise and also those changes
 > needs those changed drivers to be tested.
 >
 > What do you suggest ? At least this patch needs to be dropped as of now
 > till we can have complete coverage for those bad users.

Yes, it needs to be dropped. Stephen, can you please revert it from next?

How to fix this: The only way is to review all tasklet usage sites for
creative abuse and then fix them one by one. This needs to be done anyway
because those are ticking timebombs even without changes in the core
code. I looked at one of the offenders and it's broken today, it's just
protected by the extremly low probablity to hit the wreckage case.

What you can do to coerce the developers/maintainers of offending code into
looking at the mess they created/merged is to implement accessors for the
tasklet struct fields and replace the open coded fiddling with them.

Once that is done, rename the struct fields to something which is absurd
enough to type.  But don't worry, you will find people doing that. I
catched a few brainwrecks who actually used:

  irqdesc->core_internal_state__do_not_mess_with_it

in their code.

Now after having everything converted to accessors, you can add sanity
checks into the accessors and emit WARN_ONCE() when they are used in the
wrong context. That'll make them look and explain why they think that
fiddling in the internals is a good idea.

Thanks,

	tglx
------------------------------------------------------------------
