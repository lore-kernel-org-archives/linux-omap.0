From: Nishanth Menon <nm@ti.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Tue, 23 Dec 2014 10:05:24 -0600
Message-ID: <549992C4.7000603@ti.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com> <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com> <20141211092945.GE11502@n2100.arm.linux.org.uk> <54897528.4030804@samsung.com> <20141222170411.GL11502@n2100.arm.linux.org.uk> <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com> <20141222172838.GM11502@n2100.arm.linux.org.uk> <54994B30.8040606@samsung.com> <20141223111045.GN11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55756 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395AbaLWQGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Dec 2014 11:06:08 -0500
In-Reply-To: <20141223111045.GN11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/23/2014 05:10 AM, Russell King - ARM Linux wrote:
> On Tue, Dec 23, 2014 at 12:00:00PM +0100, Marek Szyprowski wrote:
>> I hope I did it right: https://lkml.org/lkml/2014/12/23/158
>> Please test, because I have no access to Omap hardware.
> 
> Patch 1/8 looks like I'd expect it to.  Nishanth, please test with your
> failing scenario, thanks.
> 
3.19-rc1
 1:                      am437x-sk: BOOT: PASS:
http://slexy.org/raw/s2ARFeCcDp
 2:                    am43xx-epos: BOOT: PASS:
http://slexy.org/raw/s2Kzli0GYS
 3:                   am43xx-gpevm: BOOT: PASS:
http://slexy.org/raw/s2DMkJGmdF
 4:                  pandaboard-es: BOOT: PASS:
http://slexy.org/raw/s204jfptrr
 5:             pandaboard-vanilla: BOOT: PASS:
http://slexy.org/raw/s2cbd82pMI
 6:                        sdp4430: BOOT: PASS:
http://slexy.org/raw/s21bzlzUNr
TOTAL = 6 boards, Booted Boards = 6, No Boot boards = 0


against the patch series: (all am437x platforms fail)

testing
 1:                      am437x-sk: BOOT: FAIL:
http://slexy.org/raw/s2yhDXyF7o
 2:                    am43xx-epos: BOOT: FAIL:
http://slexy.org/raw/s2m9cSdt55
 3:                   am43xx-gpevm: BOOT: FAIL:
http://slexy.org/raw/s2MqFFBuIl
 4:                  pandaboard-es: BOOT: PASS:
http://slexy.org/raw/s2XwggyB0a
 5:             pandaboard-vanilla: BOOT: PASS:
http://slexy.org/raw/s25WDvtbob
 6:                        sdp4430: BOOT: PASS:
http://slexy.org/raw/s2gjynR1Co
TOTAL = 6 boards, Booted Boards = 3, No Boot boards = 3

I am trying to understand what is different in AM437x except that it
is a single A9 instead of OMAP4 style dual A9s.

-- 
Regards,
Nishanth Menon
