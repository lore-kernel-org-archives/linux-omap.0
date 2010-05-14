From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 11:39:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141123020.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100503180741.GB2098@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg Kroah-Hartman <gregkh@suse.de>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, 3 May 2010, Mark Brown wrote:

> I fully agree with this.  We do need to ensure that a runtime PM based
> system can suspend the CPU core and RAM as well as system suspend can
> but that seems doable.

It is already possible on OMAP-based systems running mainline Linux[1].

Consumer-market Linux devices that do this have been available since at 
least 2007[2].

Intel is pursing a similar approach with Moorestown[3], since "echo mem > 
/sys/power/state" is much more inflexible than an idle-loop-based system 
"suspend."  

Going forward, ACPI-style centralized power management is dead.  Like 
"echo mem > /sys/power/state", ACPI PM is too inflexible for most 
use-cases, and so wastes power because the system must be kept in a 
higher-power state than necessary.  Even Intel is abandoning ACPI[4].


- Paul


1. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri May 14 
   10:22:05 PDT 2010: 
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025530.html

2. http://en.wikipedia.org/wiki/Nokia_N800

3. German Monroy's presentation at ELC 2010, "Wake-ups Effect on Idle 
   Power for Intel's Moorestown MID and Smartphone Platform":
   http://elinux.org/images/0/07/Effect_of_wakeups_on_Moorestown_power.pdf

4. Jacob Pan's presentation at ELC 2010, "Porting the Linux Kernel to x86 
   MID Platforms": http://elinux.org/images/e/ee/Jacob-Pan-x86MID-elc2010.pdf
