From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
Date: Tue, 27 Jul 2010 01:22:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007270121350.1906@utopia.booyaka.com>
References: <20100702152703.6221.33529.stgit@localhost.localdomain> <20100702152930.6221.32877.stgit@localhost.localdomain> <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C2A5@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323C3F32F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59806 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0G0HWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 03:22:37 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323C3F32F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Thara,

On Sat, 24 Jul 2010, Gopinath, Thara wrote:

> >>>>+struct device *omap2_get_dsp_device(void)
> >>>>+{
> >>>>+	WARN_ON_ONCE(!dsp_dev);
> >>>>+	return dsp_dev;
> >>>>+}
> >>First of all, apologies for so late posting of the comment. IMHO it would be good to rename this API
> >>as omap2_get_iva_device. This is because OMAP4 has separate IVA and DSP devices and we will need to
> >>build the omap_device for both. If we could rename this as omap2_get_iva_device, we could introduce
> >>another API omap4_get_iva_device until bridge starts doing a omap_device_build for all these devices.
> 
> Hello Paul,
> 
> Any thoughts on this one?

Makes sense to me.  Probably we should queue a patch up to fix that for 
2.6.37...


- Paul
