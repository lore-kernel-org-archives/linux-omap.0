From: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Subject: Fwd: Omap3430 does not resume after suspend
Date: Wed, 4 Feb 2009 13:00:39 +0530
Message-ID: <d105d8d00902032330h7e6eb1f2pd96df04858d0df55@mail.gmail.com>
References: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301C7069769@dbde02.ent.ti.com>
	 <d105d8d00902022214r4f67ecdcp4ce153f0c88cb512@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301C70FEB63@dbde02.ent.ti.com>
	 <d105d8d00902032230w2a5ff7a3yd3511002cbcc9850@mail.gmail.com>
	 <3a2dabf50902032244t4e045587idf6e574c1fca654f@mail.gmail.com>
	 <87tz7a8z3b.fsf@deeprootsystems.com>
	 <d105d8d00902032329u2878dbf0m2609ca70b08feb7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:50193 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZBDHaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 02:30:39 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2433276rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 23:30:39 -0800 (PST)
In-Reply-To: <d105d8d00902032329u2878dbf0m2609ca70b08feb7d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux-omap@vger.kernel.org, grgupta77@gmail.com

---------- Forwarded message ----------
=46rom: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Date: Wed, Feb 4, 2009 at 12:59 PM
Subject: Re: Omap3430 does not resume after suspend
To: Kevin Hilman <khilman@deeprootsystems.com>


But the problem is I am using 3430 ldp board, and sdp board is not
available to me.
I used omap_ldp_defconfig and got error while attempting 'echo mem>
/sys/power/state'
       How can I do it on LDP board? Does this work for LDP board?
Thanks,
Shreyas.


On Wed, Feb 4, 2009 at 12:31 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ramesh Gupta Guntha <grgupta77@gmail.com> writes:
>
>> Hi Shreyas,
>>
>> On 2/4/09, Shreyas Mahajan <mahajan.shreyas@gmail.com> wrote:
>>>  Hi,
>>>    Thanks for constantly tolerating my ignorance. I git-cloned the
>>> latest PM tree available and booted my 3430 LDP board with ldp
>>> defconfig configuration. Now the problem regarding hanging of machi=
ne
>>> after some small interval is solved but when I done 'echo mem
>>> >/sys/power/state' it gives error to suspend,
>>> This is log for it,
>>>
>>> '/ # echo mem > /sys/power/state
>>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>>> done.
>>> Freezing user space processes ... Freezing user space processes ...
>>> (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>> done.
>>> Freezing remaining freezable tasks ... Freezing remaining freezable
>>> tasks ... (elapsed 0=EF=BF=BD )=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
r$=EF=BF=BDPowerdomain (core_pwrdm) d1
>>> Powerdomain (per_pwrdm) didn't enter target state 1
>>>             =EF=BF=BD*43
>>> Could not enter target state in pm_suspendend to debug)
>>> =EF=BF=BD 1=EF=BF=BD=D5=BC=EF=BF=BD=EF=BF=BD=EF=BF=BD, =E6=A3=AE=EF=
=BF=BD=D1=A0r=EF=BF=BD=EF=BF=BD
>>> Restarting tasks ... Restarting tasks ... done.%=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD J$=EF=BF=BD4%=EF=BF=
=BD% =D1=B4=EF=BF=BD*43
>>> done.F=EF=BF=BD=F3=B0=AF=85)=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD J=
$=EF=BF=BD4%=EF=BF=BD% =D1=B4=EF=BF=BD*43
>>> '
>>> I searched similar problems on mailing list, in which suspend log
>>> contains exactly which process could not be stopped as reason to
>>> suspend failure. But in above log, I could not interpret such a
>>> reason.
>>>         Could anyone please help me with this?
>>
>> Please look into below mail thread on the PM off mode support in l-o=
 list.
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08968.html
>>
>> If you are trying it on SDP , use u-boot mentioned in the above link=
=2E
>>
>>
>> use below settings before running echo mem > /sys/power/state for of=
f mode.
>>
>> echo 1 > /sys/power/clocks_off_while_idle
>> echo 1 > /sys/power/voltage_off_while_idle
>> echo 1 > /sys/power/enable_off_mode
>>
>>
>> I tried it on my SDP with omap_3430sdp_min_defconfig, I am seeing al=
l
>> the domains entering to OFF mode.
>>
>
> In addition to above, I suggest you turn of CONFIG_DEBUG_LL as well a=
s
> that will clutter up your serial console with garbage during
> suspend/resume.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
