From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 10:15:23 +0100
Message-ID: <4D6621AB.10205@ahsoftware.de>
References: <4D64C81B.5060807@ahsoftware.de> <Pine.LNX.4.44L0.1102231021210.2233-100000@iolanthe.rowland.org> <20110224085735.GD3528@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110224085735.GD3528@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Michael Jones <michael.jones@matrix-vision.de>, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, stable@kernel.org, stable-review@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

Am 24.02.2011 09:57, schrieb Felipe Balbi:
> Hi,
>
> On Wed, Feb 23, 2011 at 10:26:20AM -0500, Alan Stern wrote:
>> In both cases, it appears that the problem is caused by the fact that
>> the musb host-controller driver doesn't set the hcd->has_tt flag.
>>
>> Felipe, you should know where it belongs.  It should be easy enough to
>> add.
>
> Sure Alan, it's attached to this mail. Compile tested only though.
> Michael, would you care to give your tested-by ?

I can do, I'm using exactly the same patch since yesterday. ;)

Tested-by: Alexander Holler <holler@ahsoftware.de>

Regards,

Alexander
