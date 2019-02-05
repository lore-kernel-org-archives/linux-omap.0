From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
Date: Tue, 5 Feb 2019 09:07:38 +0100
Message-ID: <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
References: <20190204203747.7376-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190204203747.7376-1-tony@atomide.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> These are automatically selected with make multi_v7_defconfig,
> except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, this matches similar changes to shmobile_defconfig in commit
4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
in next.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

I didn't update multi_v7_defconfig to avoid conflicts.
IMHO the arm-soc maintainers should handle the refresh of the common
config on a regular basis[*].

[*] When is the right time? I'd say it should be the last commit just
    before the release of rc1 (so all arm-soc submaintainers' trees will
    have the new base in their for-next branches for the next merge
    window), but that may be difficult to implement.

What do you think? Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
