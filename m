From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Thu, 20 May 2010 18:16:22 +0300
Message-ID: <20100520151622.GB13016@nokia.com>
References: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
 <304844.15257.qm@web180316.mail.gq1.yahoo.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <304844.15257.qm-4JhmkcZgSkkHBU+L9ui1Svu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Maulik OjasMankad <x0082077-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ajay KumarGupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 20, 2010 at 05:15:30PM +0200, ext David Brownell wrote:
>
>>  I think better remove .mode parameter from board_data if
>> its not needed anyways
>
>But it *IS* needed, as I explained before...
>
>
>
>> if some board
>>  supports only some specific mode they can select those
>> specifc config only.
>
>No they can't.  Recall that kernels are expected to run on
>multiple boards.  Which means that the same kernel should be
>able to work correctly on a board with a peripheral-only USB
>connector ... and on a board with an OTG connector.  The way
>to pass that information to the MUSB driver is through the
>platform data.  On the peripheral-only config the host code
>won't kick in.  On the OTG-enabled config, it will kick in
>as needed (as will the peripheral mode).  And so on.
>
>If you were to rely on Kconfig options, then at least one of
>those boards would work incorrectly.  So that's not an option.

that's basically why I had made mode a parameter to usb_musb_init() so 
boards could pass they're own configuration. We still have the Kconfig 
to allow single board peripheral only defconfigs (line n900_defconfig) 
to remove unnecessary code from the kernel.

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
