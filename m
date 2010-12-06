From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Mon, 6 Dec 2010 14:18:12 +0200
Message-ID: <20101206121812.GC3693@legolas.emea.dhcp.ti.com>
References: <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
 <1291231942.15533.32.camel@eowin>
 <19F8576C6E063C45BE387C64729E739404BCE398D7@dbde02.ent.ti.com>
 <20101202082904.GH5429@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39A7E@dbde02.ent.ti.com>
 <20101203124317.GB2633@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39E0D@dbde02.ent.ti.com>
 <20101206112003.GA17432@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE3A1B4@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCE3A1B4-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 06, 2010 at 05:24:53PM +0530, Gupta, Ajay Kumar wrote:
>> On Fri, Dec 03, 2010 at 07:08:53PM +0530, Gupta, Ajay Kumar wrote:
>> >> >We already have generic APIs so I think we can pass function pointers
>> to
>> >> >musb driver via "struct omap_musb_board_data",
>> >> >
>> >> > struct omap_musb_board_data {
>> >> >+	void	(*phy_on) (void)
>> >> >+	void 	(*phy_off) (void)
>> >> >+	void  (*intr_clr) (void)
>> >> > }
>> >> >
>> >> >Reset part can be done in board file itself same as Ethernet driver is
>> >> doing.
>> >> >
>> >> >Does this look fine?
>> >>
>> >> so those would be "turn phy on", "turn phy off" and "clear interrupt"
>> >> apis ?
>> >>
>> >> How about:
>> >> int (*set_phy_power)(unsigned on);
>> >Looks good.
>> >
>> >> void (*clear_phy_irq)(void);
>> >This is actually musb ip interrupt clear so I will make it like,
>> >
>> >void (*clear_irq) (void);
>>
>> Is AM35x that different ? Can't you just write to MUSB_INTRRX
>> MUSB_INTRTX and MUSB_INTRUSB ??
>Writing to MUSB_INTRRX/TX/USB wouldn't help. We have to clear interrupt
>Bit in control register INTR_LVL_CLR.

I see, thanks for the info :-)

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
