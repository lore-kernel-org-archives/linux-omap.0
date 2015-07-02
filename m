From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap generic wakeirq for v4.2 merge window
Date: Wed, 1 Jul 2015 23:10:12 -0700
Message-ID: <20150702061011.GX4156@atomide.com>
References: <20150616114645.GA4156@atomide.com>
 <20150629060409.GQ4156@atomide.com>
 <7hh9pnmxry.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7hh9pnmxry.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [150701 13:26]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > This one is OK to merge now, both pm-wakeirq and tty-next
> > dependencies have been merged. This leaves the following
> > diffstat for thees changes:
> 
> OK, thanks.  I'm collecting a few remaining things for a "late" branch,
> but if I miss the merge window, I'll queue it up for -rc2.

OK thanks -rc cycle should be doable too as these fix issues with
interrupt re-entrancy that's possible if the wakeirq and the
device IO interrupt ever fire at the same time. So far have not
seen that though.. But that's mostly luck.

Regrads,

Tony
