From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Sat, 02 Mar 2013 02:36:48 +0100
Message-ID: <513157B0.7010703@gmail.com>
References: <cover.1351870620.git.afzal@ti.com>,<509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51312430.6060306-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01.03.2013 22:57, Daniel Mack wrote:
> Hi Afzal, everyone,
> 
> On 03.11.2012 08:33, Mohammed, Afzal wrote:
>> * Daniel Mack, November 03, 2012 1:06 AM:
>>
>>> I'm testing these patches with an AM33xx board that has the first musb
>>> port wired to an USB type A plug, but it doesn't yet work for me.
>>
>>> So there is no host interface registered. I'm unsure on how to fix this,
>>> and I didn't get an answer yet to that question when I asked Felipe
>>> about how interface drivers like dsps are supposed to act in order to
>>> get host mode back after the recent musb cleanups.
>>
>>> What type of hardware do you test this with? Does host mode work for you?
>>
>> To add to those details mentioned by Ravi,
>>
>> This was tested on Beagle Bone with USB0 as usb-ethernet.
>>
>> For purely Kernel part, this series is sufficient (along with
>> dependency mentioned in cover letter), considering
>> the fact that dt node is strictly not a part of Kernel.
>>
>> To test this series, node for usbss should be present in dt.
>> Example in dt documentation can be pasted onto dtsi file
>> to get USB0 working.
> 
> I have to pick up this old thread because I'm still having trouble
> understanding how the AM335x musb driver is meant to be used as HCD.
> 
> I used to have it working based on 3.7 with a terrible hack that reverts
> a couple of old commits partly. Now I started over with a fresh setup
> based on Linus' current soon-to-be 3.9-rc tip, actually hoping that the
> issues are solved.
> 
> On my board, the USB is purely used as host interface, with a type B
> plug soldered. In the DT, I'm using the following sniplet in accordance
> to the documentation of the bindings:
> 
> 	usb_otg_hs: usb@47400000 {
> 		compatible = "ti,musb-am33xx";
> 		reg = <0x47400000 0x1000	/* usbss */
> 		       0x47401000 0x800		/* musb instance 0 */
> 		       0x47401800 0x800>;	/* musb instance 1 */
> 		interrupt-parent = <&intc>;
> 		interrupts = <17		/* usbss */
> 			      18		/* musb instance 0 */
> 			      19>;		/* musb instance 1 */
> 		multipoint = <1>;
> 		num-eps = <16>;
> 		ram-bits = <12>;
> 		port0-mode = <3>;
> 		port1-mode = <3>;

Btw, same happens for:

 		port0-mode = <1>;


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
