From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra7xx: Fix compatible string for PCF8575 chip
Date: Mon, 9 May 2016 08:49:29 +0200
Message-ID: <573032F9.50604@linutronix.de>
References: <1461588834-20908-1-git-send-email-rogerq@ti.com>
 <1462386203.2360.12.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462386203.2360.12.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/04/2016 08:23 PM, Ben Hutchings wrote:
> On Mon, 2016-04-25 at 15:53 +0300, Roger Quadros wrote:
>> The boards use a TI variant of the PCF8575 so specify that
>> in the compatible string.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> [...]
> 
> 1. This compatible string is still not documented (AFAIK).
> 2. As I understand it, TI is a second source for this NXP-designed chip,
> i.e. it manufactures chips with identical logic (not clones) under
> license.  They should not be distinguishable in software.

Mistakes don't happen on purpose.

> 3. For the same reason, there is no guarantee that the board
> manufacturer won't populate boards with PCF8575 chips from the other
> source in future.

If it is a redesign it is likely that they replace more than just one
part.

> 
> Ben.
> 
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
