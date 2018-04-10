From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] Fix drivers/memory O= build
Date: Tue, 10 Apr 2018 06:55:16 -0700
Message-ID: <20180410135516.GT5700@atomide.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
 <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
 <20180406185505.GD10990@n2100.armlinux.org.uk>
 <CAK7LNARbST+-oy-J9B2Q2vSp0nhnn9gqOnT7urZdjQZhSpYB-Q@mail.gmail.com>
 <20180407133817.GE10990@n2100.armlinux.org.uk>
 <ba6087c5-c69e-1adc-9d9d-0ef5b19fb30e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ba6087c5-c69e-1adc-9d9d-0ef5b19fb30e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Michal Marek <michal.lkml@markovi.net>, arm-soc@armlinux.org.uk, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [180409 16:07]:
> I've inlined the changes below. I will send a proper split up series if it's
> considered acceptable.

Seems fine from my point of view. No need to split the patch, best to
do the fix as a single patch.

We should test build it also with make randconfigs though.

So assuming others are OK with this and it does not introduce
new randconfig build errors:

Acked-by: Tony Lindgren <tony@atomide.com>
