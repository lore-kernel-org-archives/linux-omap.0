From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain backward
 compatibility.
Date: Mon, 2 Dec 2013 13:09:31 -0500
Message-ID: <529CCCDB.4030904@ti.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com> <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com> <20131202115422.1f8c73f6@skate> <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com> <20131202160219.40286dc9@skate> <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com> <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com> <20131202165103.726314d9@skate>	<529CAEA3.2080808@ti.com> <20131202170606.2191fd89@skate> <20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com> <20131202171907.56c9300a@skate> <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com> <CAOf5uwmG=QnjPsD3MDeK3uP0_wM3f9QEqbFLJuVJ7Su6v54n1Q@mail.gmail.com> <20980858CB6D3A4BAE95CA194
 937D5E73EA50ADE@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60286 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab3LBSJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 13:09:37 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA50ADE@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Javier Martinez Canillas (javier@dowhile0.org)" <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

On 12/02/2013 12:46 PM, Gupta, Pekon wrote:
>>> So coming back to the specific problem here.
>>> I think we need 'nandecc' back in u-boot till atleast all systems have
>>> migrated to BCH16 or whatever highest ecc-scheme which can be
>>> supported on OMAP devices.
>>>
> 
> Forgot to mention, one more way of updating boot-loaders with
> different ecc-scheme via kernel. This can be helpful when:
> - you want to remotely upgrade your u-boot, but your kernel is statically
>    build with different ecc-scheme.
> - In production environment, where you boot multiple devices in parallel
>   (using say NFS boot), and then flash multiple devices without bothering
>    about ecc-schemes..
> 
> *Method*
> (1) Flash the u-boot image on one *sample* device selecting appropriate
>    ecc-scheme which ROM code understands.
> (2) Dump the complete image along with OOB appended (as a binary)
> (3) Use this binary image (with OOB included) to flash other devices
> from kernel as *raw* data (that means kernel will not append ECC while
> writing data, it will blindly write the image as-it-is on the partition).
> 
> This way the ECC with which u-boot image was built in (1) will get
> programmed, irrespective of what kernel supports..
> - I have seen at-least one customer going into production this way.
> - And I have been using this often too, though with older mtd-utils.

There are many ways to in essentially work around this problem, given
the ability to raw write (including OOB) from the kernel and from
u-boot.  This doesn't change the general problem of "we have cases where
we need part of the NAND with one scheme, another part of it with a
different one".

-- 
Tom
