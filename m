From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Wed, 09 Apr 2014 23:06:48 +0400
Message-ID: <53459A48.1010003@cogentembedded.com>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org> <53458E95.4080505@cogentembedded.com> <534598EF.3010102@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <534598EF.3010102-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/09/2014 11:01 PM, Stephen Warren wrote:

>>>>> Ok, the existing field is being replaced by something? I didn't get
>>>>> that

>>>>       No, not replaced. I'm adding the support for generic PHY to the
>>>> existing
>>>> USB PHY support. I thought that was clear from the changelog.

>>>>> from the patch description; I thought the new name in this patch was
>>>>> going to be it. In that case, a temporary name of usb_phy for the
>>>>> existing field, or adding the new field as gen_phy sound reasonable.

>>>>       OK, I'll respin the patch #2 with 'gen_phy' and remove the patch
>>>> #1.

>>> What is the reason for all of this?  That is, can you explain the
>>> difference between USB PHY support and general PHY support, and why we
>>> need both?

>>     The generic PHY framework (drivers/phy/phy-core.c) supports
>> multifunction "complex" PHYs (some functions of which may be related to
>> USB). My case is a Renesas R-Car generation 2 PHY that can switch two
>> USB ports between different USB controllers (one PCI and one non-PCI on
>> each port); I just haven't CCed linux-usb on my driver submission.
>> Though there's already drivers/phy/usb/ driver for that hardware, it
>> failed to meet the expectations (dynamic setting of the port
>> multiplexing depending on what USB host/gadget drivers are loaded), so I
>> had to write a new driver. I guess I don't need to describe
>> drivers/phy/usb/ framework in detail, do I? It only provides for
>> single-function "simple" USB PHYs...

> Naively, it sounds like the complex PHY driver should also be a pinctrl
> driver, since it sounds like the main feature it has beyond a simple PHY
> is the ability to do pin muxing.

    It doesn't do any pin muxing. It switches SoC internal USB signals between 
USB controllers. The pins remain the same.

WBR, Sergei
