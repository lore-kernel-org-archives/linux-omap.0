From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCHv3 02/14] ARM: OMAP2+: mbox: remove dependencies with
 soc.h
Date: Tue, 26 Mar 2013 19:30:41 +0000
Message-ID: <37C860A02101E749A747FA2D3C1E3C5049F528@DLEE11.ent.ti.com>
References: <1363145036-14407-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.00.1303261845390.23957@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1303261845390.23957@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic Pallardy <loic.pallardy@st.com>
List-Id: linux-omap@vger.kernel.org

Paul,

> > The OMAP mailbox platform driver code has been cleaned up to remove
> > the dependencies with soc.h in preparation for moving the mailbox code
> > to drivers folder.
> >
> > The code relied on cpu_is_xxx/soc_is_xxx macros previously to pick the
> > the right set of mailbox devices and register with the mailbox driver.
> > This data is now represented in a concise format and moved to the
> > respective omap_hwmod data files and published to the driver through
> > the platform data.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> The hwmod/dev_attr parts look fine to me, but please start thinking about how
> to convert the driver to get this data from DT instead.

Yes, that is the plan. I will have the DT conversion when I add the support for
OMAP5.

Regards
Suman
