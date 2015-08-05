From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: multi_v7_defconfig: Enable more OMAP family
 platforms
Date: Wed, 5 Aug 2015 03:22:34 -0700
Message-ID: <20150805102234.GZ16878@atomide.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, balbi@ti.com, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Ping, looks like these are still pending. Probably should be
applied directly by the arm-soc maintainers.

Regards,

Tony

* Nishanth Menon <nm@ti.com> [150409 14:17]:
> Hi,
> 
> As of next-20150409 tag, the following platforms (I have access
> to) report failures for AM437x-sk and legacy beaglebone (white).
> omap2plus_defconfig boots up fine on these platforms.
> 
> So, the basic minimum stuff I could pickup to fix up beaglebone-white
> and am437x-sk.
> 
> This series is still missing the magic sauce for LDP - will try to
> track that down later as well.
> 
> This series is based on next-20150409
> 
> multi_v7_defconfig (as on next-20150409)
>  1:                     am335x-evm: BOOT: PASS: am335x-evm.txt
>  2:                      am335x-sk: BOOT: PASS: am335x-sk.txt
>  3:                     am3517-evm: BOOT: PASS: am3517-evm.txt
>  4:                      am37x-evm: BOOT: PASS: am37x-evm.txt
>  5:                      am437x-sk: BOOT: FAIL: am437x-sk.txt
>  6:                    am43xx-epos: BOOT: PASS: am43xx-epos.txt
>  7:                   am43xx-gpevm: BOOT: PASS: am43xx-gpevm.txt
>  8:                 BeagleBoard-XM: BOOT: PASS: beagleboard.txt
>  9:            beagleboard-vanilla: BOOT: PASS: beagleboard-vanilla.txt
> 10:               beaglebone-black: BOOT: PASS: beaglebone-black.txt
> 11:                     beaglebone: BOOT: FAIL: beaglebone.txt
> 12:                     craneboard: BOOT: PASS: craneboard.txt
> 13:                     dra72x-evm: BOOT: PASS: dra72x-evm.txt
> 14:                     dra7xx-evm: BOOT: PASS: dra7xx-evm.txt
> 15:         OMAP3430-Labrador(LDP): BOOT: FAIL: ldp.txt
> 16:                           n900: BOOT: PASS: n900.txt
> 17:                      omap5-evm: BOOT: PASS: omap5-evm.txt
> 18:                  pandaboard-es: BOOT: PASS: pandaboard-es.txt
> 19:             pandaboard-vanilla: BOOT: PASS: pandaboard-vanilla.txt
> 20:                        sdp3430: BOOT: PASS: sdp3430.txt
> 21:                        sdp4430: BOOT: PASS: sdp4430.txt
> 
> After this series:
>  1:                     am335x-evm: BOOT: PASS: am335x-evm.txt
>  2:                     am3517-evm: BOOT: PASS: am3517-evm.txt
>  3:                      am37x-evm: BOOT: PASS: am37x-evm.txt
>  4:                      am437x-sk: BOOT: PASS: am437x-sk.txt
>  5:                    am43xx-epos: BOOT: PASS: am43xx-epos.txt
>  6:                   am43xx-gpevm: BOOT: PASS: am43xx-gpevm.txt
>  7:                 BeagleBoard-XM: BOOT: PASS: beagleboard.txt
>  8:            beagleboard-vanilla: BOOT: PASS: beagleboard-vanilla.txt
>  9:               beaglebone-black: BOOT: PASS: beaglebone-black.txt
> 10:                     beaglebone: BOOT: PASS: beaglebone.txt
> 11:                     craneboard: BOOT: PASS: craneboard.txt
> 12:                     dra72x-evm: BOOT: PASS: dra72x-evm.txt
> 13:                     dra7xx-evm: BOOT: PASS: dra7xx-evm.txt
> 14:         OMAP3430-Labrador(LDP): BOOT: FAIL: ldp.txt
> 15:                           n900: BOOT: PASS: n900.txt
> 16:                      omap5-evm: BOOT: PASS: omap5-evm.txt
> 17:                  pandaboard-es: BOOT: PASS: pandaboard-es.txt
> 18:             pandaboard-vanilla: BOOT: PASS: pandaboard-vanilla.txt
> 19:                        sdp3430: BOOT: PASS: sdp3430.txt
> 20:                        sdp4430: BOOT: PASS: sdp4430.txt
> TOTAL = 20 boards, Booted Boards = 19, No Boot boards = 1
> 
> Nishanth Menon (3):
>   ARM: multi_v7_defconfig: Enable beaglebone PMIC TPS65217
>   ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
>   ARM: multi_v7_defconfig: Enable generic SoC internal OMAP regulators
> 
>  arch/arm/configs/multi_v7_defconfig |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Regards,
> Nishanth Menon
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
