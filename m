From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 16:52:59 +0300
Message-ID: <94a0d4530905180652y5c3d045fs99bb2b5bdb52948e@mail.gmail.com>
References: <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
	 <20090518121113.GB3067@n2100.arm.linux.org.uk>
	 <20090518.163533.28796680.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:41079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZERNw7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:52:59 -0400
Received: by fg-out-1718.google.com with SMTP id d23so624223fga.17
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 06:52:59 -0700 (PDT)
In-Reply-To: <20090518.163533.28796680.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 4:35 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
> Date: Mon, 18 May 2009 14:11:13 +0200
>
>> On Sat, May 16, 2009 at 01:05:50PM +0300, Felipe Contreras wrote:
>> > This allows devices to be registered only when they are used. The
>> > current dsp-bridge driver for example is not using iommu so regist=
ering
>> > the iommu iva2 device would conflict. By allowing remote registrat=
ion
>> > the dsp-bridge can decide when the iommu iva2 device is registered=
=2E
>>
>> I don't think that this is a good idea - what happens if two people
>> call omap_iommu_add() for the same IOMMU device independently?
>>
>> The real problem here seems to be the TI DSP bridge code, and if tha=
t's
>> the case why can't we just avoid registering IVA2 if the TI DSP brid=
ge
>> code is enabled. =C2=A0That solves your stated problem without creat=
ing
>> additional management issues.
>
> How about the attached patch? I think this is enough.

That wouldn't work when bridgedriver moves to iommu, how about:

+#if !defined(CONFIG_MPU_BRIDGE) && !defined(CONFIG_OMAP_DSP_MODULE)
+#if defined(CONFIG_MPU_BRIDGE_IOMMU)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
