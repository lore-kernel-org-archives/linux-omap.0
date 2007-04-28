From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] power management: remove some useless code
	from arm platforms
Date: Fri, 27 Apr 2007 17:53:27 -0700
Message-ID: <20070427175327.d8739c5c.akpm@linux-foundation.org>
References: <1177604177.6814.81.camel@johannes.berg> <463115BA.70505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <463115BA.70505@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-omap-open-source@linux.omap.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 27 Apr 2007 01:12:26 +0400
Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com> wrote:

> Johannes Berg wrote:
> > This patch kills some useless code omap1/omap2.
> Although the change looks harmless it'd be nice  CC-ing
> appropriate "arch" or "mach" lists.
> 
> Added omap list to CC.
> 
> BTW, you change OMAP stuff only, so your subject is slightly irrelevant.
> 

I'm not very comfortable handling OMAP code (Tony), ARM code (Russell) or
power-management code (Greg), and this patch is all three.

So ho hum.  I queued it up with Greg as the arbitrary target, but I'm not
sure that is really appopriate.  Probably it should have been Tony, but
Tony's tree is hiding from me.

I guess we should look at dragging the OMAP git tree into -mm.
