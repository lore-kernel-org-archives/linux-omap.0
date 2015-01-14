From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Wed, 14 Jan 2015 07:39:49 -0800
Message-ID: <20150114153949.GA26174@kroah.com>
References: <20141227174628.GB17608@saruman>
 <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
 <20141229171232.GI29379@saruman>
 <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
 <20141230160215.GB415@saruman>
 <54AB7D3F.3030809@st.com>
 <20150112183459.GK6525@saruman>
 <54B4A394.5060005@st.com>
 <20150113162808.GF16533@saruman>
 <54B63263.4090201@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43340 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbbANPjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 10:39:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8C10820E6C
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2015 10:39:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <54B63263.4090201@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amit.virdi@st.com>
Cc: "balbi@ti.com" <balbi@ti.com>, Amit Virdi <amitvi128@gmail.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pratyush Anand Thakur <pratyush.anand@gmail.com>, Ajay KHANDELWAL <ajay.khandelwal@st.com>

On Wed, Jan 14, 2015 at 02:39:55PM +0530, Amit Virdi wrote:
> >Alright, I just applied your patches to testing/fixes. I'll start
> >testing today and should be able to send a pull request to Greg by the
> >end of the week, hopefully.
> >
> 
> Thanks! Just a small clarification - git failed to send patches to stable
> kernel list again (unfortunately I used the older configuration; so older
> git version - my bad).
> 
> Does these patches land up in the stable trees through maintainers or I
> should explicitly cc stable@vger.kernel.org now?

Please read Documentation/stable_kernel_rules.txt for how to get patches
accepted into the stable trees.

thanks,

greg k-h
