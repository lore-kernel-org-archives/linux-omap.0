From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] drivers/gpio: using common order: let 'static const'
 instead of 'const static'
Date: Wed, 06 Feb 2013 18:38:41 +0800
Message-ID: <511232B1.7090206@asianux.com>
References: <51122147.6080708@asianux.com> <5112241B.8050207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:36333 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3BFKir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 05:38:47 -0500
In-Reply-To: <5112241B.8050207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B402=E6=9C=8806=E6=97=A5 17:36, Santosh Shilimkar =
=E5=86=99=E9=81=93:
> On Wednesday 06 February 2013 02:54 PM, Chen Gang wrote:
>> >=20
>> >    'const static ' is not a common order, better to use 'const sta=
tic' instead.
> You mean  " use static const  instead ", right ?
>=20

  oh, yes.  it is my miswritten.

  if necessary to send patch v2, please tell me.

  thanks.

  :-)

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
