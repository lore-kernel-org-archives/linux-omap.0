From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/4] non-urgent dts fixes for omaps for v4.14
Date: Wed, 16 Aug 2017 13:44:48 -0700
Message-ID: <20170816204447.GJ8569@atomide.com>
References: <-6222202649444907883@unknownmsgid>
 <CAK8P3a1AwN7Rq3OQJYV=BE9Nr8HdMrncfvmLq3NRT5+KTENasA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1AwN7Rq3OQJYV=BE9Nr8HdMrncfvmLq3NRT5+KTENasA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170816 13:24]:
> On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> > From: "Tony Lindgren" <tony@atomide.com>
> >
> > The following changes since commit ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:
> >
> >   ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-not-urgent-dt-signed
> >
> > for you to fetch changes up to 83f51f06d132c5430b4ac5065ce3594fc4c99aaa:
> >
> >   ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap (2017-08-10 10:32:17 -0700)
> >
> > ----------------------------------------------------------------
> > Two non-urgent dts fixes for dra7 Ethernet quirk. These are sent
> > separately from the rest of the dts changes to avoid merge conflicts
> > as these depend on earlier fixes sent during v4.13-rc cycle.
> 
> I pulled them into next/cleanup branch (which contains simple fixes as well).
> I don't think there was actually a need to keep them separate from the rest
> though, you can always base your branches on your own bugfixes that
> already got merged, unless I misunderstood the point of having them
> separate.

OK sure thanks,

Tony
