From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/25] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dma/
Date: Tue, 13 Oct 2015 11:58:33 +0300
Message-ID: <561CC7B9.8000201@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
 <20151012160024.GF27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012160024.GF27370@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/12/2015 07:00 PM, Vinod Koul wrote:
> On Thu, Sep 24, 2015 at 01:01:58PM +0300, Peter Ujfalusi wrote:
>> Move the code out from arch/arm/common and merge it inside of the dm=
aengine
>> driver.
>> This change is done with as minimal change to the code as possible t=
o avoid
>> any possibilities to introducing regression.
>=20
> Is this a pure move patch or code has been modified, if latter am
> disappointed that existing code style issue have not been fixed

Yes, it is mostly code move, I have done minimal changes only needed to=
 get
the moved code working in the new location.
Patch 13 in this series will go through the file and will fix up most (=
I hope
all) of the outstanding coding style issues.
At this point I wanted to have as small change as possible.

>> +static inline void edma_write(struct edma_cc *ecc, int offset, int =
val)
>> +{
>> +	__raw_writel(val, ecc->base + offset);
>> +}
>> +static inline void edma_modify(struct edma_cc *ecc, int offset, uns=
igned and,
>> +			       unsigned or)
>=20
> This looks bad on my 80 char screen, and few more places below
>=20
>> +{
>> +	unsigned val =3D edma_read(ecc, offset);
>=20
> checkpatch should have asked you to add empty line here, many places =
below
> too
>=20
>> +	val &=3D and;
>> +	val |=3D or;
>> +	edma_write(ecc, offset, val);
>> +}
>=20
> empty line here and few more places
>=20
> More later :)
>=20


--=20
P=E9ter
