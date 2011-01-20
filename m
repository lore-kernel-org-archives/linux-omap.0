From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
Date: Thu, 20 Jan 2011 08:34:48 -0800
Message-ID: <20110120163448.GA30588@suse.de>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Torben Hohn <torbenh@gmx.de>
Cc: xen-devel@lists.xensource.com, Kees Cook <kees.cook@canonical.com>, linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, James Hogan <james@albanarts.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, James Morris <jmorris@namei.org>, Grant Likely <grant.likely@secretlab.ca>, Paul Mackerras <paulus@samba.org>, linux-parisc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, Guy Martin <gmsoft@tuxicoman.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@tglx.de>, Wu
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
> the -rt patches change the console_semaphore to console_mutex.
> so a quite large chunk of the patches changes all
> acquire/release_console_sem() to acquire/release_console_mutex()

Why not just change the functionality of the existing function to be a
mutex in the rt patches, instead of having to rename it everywhere?

> this commit makes things use more neutral function names
> which dont make implications about the underlying lock.
> 
> the only real change is the return value of console_trylock
> which is inverted from try_acquire_console_sem()
> 
> Signed-off-by: Torben Hohn <torbenh@gmx.de>
> CC: Thomas Gleixner <tglx@tglx.de>

I don't mind this rename, but is it really going to help anything out?
What's the odds of the -rt portion of this patch ever making it to
mainline?

thanks,

greg k-h
