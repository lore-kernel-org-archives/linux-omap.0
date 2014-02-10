From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Mon, 10 Feb 2014 19:50:52 +0200
Message-ID: <52F9117C.8000405@ti.com>
References: <52F8F77B.70605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52F8F77B.70605-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+devicetree

On 02/10/2014 05:59 PM, Nishanth Menon wrote:
> Hi,
> 
> A quick note to report that I saw regression in today's next tag (logs
> indicate around EHCI) boot on various TI platforms:
> 
> Note: crane and sdp2430 are not expected to pass with
> multi_v7_defconfig (note: omap2plus_defconfig boot seems to be sane
> but USB is disabled there)
> 
> next-20140210-multi_v7_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2zYHdPb94
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2UChLyzSE
>  3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s20Br9XLO1
> around ehci
> 
>  4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s20mVz9Wc7
> around ehci
> 
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2byveBYtT
>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21sOgJNwK
> around ehci
> 
>  7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2ovVNAmO7
>  8:      crane: No Image built - Missing platform support?:
>  9:       dra7:  Boot PASS: http://slexy.org/raw/s217qwaXsM
> 10:        ldp:  Boot FAIL: http://slexy.org/raw/s203IvjE23
> around ehci
> 
> 11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s2NvkRx2YJ
> around ehci

I think the problem is that ehci-platform driver gets loaded instead of ehci-omap.

In the DT node we have compatible ids for both. e.g. for omap4.dtsi

                        usbhsehci: ehci@4a064c00 {
                                compatible = "ti,ehci-omap", "usb-ehci";
                                reg = <0x4a064c00 0x400>;
                                interrupt-parent = <&gic>;
                                interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
                        };

Shouldn't ehci-omap driver be getting a higher priority than usb-ehci?

A quick fix would be to eliminate "usb-ehci" from the DT node of all failing platforms.

cheers,
-roger

> 
> 12:    sdp2430:  Boot FAIL: expected (v6 platform)
> 13:    sdp3430:  Boot FAIL: http://slexy.org/raw/s21cwW7PqH
> around ehci
> 
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2hL39Pyl9
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20UsDeuVB
> TOTAL = 15 boards, Booted Boards = 7, No Boot boards = 8
> 
> next-20140207-multi_v7_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2yo795okf
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2TfAOi6XP
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21sKT3pFN
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21nCiNjAR
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21uEu69lC
>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s21SklkJs7
>  7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s21aYZvPl7
>  8:      crane: No Image built - Missing platform support?:
>  9:       dra7:  Boot PASS: http://slexy.org/raw/s20soGBbYz
> 10:        ldp:  Boot PASS: http://slexy.org/raw/s20lDIIwgN
> 11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s2a5NWPUtE
> 12:    sdp2430:  Boot FAIL: expected (v6 platform)
> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2osagMVWZ
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2NxmpHFaW
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2PMcXzAUP
> TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2
> 
> in comparison:
> v3.14-rc2-multi_v7_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2NWCJQczI
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2566ZAl5d
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2msKg3ZQ9
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2898HemYQ
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s20ajDkVgM
>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s20YmD8SSG
>  7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2sXDV7x0T
>  8:      crane: No Image built - Missing platform support?:
>  9:       dra7:  Boot PASS: http://slexy.org/raw/s21Zz8NJrj
> 10:        ldp:  Boot PASS: http://slexy.org/raw/s21NANMvTx
> 11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s20NER4paD
> 12:    sdp2430:  Boot FAIL: expected (v6 platform)
> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2WCHUl033
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21ySru6J1
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2kztuFoSu
> TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
