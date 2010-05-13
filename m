From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 11:25:57 -0700
Message-ID: <1273775157.19100.20.camel@c-dwalke-linux.qualcomm.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<20100513121745.GA10749@srcf.ucam.org>
	<1273771990.19100.13.camel@c-dwalke-linux.qualcomm.com>
	<s2ga55d774e1005131117yd138c59bk54cc109401eb4a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s2ga55d774e1005131117yd138c59bk54cc109401eb4a8d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Linus Walleij <linus.walleij@ericsson.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-13 at 11:17 -0700, Brian Swetland wrote:

> 
> I'm not sure this necessitates using only debugfs for the userspace
> interface.  A userspace interface is necessary to accomplish what
> we're trying to do here, otherwise we have only half a solution, and
> our hope is that it'd be a stable interface (as userspace interfaces
> are supposed to be) for as long as its needed.  I could totally
> imagine the userspace interface eventually becoming a no-op or
> punching through to some other facility, depending on how this problem
> is solved long-term in the ideal post-suspend-block future.

The problem is that once this userspace interface is exposed, it's
nearly permanent and has to be support for a long long time .. It might
seen trivial to just remove something your not using, but we never know
who is using what once the kernel is released.

Daniel
