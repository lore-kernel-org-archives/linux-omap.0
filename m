From: Roger Quadros <rogerq@ti.com>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Mon, 10 Feb 2014 18:11:35 +0200
Message-ID: <52F8FA37.1020709@ti.com>
References: <52F8F77B.70605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <52F8F77B.70605@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org, "Balbi, Felipe" <balbi@ti.com>
Cc: linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Nishant,

On 02/10/2014 05:59 PM, Nishanth Menon wrote:
> Hi,
> 
> A quick note to report that I saw regression in today's next tag (logs
> indicate around EHCI) boot on various TI platforms:
> 
> Note: crane and sdp2430 are not expected to pass with
> multi_v7_defconfig (note: omap2plus_defconfig boot seems to be sane
> but USB is disabled there)

I'll take a look what's happening.
Funny thing is that am335x doesn't even have an EHCI controller.

cheers,
-roger

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
