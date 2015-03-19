From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Thu, 19 Mar 2015 08:57:20 -0700
Message-ID: <20150319155719.GD31346@atomide.com>
References: <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com>
 <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
 <20150313193058.GN5264@atomide.com>
 <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
 <20150316164951.GR5264@atomide.com>
 <CAALWOA-oynZi-L=iUrvVCAFQ0bXLSwdqpNV5qKakCdUU0M7rHw@mail.gmail.com>
 <20150317021919.GA31346@atomide.com>
 <CAALWOA-XK=TrQ7Wi4DYxho2vjuPoxHwq=3n7FHUfin3ca6SGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA-XK=TrQ7Wi4DYxho2vjuPoxHwq=3n7FHUfin3ca6SGZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Bin Liu <binmlist@gmail.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150319 04:20]:
> On 17 March 2015 at 03:19, Tony Lindgren <tony@atomide.com> wrote:
> > Yes so it seem here too, this is dm816x rev c, what do you have?
> 
> jtag ID reads 0x1b81e02f, so that would be rev 1.1 / rev A.
> 
> > Anyways, I'll add a note that at least rev c does not seems to do
> > anything with USB_CTRL but that we follow what the TI tree is doing
> > in case some other revisions of the hardware use it.
> 
> Another idea would be to check if it's nonzero and if so, yell loudly
> in the kernel log that they should mail the linux-omap list ;-)

Sure I'll add that to the phy start up code :)

Regards,

Tony
