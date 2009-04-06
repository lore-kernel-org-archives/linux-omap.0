From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 6 Apr 2009 01:13:03 -0700
Message-ID: <f9d2a5e10904060113g37c3dd7fk5be6d3a12ab169c4@mail.gmail.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
	 <f9d2a5e10904031757m5f4fe968mb50b9d58e17501dc@mail.gmail.com>
	 <1238813563.12072.4.camel@surfer> <49D9B21A.2000002@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:10017 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZDFINH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 04:13:07 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2094230rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 01:13:04 -0700 (PDT)
In-Reply-To: <49D9B21A.2000002@yandex.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind@yandex.ru>
Cc: David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

On Mon, Apr 6, 2009 at 12:41 AM, Artem Bityutskiy <dedekind@yandex.ru> =
wrote:
> David Hagood wrote:
>>
>> Well, that's not what I would have expected - I would have thought
>> reads on POP would have been faster than that, and cheaper - the SD
>> being the same speed but less CPU is surprising.
>
> 1. As Russ and David said, OneNAND driver does not really
> use DMA, because the I/O is done in 2K chunks, and this
> is just too small piece of data for DMA.

All very relevant, but just to avoid confusion; the tests were
performed on a Beagleboard with 256MB of Micron NAND.

http://www.micron.com/products/partdetail?part=3DMT29C2G24MAKLAJG-6 IT

Also, it appears from looking an the openzoom git, there are some
patches to add DMA support in, but I'm not sure what effect they have.

> 2. UBIFS also compresses data on-the-flight. You may try
> disabling it and see what changes, but probably not
> too much, because of the way the driver writes (no DMA).
> Try mounting with 'compre=3Dnone' option, see here:
>
> http://www.linux-mtd.infradead.org/doc/ubifs.html#L_mountopts
>
> BTW, some compression testing results may be found here:
>
> http://www.linux-mtd.infradead.org/misc/misc.html#L_ubifs_compr
>
> although they are not 100% relevant for this case.
>
> 3. UBIFS provides you greater data reliability. E.g., it
> CRCs all data (see here
> http://www.linux-mtd.infradead.org/doc/ubifs.html#L_checksumming)
> OneNAND was very reliable last time we tested it, and we
> disable _some_ CRC checking for it. Try to use the
> 'no_chk_data_crc' and get better read speed.
>
> 4. UBIFS has 'bulk read' feature which works well on OneNAND,
> (see here: http://www.linux-mtd.infradead.org/doc/ubifs.html#L_readah=
ead)
> Try to enable it as well. You should end up with faster
> read speed.
>
> 5. Last but not least, UBIFS+OneNAND provides just another
> level of reliability, comparing to SD. In general, SDs are
> not very good for storing system libraries, etc. I tried to
> summarize this at some point here:
>
> http://www.linux-mtd.infradead.org/doc/ubifs.html#L_raw_vs_ftl
>
> HTH.
>
> --
> Best Regards,
> Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=
=8E=D1=86=D0=BA=D0=B8=D0=B9)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
