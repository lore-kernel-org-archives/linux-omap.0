From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/4] ARM: mvebu: remove the workaround imprecise abort
 fault handler
Date: Thu, 15 Oct 2015 09:31:56 +0200
Message-ID: <87io6837v7.fsf@free-electrons.com>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-4-git-send-email-l.stach@pengutronix.de>
 <20151014225826.28313016@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151014225826.28313016@free-electrons.com> (Thomas Petazzoni's
 message of "Wed, 14 Oct 2015 22:58:26 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Lucas,
 
 On mer., oct. 14 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Lucas,
>
> On Wed, 14 Oct 2015 16:48:32 +0200, Lucas Stach wrote:
>> This is not needed anymore. Handling a potentially pending imprecise external
>> abort left behind by the bootloader is now done in a slightly safer way inside
>> the common ARM startup code.
>> 
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

As pointed by Thomas the code is no longer needed. So even if the rest
of tour series is not merged, I still applied on mvebu/cleanup.

I also amended the commit log to emphasize that the Armada 375 Z1 was
not support anymore.

Thanks,

Gregory

>> ---
>>  arch/arm/mach-mvebu/board-v7.c | 35 -----------------------------------
>>  1 file changed, 35 deletions(-)
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> In fact this code is anyway no longer needed, since this workaround was
> only needed for the Armada 375 Z1 stepping, which we no longer support
> in mainline anyway.
>
> Thanks!
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
