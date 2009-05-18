From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 15:46:07 +0300
Message-ID: <94a0d4530905180546p47c887afj109b3b60cdd24a00@mail.gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
	 <20090518121113.GB3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:24465 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZERMqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:46:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so610118fga.17
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 05:46:08 -0700 (PDT)
In-Reply-To: <20090518121113.GB3067@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 3:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 16, 2009 at 01:05:50PM +0300, Felipe Contreras wrote:
>> This allows devices to be registered only when they are used. The
>> current dsp-bridge driver for example is not using iommu so register=
ing
>> the iommu iva2 device would conflict. By allowing remote registratio=
n
>> the dsp-bridge can decide when the iommu iva2 device is registered.
>
> I don't think that this is a good idea - what happens if two people
> call omap_iommu_add() for the same IOMMU device independently?

Hmm, right, some extra checks would be needed to see if the device is
already registered and then increase some refcount. That's more
complicated that I was hoping for.

> The real problem here seems to be the TI DSP bridge code, and if that=
's
> the case why can't we just avoid registering IVA2 if the TI DSP bridg=
e
> code is enabled. =C2=A0That solves your stated problem without creati=
ng
> additional management issues.

The bridgedriver is expected to move and use iommu eventually, but not
right now, so I guess the iva2 device should be registered only if
MPU_BRIDGE_IOMMU is defined.

But then what's the point of having the isp iommu device if the camera
driver is disabled? Wouldn't that be wasting resources? Then if CAMERA
is not defined the isp device should not be registered either.

And finally if none of the two are enabled then you don't really
iommu. By having omap_iommu_add all the dependencies would be handled
automatically, right? 'modprobe bridgedriver' would load iommu.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
