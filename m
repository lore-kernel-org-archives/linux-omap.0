From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
Date: Tue, 26 Oct 2010 10:52:27 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F49E280A@dlee06.ent.ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
 <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab0JZPwk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 11:52:40 -0400
In-Reply-To: <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
> Sent: Tuesday, October 26, 2010 6:46 AM
> To: Guzman Lugo, Fernando
> Cc: gregkh@suse.de; felipe.contreras@nokia.com; 
> Hiroshi.DOYU@nokia.com; linux-kernel@vger.kernel.org; 
> andy.shevchenko@gmail.com; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/8] staging: tidspbridge - remove 
> req_addr from proc_map
> 
> On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> <x0095840@ti.com> wrote:
> > The device address is assigned by tidspbridge no need for 
> that parameter anymore.
> >
> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> 
> This would break the API with user-space, right?

Yes, user-space needs to be changed accordingly.

> 
> I think this change should be delayed, preferably after we 
> have a working tidspbridge.

The issue you were seeing must be fixed with patch 2/8, and
Having all the dependencies tidspbridge has to be working
Properly.

Regards,
Fernando.

> 
> --
> Felipe Contreras
> 