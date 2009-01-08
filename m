From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 0/1] OMAP gptimer based event monitor driver for oprofile
Date: Thu, 8 Jan 2009 20:21:09 +0200
Message-ID: <ESEBH1026QcqnWwAeRa000037d8@esebh102.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: oprofile-list <oprofile-list@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

Hi,

Current revisions of Cortex-A8 core have a hardware bug in performance
monitoring unit, which makes it very unreliable in Oprofile.

We discussed this problem offlist with Richard Woodruff some time ago and he
suggested to use GPTIMER to get better event samples collection frequency,
comparable to the one typically used with the hardware performance counters.
The use of GPTIMER instead of a standard oprofile timer based backend makes
the process of profiling applications less painful and more precise.

Here is my attempt to implement this event monitoring driver. I'm not quite
familiar with linux patch submission policy, so might have violated something
unintentionally.

The code is very simple for now. But tweaking it to work better with power
management and frequency scaling may be desired.


Best regards,
Siarhei Siamashka

------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB
