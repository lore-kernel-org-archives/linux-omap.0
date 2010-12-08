From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Wed, 8 Dec 2010 13:19:24 +1300
Message-ID: <201012081319.24319.manningc2@actrix.gen.nz>
References: <LD1ZTZ$A8E18B744A1EDB29645809E1CAA11B96@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:43575 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754378Ab0LHAT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 19:19:28 -0500
In-Reply-To: <LD1ZTZ$A8E18B744A1EDB29645809E1CAA11B96@aruba.it>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-omap@vger.kernel.org, notasas@gmail.com

On Tuesday 07 December 2010 23:29:59 Luca Ceresoli wrote:
> Luca Ceresoli wrote:
> > While I thank you for you proposed solution, I see it does not work here.
> > In fact I commented the #define CONFIG_MTD_NAND_OMAP_HWECC and left
> > MTD_NAND_OMAP_PREFETCH disabled as it previously was, and got compilation
> > errors:
>
> Wrong, sorry. Your solution compiles and works. I had another change in
> that file that broke compilation.

Luca, I have been having similar problems on a hacked Overo kernel.

I have no problems with 2.6.35.

I tried just commenting out the define and disabling PREFETCH and did not get 
a good boot due to ubi not finding the volume info.

Are you loading up a UBI image with uboot?

Are you using the ubi volume as rootfs?

>
> Nevertheless, it's not clear to me whether the long-term direction is to
> switch to HWECC, and if it is expected to work in current builds, or if
> SWECC in here to stay.
>

Clearly HWECC has some advantages, but UBI and HWECC need some effort to get 
working together.

-- Charles
