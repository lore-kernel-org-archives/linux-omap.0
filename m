From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 13 Jun 2012 06:44:08 -0700
Message-ID: <20120613134408.GY12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com>
 <20120613120717.GP12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E43@DBDE01.ent.ti.com>
 <20120613134032.GW12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27170 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab2FMNoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 09:44:14 -0400
Content-Disposition: inline
In-Reply-To: <20120613134032.GW12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [120613 06:45]:
> * Mohammed, Afzal <afzal@ti.com> [120613 06:16]:
> > Hi Tony,
> > 
> > On Wed, Jun 13, 2012 at 17:37:17, Tony Lindgren wrote:
> > > * Jon Hunter <jon-hunter@ti.com> [120612 11:01]:
> > > > 
> > > > On 06/12/2012 02:16 AM, Mohammed, Afzal wrote:
> > 
> > > > > Does having minor revision add any value ?, at least as of now,
> > > > > I do not see any.
> > > > 
> > > > May be not but it does not hurt either.
> > > 
> > > Yeah might as well show the full revision.
> > 
> > We are already showing full version, but only storing major, it seems you
> > want to store minor version along with major version in the same variable,
> > right ?
> 
> Ah OK, yeah might as well just store the minor version.

Actually why do you even need to store the revision? You can
just read it from the hardware as needed.

Tony
