From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RE: [Patchv2 0/8] DSPBRIDGE: typedef cleanup
Date: Fri, 12 Feb 2010 23:24:37 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96DBC1@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
 <5ec8ebd51002060122ybc9d51dse224b6e88f53a109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757290Ab0BLRyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 12:54:44 -0500
In-Reply-To: <5ec8ebd51002060122ybc9d51dse224b6e88f53a109@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Saturday, February 06, 2010 3:23 AM
> To: Hebbar, Shivananda
> Cc: linux-omap
> Subject: Re: [Patchv2 0/8] DSPBRIDGE: typedef cleanup
> 
> On Sat, Feb 6, 2010 at 3:21 AM, Hebbar, Shivananda <x0hebbar@ti.com>
> wrote:
> > Resending the patches after updating review comments and also
> > Fixing some compilation breaks.
> 
> Sorry for late question, however, I fully agree with HANDLE -> void *,
> but why u32 is not normal type for those changes? What do I miss?
> 
  The idea was to remove typedef and while doing so thought int is sufficient to represent the DSPRTOS type hence changed it from u32 to int.

 I agree that u32 is a normal type.

--Shivananda
