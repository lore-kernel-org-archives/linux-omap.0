From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sat, 22 Sep 2012 17:47:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com>
 <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
 <20120922002111.GP28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120922002111.GP28835@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 21 Sep 2012, Tony Lindgren wrote:

> Hmm I wonder what's causing it then? There must be something
> else in tmp-merge at commit abfee61f that causes the problems.
> Maybe try to merge with that commit and see what you get?

Probably the merge with the clock patches was causing trouble.

> That commit can't be used as a base though as that's temporary
> most likely.. But we can create a base to use out of the
> branches once we know them, you can do it yourself too.

Your tmp-merge contains branch/tag merges that haven't yet gone upstream 
to arm-soc.  I don't know which of those merges you consider stable (aside 
from the upstream ones, obviously).  For this one it looks like the clock 
patches were the ones causing the merge trouble.  So since that series 
also came from me and is unmerged, will just merge the clock and hwmod 
patches into a new pull request on v3.6-rc6 + cleanup-fixes-for-v3.7 + 
omap-devel-am33xx-for-v3.7.  Hopefully that will work for you...


- Paul
