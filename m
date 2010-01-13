From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
 definitions
Date: Wed, 13 Jan 2010 08:54:11 -0600
Message-ID: <A24693684029E5489D1D202277BE8944514ACC25@dlee02.ent.ti.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<A24693684029E5489D1D202277BE8944513DBE43@dlee02.ent.ti.com>
	<20100113.085252.226801492.Hiroshi.DOYU@nokia.com>
 <20100113.141828.59662176.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36952 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab0AMOvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 09:51:35 -0500
In-Reply-To: <20100113.141828.59662176.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nagalla, Hari" <hnagalla@ti.com>

Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, January 13, 2010 6:18 AM
> To: linux-omap@vger.kernel.org
> Cc: Nagalla, Hari; Aguirre, Sergio
> Subject: Re: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
> definitions
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: Re: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
> definitions
> Date: Wed, 13 Jan 2010 08:52:52 +0200 (EET)
> 
> > Hi Sergio,
> >
> > From: "ext Aguirre, Sergio" <saaguirre@ti.com>
> > Subject: RE: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
> definitions
> > Date: Mon, 11 Jan 2010 22:53:16 +0100
> >
> >> Hi Hiroshi,
> >>
> >> > -----Original Message-----
> >> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> > owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> >> > Sent: Monday, January 11, 2010 1:47 AM
> >> > To: linux-omap@vger.kernel.org
> >> > Cc: Nagalla, Hari; Hiroshi DOYU
> >> > Subject: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
> >> > definitions
> >> >
> >> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >>
> >> Maybe a small description would help here...
> >>
> >> Are you just reshuffling defines, or are you also adding new ones?
> >>
> >> Is this just a cleanup or is it fixing a hidden bug?
> >
> > It's just a cleanup, but added a few macros here, This patch is
> > necessary for the proceeding patches which are the ones to fix a bug.
> >
> > I'll add some description on them.
> 
> Here's the updates.

Great! Now looks better ;)

Thanks for that.

Regards,
Sergio
