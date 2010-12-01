From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Wed, 1 Dec 2010 10:41:00 +0200
Message-ID: <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
 <20101130183010.GS17222@atomide.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101130183010.GS17222-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 10:30:10AM -0800, Tony Lindgren wrote:
>* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [101122 02:12]:
>> Hi,
>>
>> On Mon, Nov 22, 2010 at 02:22:40PM +0530, Ajay Kumar Gupta wrote:
>> >Fixes compilation error as control.h APIs are not available to
>> >drivers/usb/musb/am35x.c file. Earlier it was getting included
>> >from <plat/control.h> but now moved to new location by another
>> >pacth.
>> >
>> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>>
>> Tony ? Do you ack the usage of that header ?
>
>NAK. Drivers should not mess with the control registers directly.
>
>Instead, the following should be done in the platform init code:
>
>$ grep -r omap_ctrl_read drivers/usb
>drivers/usb/musb/am35x.c:       devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>drivers/usb/musb/am35x.c:       while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
>drivers/usb/musb/am35x.c:       devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>drivers/usb/musb/am35x.c:               lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
>drivers/usb/musb/am35x.c:       u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>drivers/usb/musb/am35x.c:       sw_reset = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
>drivers/usb/musb/am35x.c:       lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
>
>You can pass a function pointer like board_set_power or simila in
>platform_data.

That was my feeling too. Anand, care to update ?!?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
