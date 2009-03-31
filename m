From: Russ Dill <russ.dill@gmail.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 31 Mar 2009 00:01:40 -0700
Message-ID: <f9d2a5e10903310001q7875927x261c8bf5ffb964ee@mail.gmail.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <1237914611.23022.124.camel@blackhole>
	 <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
	 <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	 <f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	 <873acu26ms.fsf@deeprootsystems.com>
	 <f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:51054 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbZCaHBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 03:01:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2870310rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 00:01:40 -0700 (PDT)
In-Reply-To: <f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

BTW, the 9 clocks active on per are:

gpio{2-6}_ick
per_l4_ick
uart3_ick
uart3_fck
per_48m_fck

During sleep, I get (for the per_clkdm only):

clockdomain: clkdm per_clkdm: removing clk uart3_ick
clockdomain: clkdm per_clkdm: removing clk per_48m_fck
clockdomain: clkdm per_clkdm: removing clk uart3_fck
clockdomain: clkdm per_clkdm: adding clk uart3_ick
clockdomain: clkdm per_clkdm: adding clk uart3_fck
clockdomain: clkdm per_clkdm: adding clk per_48m_fck

So it looks like to me that the per_clkdm isn't shutting down because
of per_l4_ick and the gpio interface clocks.

On Mon, Mar 30, 2009 at 4:01 PM, Russ Dill <russ.dill@gmail.com> wrote:
> On Mon, Mar 30, 2009 at 11:43 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Russ Dill <russ.dill@gmail.com> writes:
>>
>>> On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrot=
e:
>> [...]
>>>>
>>>> I had found that two drivers that could prevent clocks_off are
>>>> USB and DSS because of the way they use clk_enable().
>>>>
>>>> Can you try building without theses drivers just for verification?
>>>>
>>>
>>> Building without dss makes things worse:
>>>
>>> Powerdomain (dss_pwrdm) didn't enter target state 0
>>>
>>> Maybe by looking at what the dss driver is doing I can get core and
>>> per to turn off.
>>
>> Russ,
>>
>> Can you try with the latest HEAD of PM branch. =C2=A0After suspend/r=
esume,
>> do
>>
>> # cat /debug/pm_debug/registers/1
>>
>> and post results to list. =C2=A0We can then see the exact state of P=
M
>> registers before going into WFI.
>
> root@beagleboard:/sys# cat /debug/pm_debug/registers/1
> MOD: CM_IVA2 (48014000)
> =C2=A004 =3D> 00000037 =C2=A020 =3D> 00000001 =C2=A034 =3D> 00000001 =
=C2=A040 =3D> 0009680c
> =C2=A044 =3D> 00000001 =C2=A048 =3D> 00000003
> MOD: CM_OCP (48004800)
> =C2=A000 =3D> 00000010 =C2=A010 =3D> 00000001
> MOD: CM_MPU (48004900)
> =C2=A004 =3D> 00000037 =C2=A024 =3D> 00000001 =C2=A034 =3D> 00000001 =
=C2=A040 =3D> 0011f40c
> =C2=A044 =3D> 00000001 =C2=A048 =3D> 00000003 =C2=A04c =3D> 00000001
> MOD: CM_CORE (48004a00)
> =C2=A010 =3D> 00000042 =C2=A020 =3D> ffffffbd =C2=A024 =3D> 0000001f =
=C2=A028 =3D> 0000000d
> =C2=A030 =3D> fffffed9 =C2=A034 =3D> 0000001f =C2=A038 =3D> 0000000c =
=C2=A040 =3D> 0000030a
> =C2=A048 =3D> 0000003f =C2=A04c =3D> 00000003
> MOD: CM_SGX (48004b00)
> =C2=A020 =3D> 00000001 =C2=A048 =3D> 00000003
> MOD: CM_WKUP (48004c00)
> =C2=A010 =3D> 0000000e =C2=A020 =3D> 000002f1 =C2=A030 =3D> 0000003f =
=C2=A040 =3D> 00000015
> MOD: CM_CCR (48004d00)
> =C2=A000 =3D> f8311037 =C2=A004 =3D> 00000017 =C2=A020 =3D> 00000201 =
=C2=A030 =3D> 00000009
> =C2=A034 =3D> 00000001 =C2=A040 =3D> 094c0c00 =C2=A044 =3D> 0001b00c =
=C2=A048 =3D> 00000009
> =C2=A050 =3D> 00000001 =C2=A070 =3D> 00000003
> MOD: CM_DSS (48004e00)
> =C2=A020 =3D> 00000003 =C2=A030 =3D> 00000001 =C2=A040 =3D> 00001006 =
=C2=A048 =3D> 00000003
> MOD: CM_CAM (48004f00)
> =C2=A020 =3D> 00000001 =C2=A030 =3D> 00000001 =C2=A040 =3D> 00000004 =
=C2=A048 =3D> 00000003
> MOD: CM_PER (48005000)
> =C2=A010 =3D> 0003e000 =C2=A020 =3D> 00001fff =C2=A030 =3D> 0003ffff =
=C2=A040 =3D> 000000ff
> =C2=A044 =3D> 00000006 =C2=A048 =3D> 00000003 =C2=A04c =3D> 00000001
> MOD: CM_EMU (48005100)
> =C2=A040 =3D> 03020a50 =C2=A048 =3D> 00000002 =C2=A04c =3D> 00000001
> MOD: CM_NEON (48005300)
> =C2=A048 =3D> 00000003
> MOD: CM_USB (48005400)
> =C2=A020 =3D> 00000003 =C2=A030 =3D> 00000001 =C2=A048 =3D> 00000003
> MOD: PRM_IVA2 (48316000)
> =C2=A050 =3D> 00000007 =C2=A0e0 =3D> 00ff0f04 =C2=A0f8 =3D> 00000007
> MOD: PRM_OCP (48306800)
> =C2=A004 =3D> 00000010 =C2=A014 =3D> 00000001 =C2=A01c =3D> 00000201
> MOD: PRM_MPU (48306900)
> =C2=A058 =3D> 00000005 =C2=A0d4 =3D> 00000012 =C2=A0e0 =3D> 00030104 =
=C2=A0e4 =3D> 000000c7
> =C2=A0e8 =3D> 000000c7
> MOD: PRM_CORE (48306a00)
> =C2=A058 =3D> 00000301 =C2=A0a0 =3D> c33ffe18 =C2=A0a4 =3D> c33ffe18 =
=C2=A0a8 =3D> c33ffe18
> =C2=A0e0 =3D> 000f0304 =C2=A0e4 =3D> 000000f7 =C2=A0e8 =3D> 000000f7 =
=C2=A0f0 =3D> 00000004
> =C2=A0f4 =3D> 00000004 =C2=A0f8 =3D> 00000004
> MOD: PRM_SGX (48306b00)
> =C2=A0e0 =3D> 00030104
> MOD: PRM_WKUP (48306c00)
> =C2=A0a0 =3D> 0000010b =C2=A0a4 =3D> 0000010b
> MOD: PRM_CCR (48306d00)
> =C2=A040 =3D> 00000003
> MOD: PRM_DSS (48306e00)
> =C2=A058 =3D> 00000005 =C2=A0a0 =3D> 00000001 =C2=A0e0 =3D> 00030104
> MOD: PRM_CAM (48306f00)
> =C2=A058 =3D> 00000001 =C2=A0e0 =3D> 00030104
> MOD: PRM_PER (48307000)
> =C2=A058 =3D> 00000001 =C2=A0a0 =3D> 0003efff =C2=A0a4 =3D> 0003efff =
=C2=A0a8 =3D> 0003efff
> =C2=A0c8 =3D> 00000007 =C2=A0e0 =3D> 00030104 =C2=A0e4 =3D> 00000007 =
=C2=A0e8 =3D> 00000007
> MOD: PRM_EMU (48307100)
> =C2=A058 =3D> 00000005 =C2=A0e4 =3D> 00000103
> MOD: PRM_GLBL (48307200)
> =C2=A020 =3D> 00120012 =C2=A024 =3D> 00010000 =C2=A02c =3D> 301e1e30 =
=C2=A030 =3D> 2c1e1e2c
> =C2=A034 =3D> 00120000 =C2=A038 =3D> 00000018 =C2=A054 =3D> 00001006 =
=C2=A058 =3D> 00000001
> =C2=A060 =3D> 0000000e =C2=A064 =3D> 00000050 =C2=A070 =3D> 00000088 =
=C2=A090 =3D> 0fff0fff
> =C2=A094 =3D> 000000ff =C2=A098 =3D> 000000ff =C2=A09c =3D> 00000002 =
=C2=A0a0 =3D> 000000ff
> =C2=A0c4 =3D> 00000001 =C2=A0e4 =3D> 00000001
> MOD: PRM_NEON (48307300)
> =C2=A058 =3D> 00000005 =C2=A0c8 =3D> 00000002 =C2=A0e0 =3D> 00000004 =
=C2=A0e4 =3D> 00000003
> =C2=A0e8 =3D> 00000003
> MOD: PRM_USB (48307400)
> =C2=A058 =3D> 00000001 =C2=A0a0 =3D> 00000001 =C2=A0a4 =3D> 00000001 =
=C2=A0a8 =3D> 00000001
> =C2=A0e0 =3D> 00030104
>
>
>> Also, post dump of
>>
>
> root@beagleboard:/sys# cat /debug/pm_debug/count
> usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> dss_pwrdm (ON),OFF:2,RET:0,INA:0,ON:3
> cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> neon_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
> mpu_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
> iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> per_clkdm->per_pwrdm (9)
> usbhost_clkdm->usbhost_pwrdm (0)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (2)
> core_l4_clkdm->core_pwrdm (8)
> core_l3_clkdm->core_pwrdm (4)
> d2d_clkdm->core_pwrdm (0)
> sgx_clkdm->sgx_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> neon_clkdm->neon_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> virt_opp_clkdm->wkup_pwrdm (0)
> prm_clkdm->wkup_pwrdm (10)
> cm_clkdm->core_pwrdm (3)
>
>
>
>> Thanks,
>>
>> Kevin
>>
>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
