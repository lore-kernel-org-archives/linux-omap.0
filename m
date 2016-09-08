From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Thu, 8 Sep 2016 13:19:31 -0700
Message-ID: <20160908201931.kvkqn5cuowovxph3@atomide.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <20160908155830.ov5so3vm2kmmccty@atomide.com>
 <57D1B75E.4020106@gmail.com>
 <57D1B959.5090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57D1B959.5090108@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

* Frank Rowand <frowand.list@gmail.com> [160908 12:18]:
> > On 09/08/16 08:58, Tony Lindgren wrote:
> >> Just to consider other ways of doing it, we could use the compatible
> >> flag to tag devices that need to be just idled on probe, but that does
> >> not seem like generic solution to me.
> > 
> > Yuck.  Again overloading a property to convey multiple pieces of
> > information.
> 
> I should have been more explicit in that statement.
> 
> If the hardware device does not have "wires" routed to a connector or
> bus then it is still the same device.  Thus the compatible should be
> the same.
> 
> The difference is the way the device is used in the SOC or board.

That is correct. The device is exactly the same.

Regards,

Tony
