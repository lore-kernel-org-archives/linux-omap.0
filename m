From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Sat, 16 May 2009 21:32:10 +0300
Message-ID: <94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
	 <20090516163635.GB25657@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:60018 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZEPScL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 14:32:11 -0400
Received: by fg-out-1718.google.com with SMTP id 16so888670fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 11:32:10 -0700 (PDT)
In-Reply-To: <20090516163635.GB25657@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote:
>> This patch series cleanups up a bit the opap3-iommu device registrat=
ion and
>> then allows registration from other parts of the code.
>>
>> Currently the iva2 code (tidspbridge) is not using iommu, therefore =
it can't be
>> used as-is with the current omap iommu. By allowing devies to be reg=
istered
>> externaly (either isp, or iva2) this problem goes away.
>
> Hmm, so does this mean that the iommu patchset is going to grow by th=
ree
> patches? =C2=A0Hope not.

I hope Hiroshi integrates my patches.

> Also, please ensure that you address my other comments, some of which=
 do
> seem applicable to your cleanups as well - eg, the __initdata one.

Right, I can improve my cleanup patch with your comments, but my final
objective was to be able to register iommu devices independently, and
for that __initdata on the 'devices' array didn't work.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
