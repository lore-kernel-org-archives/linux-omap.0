From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead
  of MT_DEVICE
Date: Fri, 27 Aug 2010 10:16:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCA86A68@dbde02.ent.ti.com>
References: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
 <87hbih2gyv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53427 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab0H0ErG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 00:47:06 -0400
In-Reply-To: <87hbih2gyv.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 27, 2010 3:07 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> davinci-linux-open-source@linux.davincidsp.com
> Subject: Re: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED
> instead of MT_DEVICE
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > On Sun, Aug 8, 2010 at 3:18 AM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> >> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> >> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
> >>
> >> Since the section mapping limitation gets fixed with first
> >> patch in this series, the MT_MEMORY_NONCACHED can be used now.
> >>
> >> Have not tested this, so somebody with Davinci hardware can
> >> try this out
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: davinci-linux-open-source@linux.davincidsp.com
> >> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> >
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Also, FYI... while not a very thorough test, I boot-tested this series
> on DaVinci (dm355, omapl138) and it worked fine.
> 
> I'll include in davinci git (in the davinci-testing branch) so it gets a
> bit more testing.

Thanks a lot Kevin!!

Tony, 
Can you merge this in lo master as well. Actually I want all these
3 patches go together so that it doesn't break OMAP/DAVINCI.

Regards,
Santosh
