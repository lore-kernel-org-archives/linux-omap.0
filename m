From: "Kwok, WingMan" <w-kwok2@ti.com>
Subject: RE: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Fri, 13 Dec 2013 21:26:51 +0000
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C89F@DFLE11.ent.ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com> <52AA54E4.5000606@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
 <20131213195431.GF5292@saruman.home>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C84D@DFLE11.ent.ti.com>
 <20131213202240.GK5292@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131213202240.GK5292@saruman.home>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Balbi, Felipe
> Sent: Friday, December 13, 2013 3:23 PM
> To: Kwok, WingMan
> Cc: Balbi, Felipe; Shilimkar, Santosh; Linux USB Mailing List;
> kgene.kim@samsung.com; Linux ARM Kernel Mailing List; linux-samsung-
> soc@vger.kernel.org; Linux OMAP Mailing List
> Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
> 
> On Fri, Dec 13, 2013 at 02:18:42PM -0600, Kwok, WingMan wrote:
> >
> > > -----Original Message-----
> > > From: Balbi, Felipe
> > > Sent: Friday, December 13, 2013 2:55 PM
> > > To: Kwok, WingMan
> > > Cc: Shilimkar, Santosh; Balbi, Felipe; Linux USB Mailing List;
> > > kgene.kim@samsung.com; Linux ARM Kernel Mailing List; linux-
> samsung-
> > > soc@vger.kernel.org; Linux OMAP Mailing List
> > > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM
> > > support
> > >
> > > On Fri, Dec 13, 2013 at 10:04:38AM -0600, Kwok, WingMan wrote:
> > > > Hello
> > > >
> > > > > -----Original Message-----
> > > > > From: Shilimkar, Santosh
> > > > > Sent: Thursday, December 12, 2013 7:29 PM
> > > > > To: Balbi, Felipe
> > > > > Cc: Linux USB Mailing List; kgene.kim@samsung.com; Linux ARM
> > > > > Kernel Mailing List; linux-samsung-soc@vger.kernel.org; Linux
> > > > > OMAP Mailing List; Kwok, WingMan
> > > > > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM
> > > > > support
> > > > >
> > > > > On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > > > > > A bare-minimum PM implementation which will server as building
> > > > > > block for more complex
> > > > > s/server/serve ;-)
> > > > > > PM implementation in the future.
> > > > > >
> > > > > > At the least will not leave clocks on unnecessarily when e.g.
> > > > > > a user write mem to /sys/power/state.
> > > > > >
> > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > > ---
> > > > > >
> > > > > > improve error path a little bit.
> > > > > >
> > > > > We will test this out. Thanks for the patch Felipe.
> > > > >
> > > >
> > > > I have tested the patch and the keystone usb driver continues to
> > > > function, though I can't test suspend at this time as the rest of
> > > > the system does not that functionality yet.
> > >
> > > Thanks, should I add your Tested-by ?
> >
> > Yes please.
> 
> you need to reply with Tested-by: Your Name <your.email@domain.com>
> just to make it all official. Sorry
> 

Yes, you can add
Tested-by: WingMan Kwok <w-kwok2@ti.com>
