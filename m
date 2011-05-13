From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
 preprocessor.
Date: Fri, 13 May 2011 20:18:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF132DC@dbde02.ent.ti.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
	<20110513113013.GP31483@atomide.com>
	<BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
	<4DCD2260.4090806@ti.com> <20110513130441.GH5323@atomide.com>
 <87aaeq3fmt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45413 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab1EMOsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 10:48:19 -0400
In-Reply-To: <87aaeq3fmt.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hilman, Kevin
> Sent: Friday, May 13, 2011 6:46 PM
> To: Tony Lindgren
> Cc: Cousson, Benoit; Vladimir Zapolskiy; Paul Walmsley; 
> linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data 
> utilizing preprocessor.
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Cousson, Benoit <b-cousson@ti.com> [110513 15:18]:
> >> >>>Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
> >> >>
> >> >Unfortunately I don't have an automated tool, but that 
> would be great
> >> >to have such a script. For this time I've checked the 
> correctness of the
> >> >change comparing the preprocessed output.
> >> 
> >> In fact these files are already generated automatically, as written
> >> in the header file. So changing the output format should
> >> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
> >> manually some time ago.
> >
> > Sounds like the important thing to consider here is how these macros
> > should be set up considering the upcoming generic clock framework
> > and device tree changes.
> >
> > So let's wait a few days for comments from Benoit and Paul on the
> > format for the macros so we don't need to redo them again later.
> > Of course there might be other things to consider too..
> 
> ... like readability.
> 
> After seeing the patch (thanks Benoit), I think this is bad tradeoff
> between readability and lines-of-code.
> 
> Personally, I don't think we should be trading readability 
> for diffstat
> goodness.  I have a strong dislike for these multi-line macros, but
> it's up to Paul/Benoit to decide how this should look.

[sp] Was the patch posted again?

> 
> Kevin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 