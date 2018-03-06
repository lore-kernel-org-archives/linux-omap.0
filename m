From: Bin Liu <b-liu@ti.com>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Tue, 6 Mar 2018 08:36:59 -0600
Message-ID: <20180306143659.GG14921@uda0271908>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
 <20180302165439.62xw4slhhupy4vy5@pali>
 <20180305192844.GE14921@uda0271908>
 <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54fc4244-2584-f63d-23be-9e0413bcbee4@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 05, 2018 at 08:44:40PM +0100, Merlijn Wajer wrote:
> Hi Bin,
> 
> On 05/03/18 20:28, Bin Liu wrote:
> 
> > The musb udc driver sets the state to b_idle without checking a
> > gadget driver, this should be cleaned up. I have add this in my backlog.
> > But if this issue doesn't bother you much right now, I will make the
> > action low priority and address it later whenever I got time. (likely
> > not very soon, I have a hand full of musb driver bugs to fix...)
> 
> I can try to fix it this (or next) week. Do you have a pointer for me?

Quickly looking at the code, musb->xceiv->otg->state is set to OTG_STATE_B_IDLE
in musb_init_controller(), musb_gadget_setup(), musb_gadget_start(), and
musb_g_disconnect(). I am not sure if there is redundancy, and gadget
driver should be checked in some of them.

Regards,
-Bin.
