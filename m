From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCH v2 00/13] drivers: mailbox: framework creation
Date: Wed, 13 Feb 2013 16:41:37 +0000
Message-ID: <37C860A02101E749A747FA2D3C1E3C50476638@DLEE12.ent.ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
 <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
 <20130213134207.GN17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130213134207.GN17852@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson,
 Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> On Wed, Feb 13, 2013 at 02:36:32PM +0100, Linus Walleij wrote:
> > On Tue, Feb 12, 2013 at 5:56 AM, Suman Anna <s-anna@ti.com> wrote:
> >
> > > I have hosted the series at [3].
> > > [3]
> > > https://github.com/sumananna/mailbox/commits/dbx500-prcmu-mailbox
> >
> > Suman, I suggest you ask Stepgen Rothwell to include this branch into
> > the linux-next tree, so we can get some rotation of this stuff in
> > preparation for the v3.10 merge window. (It's not going in now
> > anyway.)
> 
> Best wait until after v3.9-rc1 - remember that linux-next is supposed to be a
> staging tree for the _next_ merge window only.

Yes, will do. Anyway, we need a new revision of one patch (so far) to address Mark Rutland's comments.

Thanks
Suman
