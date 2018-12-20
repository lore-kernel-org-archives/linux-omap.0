From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
Date: Thu, 20 Dec 2018 11:05:03 +0000
Message-ID: <20181220110503.GO9507@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <20181220101044.GN9507@n2100.armlinux.org.uk>
 <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Barry Song <baohua@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Patrice Chotard <patrice.chotard@st.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, David Brown <david.brown@linaro.org>, linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>, linux-oxnas@groups.io, linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 20, 2018 at 11:23:57AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 20 Dec 2018 at 11:11, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > Since almost no one has responded, my intention is to queue up
> > patches 1-3,5-8 for the Christmas-time merge window through my
> > tree.  They will be in linux-next tonight.
> 
> AFAIU, the patch 9 (or entire patchset) was not build tested, did not
> compile and therefore was not in linux-next. Sending something, which
> was not building, to linux-next just few days before Christmas merge
> window makes the schedule really tight. Especially that during
> Christmas some people might be offline.

If you're only testing linux-next, then you have a hole in your test
regime.

> I think it should sit in linux-next for few weeks... it should sit
> there already so the auto-testers would try it. At least if it were in
> linux-next, the booting and few simple tests were already done, e.g.
> by my boards, without any additional effort.

As I've said, I'm omitting patches 4 and 9.  Patch 9 is the troublesome
patch and can't be merged anyway since patch 4 is going via the STi
maintainer along with other changes.  The remainder of the patch set
are all specific to individual platforms, some of which have been
acked, but most platform maintainers have not responded in _any_ way.

You are aware that the autobuilders do build patches sent to the
mailing list, and then we have kernelci which builds my tree, builds
linux-next etc.  There's multiple stages of build test that such
stuff goes through.

Lastly, linux-next is not a general test tree, it is for integration
testing of code destined for the _NEXT_ merge window.  The clue is
in the name.  It is not for code destined for the following merge
window - only code for _this_ merge window should be in linux-next.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
