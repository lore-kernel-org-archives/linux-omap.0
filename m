From: Nishanth Menon <nm@ti.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Thu, 06 Jan 2011 11:57:28 -0600
Message-ID: <4D260288.8070406@ti.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au><4D139517.3010608@ti.com> <AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com> <4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com> (sfid-20110106_100805_509520_6CE1697E) <4D25E313.4060202@heeltoe.com> <8B3471BB-CB3F-4CE6-B523-D9C5E87B9CEC@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <8B3471BB-CB3F-4CE6-B523-D9C5E87B9CEC@dominion.thruhere.net>
Sender: linux-next-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Brad Parker <brad@heeltoe.com>, Anand Gadiyar <gadiyar@ti.com>, Ming Lei <tom.leiming@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Koen Kooi had written, on 01/06/2011 10:59 AM, the following:
> Op 6 jan 2011, om 16:43 heeft Brad Parker het volgende geschreven:
> 
>> It's probably expected, but I can't get the EHCI USB port  to work
>> on a beagle board XM (36xx) using the current omap tree.
>>
>> It this most likely due to these clock issues?
> 
> You need this patch: http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> 
> I'm currently too lazy to split it up like Nishant wants as I don't see the point splitting for the sake of splitting.--
Alrite, if it is ok with you and Tony, I will help post the split up - 
this will help multiple things:
a) prevents the patch being held off because of multiline comments and 
the link
b) git bisect can isolate to a specific change.
c) A patch should do a single logical thing for helping (b).

-- 
Regards,
Nishanth Menon
