From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: export suspend_set_ops,
	suspend_valid_only_mem
Date: Sun, 26 Jun 2011 14:22:44 +0200
Message-ID: <201106261422.45094.rjw@sisk.pl>
References: <1306542839-5688-1-git-send-email-khilman@ti.com>
	<201106121620.20442.rjw@sisk.pl>
	<20110626110843.GC1101@localhost.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110626110843.GC1101@localhost.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday, June 26, 2011, Pavel Machek wrote:
> On Sun 2011-06-12 16:20:20, Rafael J. Wysocki wrote:
> > On Saturday, May 28, 2011, Kevin Hilman wrote:
> > > Some platforms wish to implement their PM core suspend code as
> > > modules.  To do so, these functions need to be exported to modules.
> > > 
> > > Reported-by: Jean Pihet <j-pihet@ti.com>
> > > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > 
> > Applied to suspend-2.6/linux-next.
> 
> I'd do export_symbol_gpl on those; it is really tightly coupled...

Good point, thanks, I'll fix this up.

Rafael
