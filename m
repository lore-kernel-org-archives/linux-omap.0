From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 14:23:07 +0000
Message-ID: <yw1xhazuxvas.fsf@unicorn.mansr.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
	<CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
	<20120116105949.GG16726@n2100.arm.linux.org.uk>
	<CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
	<20120116131329.GA928@n2100.arm.linux.org.uk>
	<CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
	<WC20120117085444.17057E@terrafix.co.uk>
	<20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com>
	<20120117134143.GF11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:37836 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab2AQOXJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 09:23:09 -0500
In-Reply-To: <20120117134143.GF11475@arm.com> (Catalin Marinas's message of
	"Tue, 17 Jan 2012 13:41:43 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Jan 17, 2012 at 12:27:25PM +0000, Aneesh V wrote:
>=20
>> But I thought enabling L2$ again in kernel is the cleaner solution.
>
> Why? It gets enabled via SCTLR.M together with L1.

Not if the L2EN bit of the auxiliary control register was cleared, and
u-boot messes with this bit.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
