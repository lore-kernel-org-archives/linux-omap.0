From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 14:27:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-921695546-1273868845=:3348"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-15?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@go>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-921695546-1273868845=:3348
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hello,

On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:

> No, suspend blockers are mostly used to ensure wakeup events are not
> ignored, and to ensure tasks triggered by these wakeup events
> complete.

Standard Linux systems don't need these, because the scheduler just keeps=
=20
the system running as long as there is work to be done.

Suspend-blocks are only needed because patch 1's opportunistic suspend=20
governor tries to suspend the system even when the scheduler indicates=20
that there is work to be done.  That decision requires all kinds of hacks=
=20
throughout the codebase [1][2].


- Paul


1. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:27:56 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18658

2. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:13:50 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18657


--155748971-921695546-1273868845=:3348
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-921695546-1273868845=:3348--
