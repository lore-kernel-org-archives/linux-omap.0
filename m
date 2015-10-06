From: Felipe Balbi <balbi@ti.com>
Subject: Re: cpufreq-dt error: failed to init cpufreq table: -61
Date: Tue, 6 Oct 2015 11:10:52 -0500
Message-ID: <87a8rw2d0z.fsf@saruman.tx.rr.com>
References: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com> <87fv1o3xmo.fsf@saruman.tx.rr.com> <CAAfyv35mMiuLCCnJFjodNcx-iyOsz56-BPU7fkSc=AL1Xw5nJw@mail.gmail.com> <CAAfyv366=LOfy4_JeuRgjsbgBADWCanRt9X1JDv_eVkYe872Dw@mail.gmail.com> <87zizw2fyv.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <87zizw2fyv.fsf@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <balbi@ti.com> writes:

> Belisko Marek <marek.belisko@gmail.com> writes:
>
>> Hi,
>>
>> On Tue, Oct 6, 2015 at 4:03 PM, Belisko Marek <marek.belisko@gmail.com> =
wrote:
>>> Hi Felipe,
>>>
>>> On Tue, Oct 6, 2015 at 4:00 PM, Felipe Balbi <balbi@ti.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Belisko Marek <marek.belisko@gmail.com> writes:
>>>>> Hi Tony,
>>>>>
>>>>> I'm using custom am33xx board where mpu voltage can be changed through
>>>>> gpio regulator on 4.1 (latest stable) kernel. I defined gpio-regulator
>>>>> node and also operating-points to DT. Gpio regulator seems to be
>>>>> working fine but during probing cpufreq-dt I get error:
>>>>> failed to init cpufreq table: -61
>>>>>
>>>>> I did small investigation and seem that dev_pm_opp_init_cpufreq_table
>>>>> fails at first condition dev_pm_opp_get_opp_count <=3D 0 and this is
>>>>> because opp_list is empty. So it seems that any opp for am33xx aren't
>>>>> defined if I'm getting it right. I did look to mach-omap2/opp3xxx_data
>>>>> but there is nothing am33xx specific. It is known problem or exist
>>>>> some patches around to fix that? Many thanks.
>>>>
>>>> OPP initialization is not in mainline yet, there are some out-of-tree
>>>> patches which TI has been working on. If you want to use them, have a
>>>> look at TI's vendor kernel at [1]
>>> Thanks for link. One thing which is still not puzzled before I use 3.9
>>> kernel and it was working fine
>>> it's stops working when bumped to 4.1.
>>
>> Sorry information was incorrect. On 3.9 kernel we did use tps, pmic
>> now we have only gpio regulator so this is the difference.
>
> okay, if it's only a regulator how can you set different voltages ?
                       ^^^^^^^^^
                       GPIO, rather


> Seems like you won't be able to do anything more than enable/disable a
> voltage rail.
>
> --=20
> balbi

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE/KNAAoJEIaOsuA1yqRE+7cP/3YeYeq6f9EgxiBWZQIPc9KY
8sm/1ps3exQyKr8WcDNdoYQtxp/ognVTx1hkflvjTp2S0k0kQmNuitaUxCEw2LFx
l52yBt0D4OY/TmWeDWDjYQtQvhv/hhNOvzHUz/N3evRB2HVjZLHEeY1W2FvOGSVP
xpkkra0r/R3PvKHOfSJFB6j2Nr9+YoWigrtTzJpDqXABHoH7MBPt4sZwV5bY+221
nwDlSvUQ/1QC1PzOXAixCUBEVoZVMW8ubJDFSSGqj7JOp+e1ZI19zeBCfA96JBT/
hvXKbObC0frYub/SBOVWNZxi1l0Ws3mQWDSaWL4D9rsrvay+kIGjwXxbJUcMoQJl
qAYOy6kqRZ3Yg6sEob34Oz0SdHbNDFUTQyUtpzwbjXoQiD9qf+11cEkX1AnvlAdk
qX4EpXnN90r8igBy9nQSUVMsfdPSkcshs7TLVfYK7lUdiCZEqPXc6TKo51huCKAO
aPCpOM2cZEAA4mjYmzFTQHC5nzn/rLku599WwybT7c5G2zRVIpyTjA1wNjRIwick
WUQqQ922slwXQDt6JZlZAWbVM/c6NGU1cnYFSRgM5zZ37wyLLu81hJtBQiuJtPyx
yBU+mT8YaHteOJUBR9g8H9DBUendNZu1S/zFnvp7Mc2ppOBlLTjkL28aJVmlNNHz
KmYSTGg33/tWSBs3XP7U
=Pg1x
-----END PGP SIGNATURE-----
--=-=-=--
