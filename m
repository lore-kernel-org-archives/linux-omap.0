From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/2]  OMAP4: Patch series
Date: Sun, 17 May 2009 01:57:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A5@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
 <54599.192.168.10.89.1242109175.squirrel@dbdmail.itg.ti.com>
 <20090516101647.GN15328@n2100.arm.linux.org.uk>
 <20090516102909.GP15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36786 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbZEPU1t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 16:27:49 -0400
In-Reply-To: <20090516102909.GP15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Russell King - ARM Linux
> Sent: Saturday, May 16, 2009 3:59 PM
> To: Syed, Rafiuddin
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/2] OMAP4: Patch series
> 
> On Sat, May 16, 2009 at 11:16:47AM +0100, Russell King - ARM 
> Linux wrote:
> > Santosh - I don't seem to have your SMP patch set, just 
> your introductory
> > message for them.
> 
> Actually, I do have these patches, they just aren't threaded with your
> introductory message.

I did send the introductory messege for SMP patch series. May be you missed that. Here is it for your info.
********************************************************************************************************
From: linux-omap-owner@vger.kernel.org on behalf of Shilimkar, Santosh
Sent: Thursday, May 07, 2009 12:48 PM
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org
Subject: [PATCH 0/3] OMAP4: SMP: Patch series

This patch series enables SMP support for OMAP4430 development platform. This series depends on the earlier patch series sent on the mailing list. [1]

The patches are generated against mainline version 2.6.30 -rc2. The kernel is validated on the OMAP4430 software simulator platform. SMP kernel is functional with debug UART. No additional drivers are supported yet.

The series contains:

[PATCH 1/3]OMAP4: SMP: Add OMAP4430 SMP board files
[PATCH 2/3]OMAP4: SMP: Add mpu timer support for OMAP4430
[PATCH 3/3]OMAP4: SMP: Enable SMP support for OMAP4430

Regards,
Santosh

[1]:	[PATCH 0/7] OMAP4: Basic board support patch series
	http://lists.arm.linux.org.uk/lurker/message/20090428.094757.6642f1e3.en.html
********************************************************************************************************

Regards,
Santosh

