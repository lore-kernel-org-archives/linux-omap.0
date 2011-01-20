From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
Date: Thu, 20 Jan 2011 12:35:07 -0800
Message-ID: <20110120123507.ac89c034.akpm@linux-foundation.org>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de> <20110120165502.GA10832@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110120165502.GA10832@siel.b>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: torbenh <torbenh@gmx.de>
Cc: xen-devel@lists.xensource.com, Kees Cook <kees.cook@canonical.com>, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, James Hogan <james@albanarts.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, James Morris <jmorris@namei.org>, Grant Likely <grant.likely@secretlab.ca>, Paul Mackerras <paulus@samba.org>, linux-parisc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, Guy Martin <gmsoft@tuxicoman.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>Russell King <l>
List-Id: linux-omap@vger.kernel.org

On Thu, 20 Jan 2011 17:55:02 +0100
torbenh <torbenh@gmx.de> wrote:

> On Thu, Jan 20, 2011 at 08:34:48AM -0800, Greg KH wrote:
> > On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
> > > the -rt patches change the console_semaphore to console_mutex.
> > > so a quite large chunk of the patches changes all
> > > acquire/release_console_sem() to acquire/release_console_mutex()
> > 
> > Why not just change the functionality of the existing function to be a
> > mutex in the rt patches, instead of having to rename it everywhere?
> 
> i hope that Thomas already did this in his upcoming -rt series.
> 
> > 
> > > this commit makes things use more neutral function names
> > > which dont make implications about the underlying lock.
> > > 
> > > the only real change is the return value of console_trylock
> > > which is inverted from try_acquire_console_sem()
> > > 
> > > Signed-off-by: Torben Hohn <torbenh@gmx.de>
> > > CC: Thomas Gleixner <tglx@tglx.de>
> > 
> > I don't mind this rename, but is it really going to help anything out?
> > What's the odds of the -rt portion of this patch ever making it to
> > mainline?
> 
> the -rt portion only changes the semaphore to a mutex.
> since the console_sem is used with mutex semantics, i dont see any
> reason, not to merge that portion too. 
> 
> i am just trying to shrink the -rt patch to make it more maintanable :)
> 

Yeah, I think it's a better name and if we can indeed switch that
semaphore to a mutex then that's a good thing to do.
