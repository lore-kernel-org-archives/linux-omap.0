From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH][RFC] OMAP4: McSPI Support for OMAP_4430
Date: Fri, 26 Jun 2009 10:29:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B530F711@dbde02.ent.ti.com>
References: <51412.192.168.10.89.1245911089.squirrel@dbdmail.itg.ti.com>
 <873a9os1nr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45054 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZFZE7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 00:59:54 -0400
In-Reply-To: <873a9os1nr.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, June 25, 2009 10:15 PM
> To: Syed, Rafiuddin
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RESUBMIT][PATCH][RFC] OMAP4: McSPI Support for OMAP_4430
> 
> "Syed Rafiuddin" <rafiuddin.syed@ti.com> writes:
> 
> > This patch adds McSPI support for OMAP4430 SDP platform. 
> All the base addresses
> > are changed between OMAP1/2/3 and OMAP4.The fields of the 
> resource structures
> > are filled at runtime to have McSPI support on OMAP4.
> >
> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> 
> This driver needs some help for multi-omap, but that problem existed
> before this patch, so
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> 
> > ---
> >  arch/arm/mach-omap2/devices.c |   25 +++++++++++++++++++++----
> >  drivers/spi/omap2_mcspi.c     |   10 ++++++----
> >  2 files changed, 27 insertions(+), 8 deletions(-)
Not sure but looks like the patch needs split since different upstream paths
1. arch/arm/mach-omap2/devices.c -- linux-arm
2. drivers/spi/omap2_mcspi.c --- Don't know the list but should be some driver list.

Is that correct ?

Regards,
Santosh
 