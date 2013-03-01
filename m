From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Sat, 2 Mar 2013 01:51:39 +0200
Message-ID: <20130301235138.GD22941@blackmetal.musicnaut.iki.fi>
References: <604513288.26328.1362132552062.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:40613 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab3CAXvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 18:51:50 -0500
Content-Disposition: inline
In-Reply-To: <604513288.26328.1362132552062.JavaMail.apache@mail83.abv.bg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 01, 2013 at 12:09:12PM +0200, =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=
=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
> Unfortunately it is necessary, on RX-51 PPA/NOLO leaves IBE bit unset=
=2E

You sure? I think you need to explain this more - the commit message in
the original patch is empty/missing...

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
