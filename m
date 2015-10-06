From: Felipe Balbi <balbi@ti.com>
Subject: Re: cpufreq-dt error: failed to init cpufreq table: -61
Date: Tue, 6 Oct 2015 10:07:20 -0500
Message-ID: <87zizw2fyv.fsf@saruman.tx.rr.com>
References: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com> <87fv1o3xmo.fsf@saruman.tx.rr.com> <CAAfyv35mMiuLCCnJFjodNcx-iyOsz56-BPU7fkSc=AL1Xw5nJw@mail.gmail.com> <CAAfyv366=LOfy4_JeuRgjsbgBADWCanRt9X1JDv_eVkYe872Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAAfyv366=LOfy4_JeuRgjsbgBADWCanRt9X1JDv_eVkYe872Dw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Belisko Marek <marek.belisko@gmail.com> writes:

> Hi,
>
> On Tue, Oct 6, 2015 at 4:03 PM, Belisko Marek <marek.belisko@gmail.com> w=
rote:
>> Hi Felipe,
>>
>> On Tue, Oct 6, 2015 at 4:00 PM, Felipe Balbi <balbi@ti.com> wrote:
>>>
>>> Hi,
>>>
>>> Belisko Marek <marek.belisko@gmail.com> writes:
>>>> Hi Tony,
>>>>
>>>> I'm using custom am33xx board where mpu voltage can be changed through
>>>> gpio regulator on 4.1 (latest stable) kernel. I defined gpio-regulator
>>>> node and also operating-points to DT. Gpio regulator seems to be
>>>> working fine but during probing cpufreq-dt I get error:
>>>> failed to init cpufreq table: -61
>>>>
>>>> I did small investigation and seem that dev_pm_opp_init_cpufreq_table
>>>> fails at first condition dev_pm_opp_get_opp_count <=3D 0 and this is
>>>> because opp_list is empty. So it seems that any opp for am33xx aren't
>>>> defined if I'm getting it right. I did look to mach-omap2/opp3xxx_data
>>>> but there is nothing am33xx specific. It is known problem or exist
>>>> some patches around to fix that? Many thanks.
>>>
>>> OPP initialization is not in mainline yet, there are some out-of-tree
>>> patches which TI has been working on. If you want to use them, have a
>>> look at TI's vendor kernel at [1]
>> Thanks for link. One thing which is still not puzzled before I use 3.9
>> kernel and it was working fine
>> it's stops working when bumped to 4.1.
>
> Sorry information was incorrect. On 3.9 kernel we did use tps, pmic
> now we have only gpio regulator so this is the difference.

okay, if it's only a regulator how can you set different voltages ?
Seems like you won't be able to do anything more than enable/disable a
voltage rail.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE+OpAAoJEIaOsuA1yqREvXAP/A2maIn62LAbJ1TT2bluStEc
0LiNkNVKhRMHKOxC+dnwJ2XE+6qaFk+QgdJ9VaT+VHlb+CBR+1lFM6upS3SQTtG2
N2VX7gGVp1VzNvcji5LIhNQM+Bs7cVOI4i2vTZKqUTcordUO3GDrQ6QnTyNjTDX9
4qmk9MvC+NX+xJaONTOMWCDqk9/qnD8PksJIl+j8xi50sWID6wPV1WrKxsuVOJ/V
ng4c4PajI5w9fZmxTjdsTtusZyawmPCc1TVAMR+UL/TdhHbU2IIMyh2nSLtCgFU3
xFhL0ZSsjFqcVWqJThmam+1DaXu+NzEiHg1tqB1PVVhi7tvNNZQBiULHkyLVDKaI
gMXzriL4W/leqG5fDDkiYXXOLlXiOuRo5Zd6Vc+SeIcwdqhaHlnLoeBxOf42dyzJ
7pbBd7xjLm0dBdeDZkg5u+Z3DoOxQurYaD9/yOJAitAZfDhjJ3mZR36Bkg1WHTYm
fQSyX7we2jMSH4rgcqlYKBh9WLQqgCMU8oralSCzf2DmCARvIGGefeCFYtxn4Txs
6580A/AW0AEM6r8x2XG0UEQ2BL/EL0nUmgcn8aZMwansF8dJDkwtv2q3GsVaqLA9
34tnKBeRZVmEBW7xopEG/frKcZ1OsYARYPajVd9W7jFXjZ8N8yVt6PdJvHaaeDUf
lwszQ+EvpM78SVwqG1i8
=bcfU
-----END PGP SIGNATURE-----
--=-=-=--
