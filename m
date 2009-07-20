From: arun c <arun.edarath@gmail.com>
Subject: Re: [PATCH 9/10] drivers/mmc: Move a dereference below a NULL test
Date: Mon, 20 Jul 2009 18:03:40 +0530
Message-ID: <c656a4d20907200533t1cbe1476l62d8a51fdb796c70@mail.gmail.com>
References: <Pine.LNX.4.64.0907191729580.16542@ask.diku.dk>
	 <4A642458.6080008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753630AbZGTMdn@vger.kernel.org>
In-Reply-To: <4A642458.6080008@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Julia Lawall <julia@diku.dk>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 20, 2009 at 1:31 PM, Adrian Hunter<adrian.hunter@nokia.com>=
 wrote:
> Julia Lawall wrote:
>>
>> From: Julia Lawall <julia@diku.dk>
>>
>> If the NULL test is necessary, then the dereference should be moved =
below
>> the NULL test.
>>
>> The semantic patch that makes this change is as follows:
>> (http://www.emn.fr/x-info/coccinelle/)
>>
>> // <smpl>
>> @@
>> type T;
>> expression E,E1;
>> identifier i,fld;
>> statement S;
>> @@
>>
>> - T i =3D E->fld;
>> + T i;
>> =A0... when !=3D E=3DE1
>> =A0 =A0 =A0when !=3D i
>> =A0BUG_ON (E =3D=3D NULL||
>> - =A0 =A0 i
>> + =A0 =A0 E->fld
>> =A0 =A0 =A0 =3D=3D NULL || ...);
>> + i =3D E->fld;
>> // </smpl>
>>
>> Signed-off-by: Julia Lawall <julia@diku.dk>
>>
>> ---
>> =A0drivers/mmc/host/omap.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>> index e7a331d..89281ab 100644
>> --- a/drivers/mmc/host/omap.c
>> +++ b/drivers/mmc/host/omap.c
>> @@ -255,11 +255,12 @@ static void mmc_omap_slot_release_work(struct
>> work_struct *work)
>> =A0=A0static void mmc_omap_release_slot(struct mmc_omap_slot *slot, =
int
>> clk_enabled)
>> =A0{
>> - =A0 =A0 =A0 struct mmc_omap_host *host =3D slot->host;
>> + =A0 =A0 =A0 struct mmc_omap_host *host;
>> =A0 =A0 =A0 =A0unsigned long flags;
>> =A0 =A0 =A0 =A0int i;
>> =A0- =A0 =A0 =A0 BUG_ON(slot =3D=3D NULL || host->mmc =3D=3D NULL);
>> + =A0 =A0 =A0 BUG_ON(slot =3D=3D NULL || slot->host->mmc =3D=3D NULL=
);
>> + =A0 =A0 =A0 host =3D slot->host;
>> =A0 =A0 =A0 =A0 =A0if (clk_enabled)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Keeps clock running for at least 8=
 cycles on valid freq
>> */
>> --
>
> If slot is NULL it will oops anyway, so the following is better IMHO:
>
> static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int
> clk_enabled)
> {
> =A0 =A0 =A0 =A0struct mmc_omap_host *host =3D slot->host;
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0int i;
>
>> - =A0 =A0 =A0 BUG_ON(slot =3D=3D NULL || host->mmc =3D=3D NULL);
>> + =A0 =A0 =A0 BUG_ON(host->mmc =3D=3D NULL);
>
> =A0 =A0 =A0 =A0if (clk_enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Keeps clock running for at least 8 =
cycles on valid freq */
> --

According to http://isc.sans.org/diary.html?storyid=3D6820&rss "NULL ch=
eck"
must be done before assigning the values. Does Julia Lawall's version
is the more correct one??

Arun
