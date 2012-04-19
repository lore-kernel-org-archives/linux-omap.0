From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 20:12:45 +0200
Message-ID: <1334859165.9998.43.camel@polaris.local>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	 <4F8FC572.80406@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([78.47.116.19]:57461 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab2DSTCO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 15:02:14 -0400
In-Reply-To: <4F8FC572.80406@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Thu, 2012-04-19 at 10:57 +0300, Igor Grinberg wrote:=20
> On 04/19/12 05:07, Paul Walmsley wrote:
> > Is anyone else seeing this?
>=20
> I've tried various configurations and can confirm this hang.
> I still haven't got my hands on bisecting this.
> There is nothing special about CM-T3517,
> IMO this can be seen on any AM35xx based board with EMAC, or am I mis=
taken?
> Anyway, can anybody try nfsroot on other AM35xx based board with EMAC=
 supported?

I have a board with the AM3505 and NFS root works fine here. I'm using
3.4-rc3, Mark A. Greer's patch series on this list (2012-04-11) and Pau=
l
Walmsley's fixes-for-v3.4-rc3 tag. A possible difference is that I'm
using the fixed PHY driver.

Best regards,
Jan L=C3=BCbbe
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
