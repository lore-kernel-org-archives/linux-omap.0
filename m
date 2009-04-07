From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] [OMAPZOOM] [UPDATE] DSPBRIDGE: Memory lock for DMM.
Date: Tue, 7 Apr 2009 16:36:45 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2378200E@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287FB05ED@dlee06.ent.ti.com>
	 <269694c00904071319i1ba7f00cie08d9ecf9ffe2ce2@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23781F34@dlee03.ent.ti.com>
	 <269694c00904071349w141e1b7cjae10e70f8ac994af@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23781F8A@dlee03.ent.ti.com>
 <269694c00904071420n11bcc2f6w4e16a486a6277dfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbZDGVgx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 17:36:53 -0400
In-Reply-To: <269694c00904071420n11bcc2f6w4e16a486a6277dfc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya,

> So ideally user space process should touch all the buffers before
> sending them to
> bridge driver so that page_count is never zero?

-- For output buffers from DSP, this is not needed. 

> Also I didn't understand the meaning of the following message which is
> printed
> by printk when page_count is less than 1.
> 
> "Trying to fix it up, but a reboot is needed\n"
> 
> Where the fixing effort is happening?

-- Good catch. There is no specific reason :). We can remove this. I am not sure but I think this warnings statement was borrowed from one of the Kernel's bad page panic message.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Ameya Palande [mailto:2ameya@gmail.com]
> Sent: Tuesday, April 07, 2009 4:20 PM
> To: Kanigeri, Hari
> Cc: Guzman Lugo, Fernando; Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/4] [OMAPZOOM] [UPDATE] DSPBRIDGE: Memory lock for
> DMM.
> 
> Hi Hari,
> 
> On Tue, Apr 7, 2009 at 11:59 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Ameya,
> >
> >>
> >> get_page() function has following check inside it:
> >> VM_BUG_ON(atomic_read(&page->_count) == 0);
> >>
> >> Why we need to repeat it again?
> >> I guess we can completely remove following check which is in my
> >> opinion completely
> >> redundant:
> >
> > -- This check in get_page is conditional check and this is to catch the
> cases when page >count starts with "0", which I think is still a possible
> condition if the user space buffer >was never touched. So I am not sure if
> we can rely on this.
> 
> Thanks for the explanation :) I missed the point that VM_BUG_ON is a
> conditional check.
> So ideally user space process should touch all the buffers before
> sending them to
> bridge driver so that page_count is never zero?
> 
> Also I didn't understand the meaning of the following message which is
> printed
> by printk when page_count is less than 1.
> 
> "Trying to fix it up, but a reboot is needed\n"
> 
> Where the fixing effort is happening?
> 
> Cheers,
> Ameya.

