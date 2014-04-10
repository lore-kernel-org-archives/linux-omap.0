From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Thu, 10 Apr 2014 14:49:04 +0400
Message-ID: <53467720.8000400@cogentembedded.com>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org> <53458E95.4080505@cogentembedded.com> <534598EF.3010102@wwwdotorg.org> <53459A48.1010003@cogentembedded.com> <063D6719AE5E284EB5DD2968C1650D6D0F6F43C3@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6F43C3@AcuExch.aculab.com>
Sender: linux-sh-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, Stephen Warren <swarren@wwwdotorg.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "balbi@ti.com" <balbi@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 10-04-2014 13:20, David Laight wrote:

>>      It doesn't do any pin muxing. It switches SoC internal USB signals between
>> USB controllers. The pins remain the same.

> Doesn't something like that already happen for the companion USB1
> controllers for USB2 ports?

    Did you mean USB 1.1 and USB 2.0 controllers by USB1 and USB2?

> That also doesn't sound like you are changing the PHY.

    I am changing one of the PHY registers that controls USB port (Renesas 
calls it channel) multiplexing.

> I'd have thought that would happen if you had a single controller
> that select between multiply PHY.

    No, it's not the case.

> 	David

WBR, Sergei

