From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] MUSB: Set INDEX register to 0 before accessing CONFIGDATA
Date: Thu, 11 Sep 2008 11:35:30 +0800
Message-ID: <386072610809102035s2b30cd70v424fc57def9fa8b2@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1@dbde02.ent.ti.com>
	 <200809062204.01492.david-b@pacbell.net>
	 <386072610809072012wcf053a6j37c238b82667c23a@mail.gmail.com>
	 <20080910190114.GA6671@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080910190114.GA6671@frodo>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 3:01 AM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:
> On Mon, Sep 08, 2008 at 11:12:24AM +0800, Bryan Wu wrote:
>> On Sun, Sep 7, 2008 at 1:04 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>> > On Thursday 04 September 2008, Gadiyar, Anand wrote:
>> >> From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>> >>
>> >> The Index register needs to be zero to access CONFIGDATA.
>> >> musb_ep_select()will not set the MUSB_INDEX register unless INDEXED
>> >> mode addressing is used. This change will set the register correctly
>> >> in INDEXED as well as FLAT mode.
>> >>
>> >> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>> >> CC: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> >
>> > ACK.  I *know* it was originally written that way.  I think
>> > the change was one of the Blackfin patches ... I hope this
>> > isn't one of those cases where the Blackfin version of this
>> > core acts differently.  (Like clearing that DMA IRQ status...)
>> >
>>
>> For Blackfin, the register MUSB_CONFIGDATA is not exported out to software.
>> So in the musb driver, Blackfin code can not access the MUSB_CONFIGDATA.
>> The configuration is fixed in the software.
>
> What happens if you try to read/write to the register ? Does it screw up
> things somehow or just ignores ??
>

Since there is no such register MUSB_CONFIGDATA in Blackfin memory
space, we can not access to such address.
If we don't define this register, compiling will fail in Blackfin

> If it just ignores (and same for the other unexistent registers) we can
> drop that patch adding ifdefs to te register accesses otherwise we're
> gonna have to think about another solution to abstract that.
>

Currently, I just added ifdefs to those registers which does not exist
in Blackfin.
I also want to find an elegant way to solve this difference instead of
using ugly ifdefs here.

-Bryan


> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
