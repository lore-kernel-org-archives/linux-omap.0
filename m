From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 14 May 2010 14:05:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141402170.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005130839210.7624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005130839210.7624@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 13 May 2010, Paul Walmsley wrote:

> Some comments on the opportunistic suspend portion of this patch.

...

> While reading the patch, it seemed that this opportunistic suspend
> mechanism is a degenerate case of a system-wide form of CPUIdle.  I'll
> call it "SystemIdle," for lack of a better term.

The footnotes for this E-mail were inadvertently omitted.  Sorry about 
that.  They are:


1. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/cpuidle34xx.c;h=3d3d035db9aff62ce522e0080e570cfdbf8e70cc;hb=4462dc02842698f173f518c1f5ce79c0fb89395a#l292

2. OMAP35x Technical Reference Manual Rev. F, section 4.7.5.2 "System
   Clock Oscillator Control": http://www.ti.com/litv/pdf/spruf98f
