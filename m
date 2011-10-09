From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
Date: Sun, 9 Oct 2011 19:35:50 +0800
Message-ID: <CACVXFVP85gS=FdWcecGZYWSN+U5q0Z9h9zURNmFOiM2sWOPmNw@mail.gmail.com>
References: <871uwbhdoj.fsf@ti.com> <4E669F36.2070008@ti.com>
	<4E80FD1A.5040006@deeprootsystems.com>
	<20111004210832.GC13323@freya.fluff.org> <87aa9f771n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87aa9f771n.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-i2c@fluff.org>, Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 6, 2011 at 12:11 AM, Kevin Hilman <khilman@ti.com> wrote:
> Ben Dooks <ben-i2c@fluff.org> writes:
>
>> On Mon, Sep 26, 2011 at 03:30:50PM -0700, Kevin Hilman wrote:
>>> ping
>>>
>>> On 09/06/2011 03:31 PM, Kevin Hilman wrote:
>>> >Hi Ben,
>>> >
>>> >On 08/23/2011 05:10 PM, Kevin Hilman wrote:
>>> >>Ben,
>>> >>
>>> >>Here's one more I2C cleanup series for v3.2.
>>> >>
>>> >>It applies on top of my for_3.2/i2c-fixes branch just submitted.
>>> >>
>>> >>Please pull into your tree for linux-next.
>>> >
>>> >I see you pulled the other two, can you pull this one as well?
>>
>> I've tried, but it seems to note that everything is up to date.
>>
>> Is this a suitable branch to pull onto latest so I can reset
>> my next tree?
>
> Yes.
>
> The i2c-cleanup branch[1] is based on top of the previous two (i2c-andy
> and i2c-fixes) so if you reset your next-i2c branch and just pull
> i2c-cleanup, you'll get all three.

BTW:

The patch[1] is a fix patch, which fix the OOPS[2] during system resume, so
should CC -stable tree.

[1], I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
[2], http://marc.info/?l=linux-omap&m=131658936429671&w=2

thanks,
-- 
Ming Lei
