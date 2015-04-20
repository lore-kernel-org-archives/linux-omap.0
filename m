From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Mon, 20 Apr 2015 10:28:12 +0300
Message-ID: <5534AA8C.1070400@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <20150420030531.GA30878@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420030531.GA30878@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, macpaul@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On 20/04/15 06:05, Peter Chen wrote:
> On Tue, Apr 14, 2015 at 01:41:47PM +0300, Roger Quadros wrote:
>> This is an attempt to centralize OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm. xhci side of things for OTG/DRD use are fixed in
>> http://thread.gmane.org/gmane.linux.kernel/1923161
> 
> Hi Roger,
> 
> Currently, there are two main problems for DRD/OTG framework.
> 
> - For multi-platform supports, we may define CONFIG_USB_OTG, but the
> gadget should not add its otg descriptor to its configuration
> descriptors if it does not support one of otg features (SRP/HNP/ADP).
> Macpaul Lin's patch set [1] is the right way to do it.

Agreed. That check (whether OTG descriptor can be added and which version
of it) has to be done at runtime and it must be added only if hardware
supports OTG _and_ kernel OTG support is enabled.

> - We are lack of framework to handle OTG (DRD) switch, it is great you
> are designing it. The main problem for this framework is how to handle
> DRD/OTG FSM unify. My thought is we add two paths for them separate.
> For easy, I suggest if the platform supports one of otg features, then
> it goes to fully otg fsm, else it goes to simply otg fsm (like your drd 
> fsm). If you agree with it too, you may not need to add another "dr_mode"
> value.

It would be nice that way but unfortunately it does't work in all cases.
e.g. What if the SoC itself supports all OTG features but the board is not
designed for OTG. Or the product designer simply is not interested in full OTG
support but just dual-role. So we need some flexibility for the
device tree/platform-data to specify that. This is where a new
"dr_mode" == "dual-role" is needed.

cheers,
-roger
