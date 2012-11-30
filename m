From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL 1/3] omap late timer clean-up (and a warning fix) for
 v3.8 merge window
Date: Fri, 30 Nov 2012 13:34:49 +0530
Message-ID: <50B868A1.2090001@ti.com>
References: <50b41207.c188e50a.6d1e.ffffd469SMTPIN_ADDED_BROKEN@mx.google.com>
 <20121130071833.GD6899@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121130071833.GD6899@quad.lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

Olof,

On Friday 30 November 2012 12:48 PM, Olof Johansson wrote:
> On Mon, Nov 26, 2012 at 05:06:11PM -0800, Tony Lindgren wrote:
>> The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:
>>
>>    Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)
>>
>> are available in the git repository at:
>>
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-timer-signed
>>
>> for you to fetch changes up to 26f01998b0657a61167a819f1c37cb9f9e9d674b:
>>
>>    ARM: OMAP3: cm-t3517: use GPTIMER for system clock (2012-11-21 10:20:43 -0800)
>
> By the way, I had to apply the following fixup on top of this (in next/cleanup)
> to fix a compilation failure. Seems to be caused by "ARM: OMAP2+: timer: remove
> CONFIG_OMAP_32K_TIMER" from Igor.
>
There was similar patch [1] like yours from Jon to fix above build
break.

Regards
santosh

[1] http://www.spinics.net/lists/linux-omap/msg83260.html
