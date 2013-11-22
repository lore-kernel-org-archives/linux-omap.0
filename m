From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Allow MUSB DSPS to use "force host" mode
Date: Fri, 22 Nov 2013 18:01:37 +0100
Message-ID: <528F8DF1.2060307@linutronix.de>
References: <528F7E8F.5050807@newflow.co.uk> <528F8741.1060406@linutronix.de> <528F8B35.8070408@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <528F8B35.8070408@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, jkosina@suse.cz, anatol.pomozov@gmail.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Bin Liu <binmlist@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 11/22/2013 05:49 PM, Mark Jackson wrote:
>> and the ID pin not on ground or 3.3V?
>> What are the side effects? I remember correctly Bin wanted to avoid
>> settings this if it could be avoided.
> 
> Yes ... we have a host only USB port and an unconnected ID pin.

Is it too late to connect that pin?

> AFAIK it defaults to device mode so I can't see any devices that get
> plugged into the USB port.
> 
> If I tweak the s/w to "force" host mode on, then everything appears to
> work okay.
> 
> I guess it's more of a hardware oversight that we left the pin floating
> but in the real world, I guess someone may want this feature to they
> can change the usb port type ?

This is something I would prefer to avoid if possible. We have the
dr_mode attribute in DT. Based on that one we act as a device or host.
Now if you decide (via dr_mode) either for host or device that means we
have to set that bit. Where I feel a little uncomfortable is when
someone having OTG runs in hostmode and attaches a host.

> 
> Either way, I need to fix the current h/w (which can be done via s/w)
> hence the patch.
I've seen many projects where this pin has been forgotten and it could
not be changed in SW and they patched the HW. Usually this is noticed
in the early phase and a wire is just soldered and the redesign has it
fixed. So I don't think that this is a big issue.
Do you insists on having this change merged upstream?

> 
> Mark J.
> 

Sebastian
