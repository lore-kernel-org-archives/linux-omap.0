From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Tue, 10 Apr 2012 10:47:00 -0700
Message-ID: <20120410174700.GA6358@core.coreip.homeip.net>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410162353.GA6217@core.coreip.homeip.net>
 <ADE657CA350FB648AAC2C43247A983F00206986C017F@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206986C017F@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 10, 2012 at 11:39:43AM -0500, H Hartley Sweeten wrote:
> On Tuesday, April 10, 2012 9:24 AM, Dmitry Torokhov wrote:
> > On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
> >> From: G, Manjunath Kondaiah <manjugk@ti.com>
> >> 
> >> Keypad controller register offsets are different for omap4
> >> and omap5. Handle these offsets through static mapping and
> >> assign these mappings during run time.
> >> 
> >
> > In addition to Felipe's comments.
> >
> >> @@ -76,11 +81,66 @@ struct omap4_keypad {
> >>  
> >>  	unsigned int rows;
> >>  	unsigned int cols;
> >> +	unsigned int revision;
> >> +	u32 irqstatus;
> >> +	u32 irqenable;
> >
> >	u32 reg_offset;
> >
> > and you probably won't need revision field.
> >
> >>  	unsigned int row_shift;
> >>  	unsigned char key_state[8];
> >>  	unsigned short keymap[];
> >>  };
> >>  
> >> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> >> +{
> >> +	if (keypad_data->revision == KBD_REVISION_OMAP4)
> >> +		return __raw_readl(keypad_data->base + offset);
> 
> keypad_data->base is an ioremap'ed address. Shouldn't all the __raw_{read,write}l be
> {read,write}l instead?

Hmm, does it need endian conversion?

-- 
Dmitry
