From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as
 _rcuidle()
Date: Mon, 12 Oct 2015 16:10:24 -0700
Message-ID: <20151012231024.GO23801@atomide.com>
References: <1442554881-706-1-git-send-email-jszhang@marvell.com>
 <7hfv25dnkn.fsf@deeprootsystems.com>
 <20150923180814.GL23801@atomide.com>
 <20150924111854.43429ca2@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150924111854.43429ca2@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Kevin Hilman <khilman@kernel.org>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jisheng Zhang <jszhang@marvell.com> [150923 20:26]:
> Dear Tony,
> 
> On Wed, 23 Sep 2015 11:08:15 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Kevin Hilman <khilman@kernel.org> [150923 11:03]:
> > > Jisheng Zhang <jszhang@marvell.com> writes:
> > > 
> > > > The cpuidle tracepoints are called within a rcu_idle_exit() section, and
> > > > must be denoted with the _rcuidle() version of the tracepoint.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > >  
> > > Acked-by: Kevin Hilman <khilman@linaro.org>
> > 
> > Hmm is this needed as a fix for the -rc cycle or can this wait
> > for v4.4?
> 
> IMHO, this is a fix. But it can wait for v4.4 merge window.

Applying into omap-for-v4.4/fixes thanks.

Tony
