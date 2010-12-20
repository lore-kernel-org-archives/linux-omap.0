From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: protect dmm_map properly
Date: Mon, 20 Dec 2010 20:43:50 +0200
Message-ID: <AANLkTi=B2MFz=c9gzcP3ZpApipShYbK88sbFmOOn3QKM@mail.gmail.com>
References: <1292865120-24020-1-git-send-email-felipe.contreras@nokia.com>
	<AANLkTi=C4hvf9t9j51TE3JNdygHbjf-vAQBvdf+Oimfh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=C4hvf9t9j51TE3JNdygHbjf-vAQBvdf+Oimfh@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 20, 2010 at 8:30 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> On Mon, Dec 20, 2010 at 11:12 AM, Felipe Contreras
> <felipe.contreras@nokia.com> wrote:
>> We need to protect not only the dmm_map list, but the individual
>> map_obj's, otherwise, we might be building the scatter-gather list w=
ith
>> garbage. So, use the existing proc_lock for that.
>>
>> I observed race conditions which caused kernel panics while running
>> stress tests. This patch fixes those.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
>> ---
>> =C2=A0drivers/staging/tidspbridge/rmgr/proc.c | =C2=A0 18 ++++++++++=
++++----
>> =C2=A01 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/stagi=
ng/tidspbridge/rmgr/proc.c
>> index b47d7aa..21052e3 100644
>> --- a/drivers/staging/tidspbridge/rmgr/proc.c
>> +++ b/drivers/staging/tidspbridge/rmgr/proc.c
>> @@ -781,12 +781,14 @@ int proc_begin_dma(void *hprocessor, void *pmp=
u_addr, u32 ul_size,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(u32)pmpu_addr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ul_size, dir);
>>
>> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&proc_lock);
>
> May be you should use mutex_lock_interruptable instead of =C2=A0mutex=
_lock.

Right, but I think that should be a separate patch since
mutex_lock(&proc_lock) is already being used.

>> @@ -819,12 +823,14 @@ int proc_end_dma(void *hprocessor, void *pmpu_=
addr, u32 ul_size,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(u32)pmpu_addr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ul_size, dir);
>>
>> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&proc_lock);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* find requested memory are in cached ma=
pping information */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0map_obj =3D find_containing_mapping(pr_ct=
xt, (u32) pmpu_addr, ul_size);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!map_obj) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("%s: f=
ind_containing_mapping failed\n", __func__);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D -E=
=46AULT;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_map;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (memory_regain_ownership(map_obj, (u32=
) pmpu_addr, ul_size, dir)) {
>> @@ -834,6 +840,8 @@ int proc_end_dma(void *hprocessor, void *pmpu_ad=
dr, u32 ul_size,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;
>
> Mutex is not released in this case as it is released only at no_map.

Oops! I didn't test proc_end_dma() and quickly added those locks after
I noticed it. I'll resend with the fix.

--=20
=46elipe Contreras
