From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: Align the memcpy acnt array size with
 the transfer
Date: Fri, 15 Sep 2017 21:52:36 +0300
Message-ID: <aa913f99-189a-fda0-9867-a3897a5e0fa3@ti.com>
References: <20170915072328.7415-1-peter.ujfalusi@ti.com>
 <20170915164707.GD27343@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915164707.GD27343@kroah.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 09/15/2017 07:47 PM, Greg KH wrote:
> On Fri, Sep 15, 2017 at 10:23:28AM +0300, Peter Ujfalusi wrote:
>> =EF=BB=BFMemory to Memory transfers does not have any special alignment =
needs
>> regarding to acnt array size, but if one of the areas are in memory mapp=
ed
>> regions (like PCIe memory), we need to make sure that the acnt array siz=
e
>> is aligned with the mem copy parameters.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/edma.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>=20
> </formletter>

Sorry, I forgot to add the CC to the patch itself. I will resend it with th=
e
correct form.

--=20
P=C3=A9ter
