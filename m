From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Mon, 07 May 2012 14:46:35 +0300
Message-ID: <4FA7B61B.3020604@compulab.co.il>
References: <4F901CCC.9000703@compulab.co.il> <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org> <20120420115728.GF12830@arwen.pp.htv.fi> <4FA61941.5080603@compulab.co.il> <20120507080907.GB3229@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120507080907.GB3229@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On 05/07/12 11:09, Samuel Ortiz wrote:
> Hi Igor,
> 
> On Sun, May 06, 2012 at 09:25:05AM +0300, Igor Grinberg wrote:
>> Sorry, for being jumpy...
>> Samuel has not answered yet (it has been more then two weeks already)
> Sorry about that.
> 
>> and I'd like this to go into 3.5.
> Then you may need a better changelog explaining how this fixes a regression,
> runtime crash or build failure.

Well, I did not say it is a regression. In fact it is not.
I just finally sent a fix to eliminate a runtime warning which was there
for a long time and can be seen on specific configurations.
That is why, I want it into 3.5 during the merge window
(not 3.4 although I won't object it to go in earlier ;-) ).

> 
> 
>> Also, the dependency patch is already in Linus' tree. It has been merged with
>> fixes (I thought it will happen only during the merge window...).
>>
>> Can you, please take this one?
> At that point, it definitely makes more sense for Alan to push it.

Yep, makes sense to me.

Alan?

-- 
Regards,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
