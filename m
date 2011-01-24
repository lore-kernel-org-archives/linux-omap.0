From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 16:25:54 +0100
Message-ID: <201101241625.55992.laurent.pinchart@ideasonboard.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com> <20110124061847.GH2756@legolas.emea.dhcp.ti.com> <f5a0abe43775faf0ecbb4cf08c842bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:44324 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab1AXPZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:25:53 -0500
In-Reply-To: <f5a0abe43775faf0ecbb4cf08c842bb7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, patches@linaro.org

On Monday 24 January 2011 15:25:21 Vishwanath Sripathy wrote:
> On Monday, January 24, 2011 11:49 AM Felipe Balbi wrote:
> > On Mon, Jan 24, 2011 at 11:31:20AM +0530, Vishwanath Sripathy wrote:
> > > I do not think DVFS layer can be made a generic layer outside OMAP
> > > because of the fact that DVFS is closely coupled with OMAP device layer
> > > (for getting hwmod related data and clock handling), OMAP voltage layer
> > > (for voltage scaling and handling of dependency voltage domains) and
> > > smart reflex layer.
> > 
> > that an implementation detail. If you:
> > 	a. make the DVFS layer so that you need a HW-glue layer which
> > 	will use OMAP-specific APIs; or
> > 	
> > 	b. pass function pointers for the generic DVFS layer to use
> > 
> > (note that I'd rather have option (a)), you solve the problem, no ?
> 
> It is not just implementation. Even the underlying design of DVFS is
> closely coupled with these layers. If we try to split this DVFS framework
> into generic and OMAP specific part, then the flow will become too
> cumbersome since there are will be too many interactions between common
> and OMAP part. Also it will reduce the code readability aspect as well.
> I do not think it's worth adding some much of complexity and effort just
> to avoid a driver using platform specific function pointers to call these
> APIs.

The issue with callbacks to board code is that they prevent the use of the 
device tree which is getting introduced on ARM platforms. We should avoid them 
as much as possible.

-- 
Regards,

Laurent Pinchart
