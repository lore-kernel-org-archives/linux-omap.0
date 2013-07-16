From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/5] mtd: nand: omap: optimized chip->ecc.correct()
 for H/W ECC schemes
Date: Tue, 16 Jul 2013 07:47:04 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E84B4@DBDE04.ent.ti.com>
References: <1373900152-26885-1-git-send-email-pekon@ti.com>
	<1373900152-26885-2-git-send-email-pekon@ti.com>
 <CAGBQFKSqcDmJcdgLWdtxZmgjmjMnLgJXUARSu0NgNVpUGSRa7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37942 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935Ab3GPHr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 03:47:59 -0400
In-Reply-To: <CAGBQFKSqcDmJcdgLWdtxZmgjmjMnLgJXUARSu0NgNVpUGSRa7g@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: avinash philip <avinashphilipk@gmail.com>
Cc: "dedekind1@gmail.com" <dedekind1@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> Hi Pekon,
> 
> On Mon, Jul 15, 2013 at 8:25 PM, Pekon Gupta <pekon@ti.com> wrote:
> > chip->ecc.correct() is used for detecting and correcting bit-flips during read
> > operations. In omap2-nand driver this is done usingt following functions:
> >
> > - omap_correct_data(): for H/W based HAM1_ECC schemes
> >         (Un-Touched in current patch)
> >
> > - omap_elm_correct_data(): for H/W based BCHx_ECC scheme
> >         Current implementation of this function is not scalable for newer ECC
> >         schemes because:
> >         - It depends on a specific byte-position in OOB area (reserved as 0x00)
> >           to differentiates between programmed-pages and erased-pages.
> >           This reserved byte-position cannot be accomodated in all ECC
> schemes.
> >         - Current code is not scalable for future ECC schemes due to tweaks for
> >           BCH4_ECC and BCH8_ECC at multiple places.
> >         - It checks for bit-flips in Erased-pages using check_erased_page().
> >           This is over-work, as sanity of Erased-page can be verified by just
> >           comparing them to a pre-defined ECC-syndrome for all_0xFF data.
> 
> This is correct if the erased page read back didn't have any bit flips.
> If erased page result in bit flips, then this method will end up in
> un-correctable
> error. Can you please confirm you taken care erased page bit flips in this
> modification?
> 
> I think below discussion would help.
> 
> https://lkml.org/lkml/2012/11/22/590
> 

Yes, that is correct.. Please refer to latest discussion on this topic.
http://permalink.gmane.org/gmane.linux.drivers.mtd/46821

So, if a erased-page has any bit-flips, nand_read() would return it as
 EBADMSG (uncorrectable errors). I understand this is an over-cautious
 approach, but there are reasons for this:
(1) I din't wanted to burden the Read data-path with extra checks for 
finding and correcting bit-flips on erased-pages.

(2) Most File-Systems, if find un-correctable errors in erased-page 
would first torture_peb() by iteratively erasing and  checking for all(0xFF).
 So if the bit-flips were temporary they would go-away. And block would
 not be marked bad.

(3) Using erased-page with 'correctable bit-flips' for storing data makes
data on flash more vulnerable to early failures. Suppose using BCH8 
ECC scheme which has capability of correcting 8-bits per ecc.size. 
if my File-System uses an erased-page which already had 3-bit-flips 
before even it was written. So this leaves me with only 8-3 = 5 bit-flips
possibility before my data is rendered un-correctable and corrupt.
So, why not to use a erased-page which is not having any bit-flips at all ?
(And frequency of having bit-flips in erased-page would increase as
device ages)

I think from a user's point-of-view it would be better to get..
(a) more tolerance of bit-flips  + better read performance
v/s
(b) saving some blocks from getting re-erased.

Comments ?

with regards, pekon

> Thanks
> Avinash
