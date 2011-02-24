From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
 fault handling
Date: Thu, 24 Feb 2011 12:31:37 -0800
Message-ID: <20110224203137.GH20560@atomide.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
 <1297884951-3019-3-git-send-email-dacohen@gmail.com>
 <AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
 <AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
 <AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
 <4D656961.7080105@maxwell.research.nokia.com>
 <20110224083518.GC3528@legolas.emea.dhcp.ti.com>
 <AANLkTinh_a81sELdF19ob0A0KbLR+9MUnb0+283NxO2b@mail.gmail.com>
 <20110224112912.GQ3528@legolas.emea.dhcp.ti.com>
 <AANLkTikXBKcbOQXdse31=qjoLoAhkvKz15PeFuw3AmCj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39088 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab1BXUbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 15:31:43 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikXBKcbOQXdse31=qjoLoAhkvKz15PeFuw3AmCj@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: balbi@ti.com, David Cohen <dacohen@gmail.com>, hiroshi.doyu@nokia.com, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Guzman Lugo, Fernando <fernando.lugo@ti.com> [110224 09:56]:
> On Thu, Feb 24, 2011 at 5:29 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Thu, Feb 24, 2011 at 01:26:05PM +0200, David Cohen wrote:
> >> On Thu, Feb 24, 2011 at 10:35 AM, Felipe Balbi <balbi@ti.com> wrote:
> >>
> >> This patch is already acked. What about leave it as it is and discuss
> >> multiple callbacks before release a new patch to support it?
> >
> > fine by me ;-)
> 
> Ok, maybe it was too late to change it, due to it is already acked, I
> just wanted to avoid change isr here and then change it on other
> patch. it is ok then.

Hiroshi any comments?

Would like to see a proper Acked-by before I apply, now there's
just the earlier comment "Ok, I see. Let's go with this. Thanks." :)

Tony
