From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] misc. OMAP PM updates for v3.1
Date: Mon, 27 Jun 2011 09:35:32 -0700
Message-ID: <87aad3dygb.fsf@ti.com>
References: <87vcvw5akk.fsf@ti.com> <20110627112843.GN23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627112843.GN23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 04:28:43 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110623 17:32]:
>> Tony,
>> 
>> Please pull the following misc. OMAP PM updates targetted for v3.1.
>> 
>> This branch is based on your 'fixes' branch due to some dependencies.
>>       OMAP2: PM debug: move wakeup timer into clockevent code
>
> This won't work with the devel-timer branch. I think we should just
> drop it for now based on what I mentioned in the other thread.

OK, dropped the timer patch.  Updated pull request below.

Thanks,

Kevin




The following changes since commit b8ce9fb8e18af7466e0b915bb5979322cdace322:

  Merge branch 'fixes-v3.0-rc3' into devel-fixes (2011-06-14 05:53:42 -0700)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/pm-misc

Kevin Hilman (3):
      OMAP3: PM debug: remove sleep_while_idle feature
      OMAP2: PM debug: remove register dumping
      OMAP3: PM debug: remove register dumping

Nishanth Menon (4):
      OMAP3+: SR: make notify independent of class
      OMAP3+: SR: disable interrupt by default
      OMAP3+: SR: enable/disable SR only on need
      OMAP3+: SR: fix cosmetic indentation

Sanjeev Premi (1):
      OMAP2+: PM: fix section mismatch in pm_dbg_init()

 arch/arm/mach-omap2/pm-debug.c    |  345 +------------------------------------
 arch/arm/mach-omap2/pm.h          |    6 -
 arch/arm/mach-omap2/pm24xx.c      |    6 +-
 arch/arm/mach-omap2/pm34xx.c      |    2 -
 arch/arm/mach-omap2/smartreflex.c |   38 ++--
 5 files changed, 23 insertions(+), 374 deletions(-)
