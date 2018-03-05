From: Bin Liu <b-liu@ti.com>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Mon, 5 Mar 2018 13:28:44 -0600
Message-ID: <20180305192844.GE14921@uda0271908>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302165439.62xw4slhhupy4vy5@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Merlijn,

On Fri, Mar 02, 2018 at 05:54:39PM +0100, Pali Rohár wrote:
> On Friday 02 March 2018 17:47:52 Merlijn Wajer wrote:
> > >> I would expect it to state "b_idle" instead of "(null)".
> > > 
> > > Actually, I'd like to see (null) whenever a gadget driver is not loaded,
> > > which indicates a gadget is not bound to the udc.
> > 
> > Hm... Sounds fine to me. I'm using this mode in combination with the usb
> > phy (vbus property) to detect if the phone is detect to a 'dumb' charger
> > of a PC, but I can just always have a gadget loaded -- same as before,
> > really.
> 
> For detection if wallcharger or pc usb charger is connected, there is
> isp1704_charger driver. It uses some standard ULPI interface. It reports
> current_max and type (DCP - dedicated, CDP or just usb).

The musb udc driver sets the state to b_idle without checking a
gadget driver, this should be cleaned up. I have add this in my backlog.
But if this issue doesn't bother you much right now, I will make the
action low priority and address it later whenever I got time. (likely
not very soon, I have a hand full of musb driver bugs to fix...)

Regards,
-Bin.
