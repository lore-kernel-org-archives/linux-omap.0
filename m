From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 22:06:15 +0100
Message-ID: <20100517210615.GB1873@srcf.ucam.org>
References: <87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<CEE6BB42CAD6E947908279175AF8470A025A726242@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A726242@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, "tytso@mit.edu" <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 10:53:36PM +0200, Linus WALLEIJ wrote:
> I understand the problem such that the scheduler cannot determine whether
> a certain process should be allowed to schedule or not.
> =

> It strikes me that the intuitive solution is to group all un-trusted =

> processes/threads/tasks that need to be shut off even if they are
> scheduling into a control group and let the idle code ignore the
> processes in this group.
> =

> Or is there something too na=EFve about this?

It gets most of the way there (and I spent a while playing with it), but =

the problem is that not all wakeup events get proxied through the =

trusted userspace runtime. Network packets are the easiest example - a =

packet may wake the system, but if the process it's delivered to is =

frozen then obviously things get trickier. It's also racy, in that if =

you're currently awake and receive a packet that would otherwise have =

woken the system you may go to sleep between the packet being received =

and bubbling up through the kernel to get to userspace.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
