From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
Date: Fri, 6 Feb 2015 18:05:32 +0200
Message-ID: <54D4E64C.7060208@ti.com>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com> <20150206141346.GP21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150206141346.GP21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/06/2015 04:13 PM, Peter Zijlstra wrote:
> On Fri, Feb 06, 2015 at 02:48:34PM +0200, Peter Ujfalusi wrote:
>> Hi,
>>
>> In case when hwmods are used in nested way the lockdep validator wil=
l print out
>> a warning message about possible deadlock situation:
>>
>> [    4.514882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> [    4.520530] [ INFO: possible recursive locking detected ]
>> [    4.526176] 3.14.30-00289-ge44872fdca8f-dirty #198 Not tainted
>> [    4.532285] ---------------------------------------------
>> [    4.537936] kworker/u4:1/18 is trying to acquire lock:
>> [    4.543317]  (&(&oh->_lock)->rlock){......}, at: [<c002d2dc>] oma=
p_hwmod_enable+0x2c/0x58
>> [    4.552109]=20
>> [    4.552109] but task is already holding lock:
>> [    4.558216]  (&(&oh->_lock)->rlock){......}, at: [<c002d2dc>] oma=
p_hwmod_enable+0x2c/0x58
>> [    4.566999]=20
>> [    4.566999] other info that might help us debug this:
>> [    4.573831]  Possible unsafe locking scenario:
>> [    4.573831]=20
>> [    4.580025]        CPU0
>> [    4.582584]        ----
>> [    4.585142]   lock(&(&oh->_lock)->rlock);
>> [    4.589544]   lock(&(&oh->_lock)->rlock);
>> [    4.593945]=20
>> [    4.593945]  *** DEADLOCK ***
>> [    4.593945]=20
>> [    4.600146]  May be due to missing lock nesting notation
>>
>> What lockdep did not realizes is that the two oh is not the same hwm=
od object
>> and we have taken different locks.
>>
>> One example of nested hwmod usage is on DRA7xx platforms, where McAS=
P can be
>> configured to use ATL clock as it's functional clock. In this case t=
he
>> pm_runtime_get/put_sync call will enable the mcasp hwmod and as part=
 of this
>> operation it will enable the needed clocks. Since ATL clock is neede=
d, we will
>> have another pm_runtime operation from the ATL clock enable callback=
 which
>> will take the atl hwmod's lock. This will be seen by lockdep as poss=
ible
>> deadlock situation.
>>
>> In order to notify lockdep about this, we need to switch using _nest=
ed
>> version of locking function and assign different subclass to those h=
wmods which
>> could be used in nested way.
>=20
> IFF struct omap_hwmod is always statically allocated; as I think the
> __init on _register() mandates, you can use the below annotation.
>=20
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 1 +
>  arch/arm/mach-omap2/omap_hwmod.h | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 9025ffffd2dc..222d654ad6fd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2698,6 +2698,7 @@ static int __init _register(struct omap_hwmod *=
oh)
>  	INIT_LIST_HEAD(&oh->master_ports);
>  	INIT_LIST_HEAD(&oh->slave_ports);
>  	spin_lock_init(&oh->_lock);
> +	lockdep_set_class(&oh->_lock, &oh->hwmod_key);
> =20
>  	oh->_state =3D _HWMOD_STATE_REGISTERED;
> =20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/o=
map_hwmod.h
> index 5b42fafcaf55..754bdfb3f811 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -689,6 +689,8 @@ struct omap_hwmod {
>  	u8				_state;
>  	u8				_postsetup_state;
>  	struct omap_hwmod		*parent_hwmod;
> +
> +	struct lock_class_key		hwmod_key;
>  };
> =20
>  struct omap_hwmod *omap_hwmod_lookup(const char *name);

Certainly looks much simpler, but it adds quite a bit of data to the
omap_hwmod struct, and we have a _lot_ of them for omap2plus configurat=
ion.

ls -al vmlinux

w/o any the lockdep warning fixes:
110109168

With my series applied:
110112031 (base + 2863)

With setting individual lockdep class:
110114275 (base + 5107)

I certainly like the lockdep_set_class() way since it is cleaner, but i=
t adds
almost double amount of bytes to the kernel.
I'll test the patch on my board tomorrow as first thing.

--=20
P=E9ter
