From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH 4/8] OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI
	and VENC
Date: Thu, 17 Feb 2011 20:50:50 +0530
Message-ID: <AANLkTikDD9uYyQDuVX5oBM5hhcjpyj79uJgYPmMu8a79@mail.gmail.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
	<1297938289-8678-5-git-send-email-b-cousson@ti.com>
	<AANLkTimPxP2dN-xgKhTwFwo-iPcgJ9gRSYAFF3=TLap1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTimPxP2dN-xgKhTwFwo-iPcgJ9gRSYAFF3=TLap1@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com, Senthilvadivu Guruswamy <svadivu@ti.com>, Mayuresh Janorkar <mayur@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 17, 2011 at 8:32 PM, Semwal, Sumit <sumit.semwal@ti.com> wrote:
> Hi Benoit,
>
> One minor comment;
>
> On Thu, Feb 17, 2011 at 3:54 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Add dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.
>> In OMAP4 there are severals IPs that can be reached by differents
>> interconnect paths depending of the access initiator (MPU vs. SDMA).
>> In the case of the DSS, both L3 direct path and L4 CFG path can be
>> used to access all the DSS IPs. The two ocp_ip already exists to support
>> the two address spaces.
>>
>> =A0 =A0 =A0+------------+-- L3_MAIN --+ MPU
>> =A0IP =A0| =A0 =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0+-- L4_CFG --+
>>
>> L3 main address range is specified first, since it is used by default.
>> dss is also considered as an IP as dispc, rfbi, and named as dss_core.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> [b-cousson@ti.com: Re-organize structures to match file
>> convention and remove irq entry from dss_hwmod]
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1,7 +1,7 @@
>> =A0/*
>> =A0* Hardware modules present on the OMAP44xx chips
>> =A0*
>> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
>> + * Copyright (C) 2009-2011 Texas Instruments, Inc.
>> =A0* Copyright (C) 2009-2010 Nokia Corporation
>> =A0*
>> =A0* Paul Walmsley
>> @@ -43,6 +43,7 @@
>> =A0static struct omap_hwmod omap44xx_dma_system_hwmod;
>> =A0static struct omap_hwmod omap44xx_dmm_hwmod;
>> =A0static struct omap_hwmod omap44xx_dsp_hwmod;
>> +static struct omap_hwmod omap44xx_dss_hwmod;
> I guess we agreed to name this dss_core - any specific reason to change i=
t?
Oh well, blame it on weary eyes - I do see that you've named the
device correctly as 'dss_core', so please ignore this comment!
Best regards,
~Sumit.
>
> Best regards,
> ~Sumit.
> <snip>
>
