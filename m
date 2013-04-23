From: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 01/11] usb: phy: Add APIs for runtime power management
Date: Tue, 23 Apr 2013 23:35:25 +0530
Message-ID: <CAFp+6iECumogLo9Tf+4pMqRhtkGHf1CqA52YjL1tACTRyGO7jw@mail.gmail.com>
References: <CAFp+6iHWMqNQjKV_EQH-Zm6qKbuFwvPJZeswzNFVSSdH-VDB3Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1304231243040.1679-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1304231243040.1679-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, p.paneri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,


On Tue, Apr 23, 2013 at 10:23 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Tue, 23 Apr 2013, Vivek Gautam wrote:
>
>> >> Alright, so here's my understanding:
>> >>
>> >> I suggested letting e.g. DWC3 enable the PHY's runtime_pm; Alan said
>> >> that it could be done before that so that DWC3 sees an enabled PHY
>> >> during probe.
>> >
>> > Basically right.  Help me to understand the overall situation a little
>> > better:
>> >
>> >         What code registers the PHY initially?
>>            PHY is added to global list by PHY drivers (like
>> phy-samsung-usb2.c/phy-omap-usb2.c)
>>            by usb_add_phy() API
>
> Then this routine should initialize the PHY.  The initialized state
> could be either active or suspended, your choice.  Suspended would be
> best, in case the PHY never gets used.

Fair enough.

>
>> >         What routine does the DWC3 driver call to register itself
>> >         as a consumer of the PHY?
>>            I think DWC3 doesn't registers itself as consumer of PHY,
>> rather it gets that PHY from
>>            the list using devm_usb_get_phy()/devm_usb_get_phy_by_phandle() API.
>>            DWC3 can now call PHY's initialization sequence using usb_phy_init().
>>            So, before DWC3 initializes the PHY, PHYs should be in active state.
>
> Then usb_phy_init should make sure the PHY is in the active state.  If
> usb_add_phy() left the PHY suspended, then this routine should call
> pm_runtime_get_sync().

Right

>
> After DWC3 (or any other driver) has acquired the PHY, it can call
> pm_runtime_put/get() however it likes, so long as the calls balance
> properly.  If the driver isn't runtime-PM aware then it won't use any
> of these calls, and the PHY will remain active the entire time.

Alright, so DWC3 (or any other consumer of PHY) should do minimal to
handle runtime state of PHYs; get() when accessing PHY and put() when it's done
with it.

>
>> >         Likewise, what routine does it call to unregister itself?
>>            Once DWC3's remove() is called PHYs are put.
>
> Is there a routine analogous to usb_phy_init() that gets called when
> PHY is released?  That routine would do the opposite of usb_phy_init(),
> putting the PHY back into its initialized state.

Yes, ofcourse there's a routine usb_phy_shutdown(). So this will be
calling put_sync()
to put PHYs back to its initialized state. Right ?



-- 
Best Regards
Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
