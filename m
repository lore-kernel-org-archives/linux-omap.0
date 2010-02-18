From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCHv4 4/4] DSPBRIDGE: Improved mapped memory cleanup
Date: Thu, 18 Feb 2010 16:47:28 +0200
Message-ID: <1266504448.2105.12.camel@sanganak>
References: <cover.1266429436.git.ameya.palande@nokia.com>
	 <f57155cbfa5cca493333eff553f6887217273a3b.1266429437.git.ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602CA2B9AD9@dlee06.ent.ti.com>
	 <1266495355.2105.5.camel@sanganak>
	 <20100218142728.GD4097@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38498 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140Ab0BROsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:48:33 -0500
In-Reply-To: <20100218142728.GD4097@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>
Cc: "ext Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Felipe,

On Thu, 2010-02-18 at 15:27 +0100, Contreras Felipe (Nokia-D/Helsinki)
wrote:
> On Thu, Feb 18, 2010 at 01:15:55PM +0100, Ameya Palande wrote:
> > On Thu, 2010-02-18 at 02:52 +0100, ext Guzman Lugo, Fernando wrote:
> > > What do you think about it?
> > > Instead of removing DRV_InsertDMMResElement make it an inline function with your code inside:
> > 
> > Making DRV_InsertDMMResElement inline doesn't make sense since we are
> > not calling it multiple times.
> 
> I agree with Fernando; the code would be more readable. Even more if we
> rename the function to instert_map_element().

I guess the issue is about why this code is doing it rather than the
readability of code. I have sent V5 of the patchset with comment
explaining the purpose of doing this.

If you think that by creating a new static inline function like
insert_map_element(), we can understand it better then following comment
also does the same thing:

/* Following code inserts a map element ... and explain why */ 

Anyways insert_map_element() function doesn't explain why it is
required :(

Cheers,
Ameya.

