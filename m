From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition
 with dma_inuse
Date: Fri, 22 Sep 2017 10:03:59 +0300
Message-ID: <9ed74f0c-9363-efbf-3fdf-47ebd1fd4eea@ti.com>
References: <20170921113532.15297-1-peter.ujfalusi@ti.com>
 <20170921173013.GL30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170921173013.GL30097@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFVinod,


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-21 20:30, Vinod Koul wrote:
> On Thu, Sep 21, 2017 at 02:35:32PM +0300, Peter Ujfalusi wrote:
>> When looking for unused xbar_out lane we should also protect the set_bit=
()
>> call with the same mutex to protect against concurrent threads picking t=
he
>> same ID.
>=20
> Applied, thanks
>=20
> Just a note, somehow the patches from you only are getting mangled for me=
.
> Curiously, the ones in patchworks are fine and I used to apply that, not =
sure
> what mail servers at our work places are doing!!

I'm afraid it is our mail servers where the mangling is happening :(
We are trying to resolve this since early August when it first started
to happen (and only for the guys in Finland).
We are as frustrated as one can be, believe me.

PS: And the mangler will add a footer on top of this mail

- P=C3=A9ter
