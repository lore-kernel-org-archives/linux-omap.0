From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
Date: Fri, 13 Nov 2015 08:39:50 -0800
Message-ID: <56461256.5050209@oracle.com>
References: <1447351566-2328-1-git-send-email-balbi@ti.com>
 <5645DC3A.4050504@ti.com> <5645E096.1030600@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5645E096.1030600@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>, Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/13/2015 5:07 AM, Mason wrote:
> On 13/11/2015 13:48, Grygorii Strashko wrote:
>> On 11/12/2015 08:06 PM, Felipe Balbi wrote:
>>> Make sure to tell the kernel that AM437x has
>>> TWD and global timers.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> Hi Tony,
>>>
>>> now that all dependencies are in place, we can
>>> finally enable twd and global_timer for AM437x.
>>>
Is AM437x SMP SOC ? Is TWD on AM437x works in low
power states ?
Probably I haven't followed the recent updates, but does
the TWD supports C3STOP on UP systems ? The broadcast
code was SMP only in past, and TWD use to die in
low power state on past OMAP SOCs.

If either of these are still the issue then
TWD shouldn't be used.

Regards,
Santosh
