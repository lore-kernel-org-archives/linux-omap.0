From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: Add simple pinmux driver using device
 tree data
Date: Fri, 3 Feb 2012 16:55:39 -0800
Message-ID: <20120204005539.GI20333@atomide.com>
References: <20120203205049.4089.74610.stgit@kaulin.local>
 <20120203205508.4089.35304.stgit@kaulin.local>
 <CACRpkdaDOZ3X0AkWH4B4ZGCXHPxh0CkSg3xi=jHC5L+kJr1d=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaDOZ3X0AkWH4B4ZGCXHPxh0CkSg3xi=jHC5L+kJr1d=w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dong Aisheng <dong.aisheng@linaro.org>, Stephen Warren <swarren@nvidia.com>, Linus Walleij <linus.walleij@stericsson.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Thomas Abraham <thomas.abraham@linaro.org>, Shawn Guo <shawn.guo@freescale.com>, Rajendra Nayak <rajendra.nayak@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dongas86@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [120203 14:18]:
> On Fri, Feb 3, 2012 at 9:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Add simple pinmux driver using device tree data.
> >
> > Currently this driver only works on omap2+ series of
> > processors, where there is either an 8 or 16-bit mux
> > register for each pin. Support for other similar pinmux
> > controllers could be added.
> 
> So since it's not named pinctrl-omap I guess you intend it
> to be fully generic for simple muxes, which is nice!
> If people start ACK:ing this I will be happy with it too,
> because it's very easy to understand.

Yes the idea is that it should stay generic. I don't know
how easy or hard it would be to enhance it to support
also other type mux cases, like multiple mux registers per
pin, but I guess we'll see.
 
> > Note that this patch does not yet support pinconf_ops
> > or GPIO. Further, alternative mux modes are not yet
> > handled.
> 
> Do you want to evolve the patch for these features
> or do you want to refactor it in later?

Well I'd like to test it a bit more first as I've only
done minimal testing so far. So maybe let's assume there
will be one more iteration at least.

Regards,

Tony
