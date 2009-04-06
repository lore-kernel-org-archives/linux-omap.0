From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 06 Apr 2009 10:41:14 +0300
Message-ID: <49D9B21A.2000002@yandex.ru>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>	 <f9d2a5e10904031757m5f4fe968mb50b9d58e17501dc@mail.gmail.com> <1238813563.12072.4.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25745 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbZDFHlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 03:41:31 -0400
In-Reply-To: <1238813563.12072.4.camel@surfer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>
Cc: Russ Dill <russ.dill@gmail.com>, linux-omap@vger.kernel.org

David Hagood wrote:
> Well, that's not what I would have expected - I would have thought
> reads on POP would have been faster than that, and cheaper - the SD
> being the same speed but less CPU is surprising.

1. As Russ and David said, OneNAND driver does not really
use DMA, because the I/O is done in 2K chunks, and this
is just too small piece of data for DMA.

2. UBIFS also compresses data on-the-flight. You may try
disabling it and see what changes, but probably not
too much, because of the way the driver writes (no DMA).
Try mounting with 'compre=3Dnone' option, see here:

http://www.linux-mtd.infradead.org/doc/ubifs.html#L_mountopts

BTW, some compression testing results may be found here:

http://www.linux-mtd.infradead.org/misc/misc.html#L_ubifs_compr

although they are not 100% relevant for this case.

3. UBIFS provides you greater data reliability. E.g., it
CRCs all data (see here
http://www.linux-mtd.infradead.org/doc/ubifs.html#L_checksumming)
OneNAND was very reliable last time we tested it, and we
disable _some_ CRC checking for it. Try to use the
'no_chk_data_crc' and get better read speed.

4. UBIFS has 'bulk read' feature which works well on OneNAND,
(see here: http://www.linux-mtd.infradead.org/doc/ubifs.html#L_readahea=
d)
Try to enable it as well. You should end up with faster
read speed.

5. Last but not least, UBIFS+OneNAND provides just another
level of reliability, comparing to SD. In general, SDs are
not very good for storing system libraries, etc. I tried to
summarize this at some point here:

http://www.linux-mtd.infradead.org/doc/ubifs.html#L_raw_vs_ftl

HTH.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
