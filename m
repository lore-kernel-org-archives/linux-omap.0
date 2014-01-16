From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 16 Jan 2014 13:39:54 -0800
Message-ID: <20140116213954.4167.37071@quantum>
References: <20140110161352.GG6665@saruman.home>
 <20140110185110.GM31323@atomide.com>
 <52D53084.1070105@ti.com> <20140114203613.GA604@saruman.home>
 <20140115020421.GA24195@saruman.home> <20140115031632.4167.2698@quantum>
 <20140115035011.4167.96678@quantum> <20140115171323.GA22739@atomide.com>
 <20140115192340.4167.87685@quantum> <20140115193547.GF7993@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140115193547.GF7993@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2014-01-15 11:35:48)
> * Mike Turquette <mturquette@linaro.org> [140115 11:25]:
> > Quoting Tony Lindgren (2014-01-15 09:13:23)
> > > * Mike Turquette <mturquette@linaro.org> [140114 19:52]:
> > > > > 
> > > > > These 40 patches apply very cleanly on top of clk-next with 2
> > > > > exceptions:
> > > > > 
> > > > > 1) I did not apply "[PATCH 30/42] ARM: dts: AM35xx: use DT clock data"
> > > > > because I do not have arch/arm/boot/dts/am3517.dtsi in clk-next (based
> > > > > on 3.13-rc1).
> > > > > 
> > > > > 2) Minor merge conflict in arch/arm/boot/dts/omap3.dtsi which I think I
> > > > > resolved correctly but would like verification.
> > > > > 
> > > > > I'd prefer to simply merge these patches into clk-next, which is the
> > > > > most straightforward route. Any ideas on how to handle the missing
> > > > > AM35xx dtsi data? It can always go as a separate fix after this stuff
> > > > > gets merged which, ironically, is how that file was created in the first
> > > > > place.
> > > 
> > > You could do something like this to take advantage of fast forward and
> > > not have to do a merge back from mainline:
> > > 
> > > $ git checkout -b am3517-clk v3.13-rc8 # or any other -rc with am3517.dtsi
> > > $ git merge clk-next-omap # this fast forwards clk-next-omap to the desired -rc
> > > $ git am am3517-clk-patch
> > > $ git checkout clk-next
> > > $ git merge clk-next-omap # this fast forwards clk-next to the desired -rc
> > 
> > That makes sense, but is there anything bad about doing that for a
> > branch you intend to send as a pull request? I don't see how any of the
> > commits get re-written or anything... I just wonder if there is some
> > subtlety that I am not accounting for that makes this approach bad for
> > sending to Linus.
> 
> No there should not be any issues. That's the preferred way to keep
> development branches updated and pullable in long term without any need
> to rebase.
> 
> Note that there will be only a merge commit if there is a conflict,
> otherwise the fast forward will be transparent. So the trick to avoiding
> rebasing and back merges is to apply patches against what they need in a
> local branch, then after testing merge that local branch into the development
> branch. Then for the upsteam pull request, you just need to make it against
> the -rc you merged in.
> 
> AFAIK what Linus does not like is doing a back merge to a development
> branch from mainline, probably as it adds a pointless commit. Or rebasing
> a branch as that way it won't stay pullable.

Hi all,

I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
Tero's series. This includes the AM3517 bits now. I've pushed this
branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
final sanity test before I merge this into clk-next?

Thanks!
Mike

> 
> Regards,
> 
> Tony
