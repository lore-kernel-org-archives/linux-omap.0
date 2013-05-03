From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Fri, 03 May 2013 15:49:05 +0200
Message-ID: <4518021.h47erc1rfT@wuerfel>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
 <1407180.uGFidLMFHk@wuerfel>
 <CACRpkdYSnNeO8F-1WWN9J+pkMi6B_Qydo85QovbgWOEoDDS9Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYSnNeO8F-1WWN9J+pkMi6B_Qydo85QovbgWOEoDDS9Aw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, Loic PALLARDY <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Olof Johansson <olof@lixom.net>, Suman Anna <s-anna@ti.com>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday 03 May 2013 15:39:42 Linus Walleij wrote:
> On Fri, May 3, 2013 at 3:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 02 May 2013 17:09:07 Suman Anna wrote:
> >>
> >> I do not know how much of an impact it is for the ST driver as the
> >> series adds the driver, and would have to wait until the RFC is sorted
> >> out otherwise.
> >
> > I think I'd prefer to drop the branch from the 3.10 queue then
> > and let you all work out a common approach for 3.11. Olof, any
> > other input?
> 
> This will block all refactoring of the PRCMU driver, which Loic
> is working on, and also Ulf Hansson's clock driver. It is basically
> the key to breaking that driver apart and distributing it out into
> the proper subsystems. Loic has a big patch series for that
> for next merge window which will then have to be postponed,
> or queued on top of the mailbox work when finished.
> 
> But maybe it's the right thing to do if the subsystem needs more
> work? I have no clear opinion on this, Loic, Ulf?

I think we can queue them together. I'm certainly fine with the
mailbox subsystem getting merged through both the mfd and arm-soc
trees to avoid conflicts.

	Arnd
