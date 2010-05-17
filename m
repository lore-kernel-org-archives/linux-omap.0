From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 21:00:50 +0100
Message-ID: <20100517200049.GA420@srcf.ucam.org>
References: <87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<1274125840.25625.21.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274125840.25625.21.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, J acob Pan <jacob.jun.pan@linux.intel.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 12:50:40PM -0700, Daniel Walker wrote:
> On Mon, 2010-05-17 at 20:34 +0100, Matthew Garrett wrote:
> 
> > int main() {
> > 	int i;
> > 	while (1)
> > 		i++;
> > 	return 0;
> > }
> > 
> 
> We already know it's really rare on an embedded system you would get
> this bad of an app. However, if you assume that you might have this 1 in
> a million app, couldn't we just have a watch dog that identifies and
> kills it. It would also let the user know what happened of course.
> Killing the app seems pretty reasonable to me.

In a world where anyone can provide this kind of app for Android users, 
I'd submit that it's going to be significantly more common than that. 
I'd expect real world cases to be at least slightly more subtle, but...

But yeah. Fundamentally the real argument here isn't about suspend 
blockers. It's about whether it's valid to require that the Linux kernel 
provide mechanisms to enable power management in the face of poorly 
written applications. If you think that that argument is invalid then 
suspend blockers are an entirely unnecessary set of layering violations. 
If you think it's valid, suspend blockers are the only currently 
proposed solution that will work in a race-free manner.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
