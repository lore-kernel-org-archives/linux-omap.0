From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Update for moved options
Date: Tue, 5 Feb 2019 11:58:17 +0100
Message-ID: <20190205105817.fn4ua6fjgkdxuvea@verge.net.au>
References: <20190204203747.7376-1-tony@atomide.com>
 <20190204203747.7376-2-tony@atomide.com>
 <CAMuHMdV68HxMzyMAgy6Cy_ECussJmpVTh5=vDAHwD8rA-BWsTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV68HxMzyMAgy6Cy_ECussJmpVTh5=vDAHwD8rA-BWsTg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 05, 2019 at 09:09:16AM +0100, Geert Uytterhoeven wrote:
> Hi Tony,
> 
> On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> > These options have just moved around, let's update with make
> > savedefconfig to make patching the file easier.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks, this matches similar changes to shmobile_defconfig in commit
> 4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
> in next.
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
