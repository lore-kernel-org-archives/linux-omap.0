From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
Date: Tue, 26 Oct 2010 13:08:15 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F49E28BD@dlee06.ent.ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
 <1288054306-4361-2-git-send-email-x0095840@ti.com>
 <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602F49E280A@dlee06.ent.ti.com>
 <1288112616-notmuch-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288112616-notmuch-felipe.contreras@nokia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@nokia.com] 
> Sent: Tuesday, October 26, 2010 12:08 PM
> To: Guzman Lugo, Fernando; felipe.contreras@gmail.com
> Cc: gregkh@suse.de; hiroshi.doyu@nokia.com; 
> linux-kernel@vger.kernel.org; andy.shevchenko@gmail.com; 
> linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/8] staging: tidspbridge - remove 
> req_addr from proc_map
> 
> fernando.lugo@ti.com wrote:
> > > On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> > > <x0095840@ti.com> wrote:
> > > > The device address is assigned by tidspbridge no need for
> > > that parameter anymore.
> > > >
> > > > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> > > 
> > > This would break the API with user-space, right?
> > 
> > Yes, user-space needs to be changed accordingly.
> 
> Wouldn't it make sense to avoid stuffing so many changes at 
> once including ABI breakage?
> 
> Does user-space really _needs_ to be changed? Can't you just 
> ignore that argument?

Actually, I had a previous version of that patch where I only
Ignored that paramteter. But after thinking again and seeing
How the long time ago depreacted function are still there I 
Removed the parameter in order to force apps to make the change.

You can ignore that argument at API level, so all users of the
API not need to have change (in that momment). That should be
Only few line change.

> 
> > > I think this change should be delayed, preferably after we have a 
> > > working tidspbridge.
> > 
> > The issue you were seeing must be fixed with patch 2/8, and 
> Having all 
> > the dependencies tidspbridge has to be working Properly.
> 
> Yes, which might not happen at .37. If we revert the iommu 
> stuff, we might have a chance at having a working bridge on .37.

But havi that merged in tidspbridge make more pressure to merged
The dependencies, if not maybe that wont have event for .38. But
That is just my opinion if you all are agree revert is the best
Option I am ok, but I looks like more work reverting and rebaseing
specially because it is a big change.

Thanks and regards,
Fernando.

> 
> --
> Felipe Contreras
> 