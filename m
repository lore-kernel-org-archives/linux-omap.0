From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
Date: Fri, 11 May 2012 03:22:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
References: <20120510172449.13418.66815.stgit@dusk> <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-153787301-1336728167=:3201"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55874 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab2EKJWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 05:22:48 -0400
In-Reply-To: <4FACD255.3080702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-153787301-1336728167=:3201
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=C3=AEt

On Fri, 11 May 2012, Cousson, Benoit wrote:

> I do not have any clue about that chip, but is this clock really what it =
is
> supposed to be? I mean, isn't the uart1_fck the parent of all the UART fc=
k or
> something like that. Don't we just have an issue becasue the clock names =
are
> not accurate?

I guess that's what I'm trying to find out.

According to the AM3517 TRM rev. B (SPRUGR0B) Figure 14-20 "UART=20
Functional Integration" and Table 14-11 "UART Clocks", all of the UARTs=20
appear to have independent functional clocks.  The table even mentions a=20
CM_FCLKEN1_CORE.EN_UART4 bit.  But the PRCM chapter of this TRM doesn't=20
mention that at all.  So the documentation is not too useful here.

On the rest of the OMAPs, as far as I know, the UART clocks are all=20
separate.


- Paul
--155748971-153787301-1336728167=:3201--
