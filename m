From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: OMAP34xx EHCI bulk OUT CRC16 complementing
Date: Fri, 22 Feb 2008 14:07:53 -0800
Message-ID: <200802221407.54200.david-b@pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC080044F7C2C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC080044F7C2C-tvxpnMfVbg6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 February 2008, Pandita, Vikram wrote:
> USB EHCI/OHCI experts
> 
> On omap-git v2.6.25-rc2, TI OMAP34xx EHCI controller, we are seeing a
> strange behavior on a bulk OUT 512 byte transfer. 
> 
> We can see through the CATC that the 512 byte goes out successfully
> but there are many Turnaround/Timeout Errors and retries before the
> packet goes out successfully.   
> The retries could range from 0 to 10 or more.
> 
> The error packets have 'CRC16 complemented' as per Section 8.6.4
> page 234-235 that says for probably a data under-run condition: 
> "An error for high-speed must be forced by taking the currently
> calculated CRC and complementing it before transmitting it." 
> 
> We have confirmed that our Memory (SDRAM) access have a much higher
> bandwidth available "not" to cause data under-run condition. 
> 
> Where in EHCI stack should I debug for this issue? 

Doesn't sound like an EHCI driver issue.  I'd want to track
what's going on deeper inside the silicon than ARM instruction
set handling ... ;)


> Is there a way to slow-down the OUT transfers on EHCI if that
> helps in debugging?  

You could issue URBs with single packets.  If you're not using
the "usbtest" framework, you should start ... that command line
tool lets you send a variety of packet sequences.  You'll want
some high speed source/sink device, like another board running
the "Gadget Zero" firmware.

- Dave

[1] http://www.linux-usb.org/usbtest/
