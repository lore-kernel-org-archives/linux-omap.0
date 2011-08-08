From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 kernels fail to build
Date: Mon, 8 Aug 2011 12:30:39 +0100
Message-ID: <20110808113039.GB15134@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
	<4E3FC3EC.2010909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E3FC3EC.2010909@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
> + Felipe,
>
> On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
>> With CONFIG_ARCH_OMAP3=3Dy and CONFIG_ARCH_OMAP4=3Dn, I'm getting this:
>>
>> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `o=
map4430_phy_init'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `o=
map4430_phy_exit'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `o=
map4430_phy_power'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `o=
map4430_phy_set_clk'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `o=
map4430_phy_suspend'
>>
> I thought below patch was suppose to fix it.
> https://patchwork.kernel.org/patch/963462/

So, the problem has been known about for around a month.  Yet the broken
patch still went upstream.

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
IF IT IS KNOWN THAT A PATCH IS BROKEN IT MUST NOT BE SUBMITTED TO MAINLINE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We've seen other instances of that during this merge window, and Linus
has responded thusly to these incidents:

http://lkml.org/lkml/2011/8/4/390

    On Thu, Aug 4, 2011 at 2:52 PM, Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
    >
    > The last three commits in the idle tree that you took from Len were in
    > linux-next until April 15 and then disappeared until yesterday. =A0Th=
e last
    > of these was broken back then and has been committed exactly the same=
 now
    > and still breaks arm and sh.
    >
    > I have reverted that commit from your tree for today ...

    Len, this is *exactly* why I com plained about the git trees you pushed=
 to me.

    And then I pulled anyway, because you and others convinced me things
    had been in -next despite the commit dates being odd.

    Let's just say that I'm really *really* disappointed. And dammit, you
    need to fix your workflow. Don't add random commits late. If you're
    offline, you're offline, and you send the old tested tree, not some
    last-minute crap.

    Next time I find reason to complain, I just won't pull.  In fact, I'm
    seriously considering a rather draconian measure for next merge
    window: I'll fetch the -next tree when I open the merge window, and if
    I get anything but trivial fixes that don't show up in that "next tree
    at the point of merge window open", I'll just ignore that pull
    request. Because clearly people are just not being careful enough.

    It's really *very* annoying to hear that a bug has been known about
    for weeks (or months) and just not fixed, and then shows up again THE
    SAME DAY that the pull request is sent to me.

                      Linus
