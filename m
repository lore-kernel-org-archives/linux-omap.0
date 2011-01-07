From: Felipe Balbi <balbi@ti.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Fri, 7 Jan 2011 21:24:43 +0200
Message-ID: <20110107192443.GE2272@legolas.emea.dhcp.ti.com>
References: <4D139517.3010608@ti.com>
 <AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com>
 <4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com>
 <AANLkTimA5UOVn6+xe0ofV1F3_XhAP0daBvOAX2k1u_dU@mail.gmail.com>
 <AANLkTimzQ1PHN986fqPF0yjd1M+390nSUDYJ65pu0z_f@mail.gmail.com>
 <4D271E0E.8050401@ti.com>
 <AANLkTikLQRHyp-TS_idEp5Fr74qC3vDoMqqsAA2v_oV8@mail.gmail.com>
 <c822ad4569a9dc865b5ccf39e12c828b@mail.gmail.com>
 <f853a77e2aebea4130fc486bdbf4aa06@mail.gmail.com>
 <AANLkTiku=1-NftQGkOiG0Sm5Fp1-Szqe+39kzWz+4dAC@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiku=1-NftQGkOiG0Sm5Fp1-Szqe+39kzWz+4dAC@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jan 08, 2011 at 12:24:24AM +0530, Gadiyar, Anand wrote:
> On Fri, Jan 7, 2011 at 8:50 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> > Update: I disabled CONFIG_OMAP_RESET_CLOCKS and the PHY and other
> > connected devices enumerate just fine. Could you try this out on
> > your board as well?
> >
> > I'll look deeper and see if there are some required clocks that are
> > accidentally getting turned off.
> >
> 
> A final update from today: It appears that disabling auxclk3_ck causes
> EHCI to fail. I'm not sure what this clock feeds, and will need to look it
> up. Keeping this clock alive is sufficient to get the hub to enumerate.
> 
> I would've looked it up, but got booted out by a fire alarm drill. I'll
> take a look tomorrow and cook up a fix.

Good finding :-) Thanks a lot :-)

-- 
balbi
