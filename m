From: Brad Parker <brad@heeltoe.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Thu, 06 Jan 2011 10:43:15 -0500
Message-ID: <4D25E313.4060202@heeltoe.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au><4D139517.3010608@ti.com> <AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com> <4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com> (sfid-20110106_100805_509520_6CE1697E)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com> (sfid-20110106_100805_509520_6CE1697E)
Sender: linux-next-owner@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It's probably expected, but I can't get the EHCI USB port  to work
on a beagle board XM (36xx) using the current omap tree.

It this most likely due to these clock issues?

the (very old) angstrom 2.6.32 kernel works fine, as a comparison.

-brad
