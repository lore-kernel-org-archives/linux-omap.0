From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] jacinto6 : usb3_phy: Updated dpll M,N values.
Date: Tue, 9 Jul 2013 14:43:56 +0300
Message-ID: <51DBF77C.4000603@ti.com>
References: <1371829570-15011-1-git-send-email-ruchika@ti.com> <20130708072848.GB16635@arwen.pp.htv.fi> <51DACDA2.1060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51DACDA2.1060806-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 07/08/2013 05:33 PM, Ruchika Kharwar wrote:
> 
> On 07/08/2013 02:28 AM, Felipe Balbi wrote:
>> On Fri, Jun 21, 2013 at 10:46:10AM -0500, Ruchika Kharwar wrote:
>>> Addition of the M and N recommended values for the USB3 PHY DPLL.
>>> Sysclk for DRA7xx is 20MHz.
>>> This yields:
>>> Clk = 20MHz * M/(N+1) = 20MHz * 1000 /(7+1) = 2.5 Ghz
>>>
>>> Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
>> this won't apply since you had already sent me another version. Please
>> send in a fix up patch if that's wrong.
>>
> I already did .. :-)
> Sent 07/04/2013

FYI, I've just sent a better version to fix the root of the problem,
i.e. use lookup table instead of index based lookup.

That should avoid such problems in the future.

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
