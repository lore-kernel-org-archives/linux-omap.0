From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/4] dts changes for omaps for v4.16, part 2
Date: Thu, 4 Jan 2018 23:06:56 -0800
Message-ID: <20180105070656.ufb2cdiry7fpshxf@localhost>
References: <pull-1513966338-859035@atomide.com>
 <pull-1513966338-859035@atomide.com-3>
 <20171222185554.GB3875@atomide.com>
 <20171223162918.GC3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171223162918.GC3875@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 23, 2017 at 08:29:18AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [171222 18:58]:
> > * Tony Lindgren <tony@atomide.com> [171222 18:17]:
> > > From: "Tony Lindgren" <tony@atomide.com>
> > > Kishon Vijay Abraham I (5):
> > >       ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
> > 
> > Turns out the binding is still open for this change. So I will
> > most likely revert this commit and reply with an updated pull
> > request for this one.
> 
> Below is an updated pull request for this with just the above
> patch reverted.
> 
> 8< ------------------
> The following changes since commit a38867305203ef5a27f0c9ff1e943a0c2fabdbce:
> 
>   ARM: dts: Move move WiFi bindings to logicpd-torpedo-37xx-devkit (2017-12-11 09:43:53 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-pt2-v2-signed
> 
> for you to fetch changes up to 1cadb0c341079785182a8d00d12ecb0bbef935fb:
> 
>   Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode" (2017-12-23 08:18:15 -0800)

Merged, thanks!


-Olof
