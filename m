From: "Molnar, Lajos" <molnar@ti.com>
Subject: RE: [RFC 3/8] TILER-DMM: Sample TCM implementation: Simple TILER
 Allocator
Date: Sun, 25 Jul 2010 10:45:43 -0500
Message-ID: <4663E2C70F2D71419DB08D4A5AC5A0645B43911E@dlee03.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
 <1279927348-21750-4-git-send-email-davidsin@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6255354@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab0GYPqK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jul 2010 11:46:10 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255354@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, linux-omap@vge
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Ramachandra, Ravikiran" <r.ramachandra@ti.com>



> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Saturday, July 24, 2010 2:13 AM
> > +	kfree(tcm);
> > +	kfree(pvt);
> If only one of the allocation was successful, then you
> are freeing a NULL pointer.
> May be have something like this
> 
> 	tcm = kzalloc(sizeof(*tcm), GFP_KERNEL);
> 	if (!tcm)
> 		goto error1;
> 	pvt = kzalloc(sizeof(*pvt), GFP_KERNEL);
> 	if (!pvt)
> 		goto error2;
> 	.
> 	.
> 	.
> error1:
> 	kfree(tcm);
> error2:
> 	kfree(pvt);

Freeing a NULL pointer is always valid, and simply returns.  This is a C specification.

