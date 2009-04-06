From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 06 Apr 2009 12:07:01 +0300
Message-ID: <49D9C635.4040000@yandex.ru>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>	 <f9d2a5e10904031757m5f4fe968mb50b9d58e17501dc@mail.gmail.com>	 <1238813563.12072.4.camel@surfer> <49D9B21A.2000002@yandex.ru> <f9d2a5e10904060113g37c3dd7fk5be6d3a12ab169c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29641 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZDFJHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 05:07:40 -0400
In-Reply-To: <f9d2a5e10904060113g37c3dd7fk5be6d3a12ab169c4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

Russ Dill wrote:
> On Mon, Apr 6, 2009 at 12:41 AM, Artem Bityutskiy <dedekind@yandex.ru=
> wrote:
>> David Hagood wrote:
>>> Well, that's not what I would have expected - I would have thought
>>> reads on POP would have been faster than that, and cheaper - the SD
>>> being the same speed but less CPU is surprising.
>> 1. As Russ and David said, OneNAND driver does not really
>> use DMA, because the I/O is done in 2K chunks, and this
>> is just too small piece of data for DMA.
>=20
> All very relevant, but just to avoid confusion; the tests were
> performed on a Beagleboard with 256MB of Micron NAND.
=20
Ok, sorry. The CRC part should be relevant.
The bulk_read part may also be relevant if your HW is
able to read multiple NAND pages faster than reading
them one-by-one. The compression links should be
helpful for compressor selection.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
