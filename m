From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] Fixed OMAP3 version check
Date: Thu, 25 Sep 2008 14:45:24 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394308CEC0F@vaebe110.NOE.Nokia.com>
References: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com> <1221572797-15949-2-git-send-email-tero.kristo@nokia.com> <20080925101750.GG5222@atomide.com> <20080925102331.GC24627@gandalf.research.nokia.com> <20080925103120.GI5222@atomide.com> <20080925114117.GD24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18424 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYIYLpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 07:45:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080925114117.GD24627@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Balbi Felipe (Nokia-D/Helsinki) 
>Sent: 25 September, 2008 14:41
>To: ext Tony Lindgren
>Cc: Balbi Felipe (Nokia-D/Helsinki); Kristo Tero 
>(Nokia-D/Tampere); linux-omap@vger.kernel.org
>Subject: Re: [PATCH] Fixed OMAP3 version check
>
>On Thu, Sep 25, 2008 at 01:31:21PM +0300, Tony Lindgren wrote:
>> * Felipe Balbi <felipe.balbi@nokia.com> [080925 13:24]:
>> > On Thu, Sep 25, 2008 at 01:17:51PM +0300, Tony Lindgren wrote:
>> > > Hi,
>> > > 
>> > > * Tero Kristo <tero.kristo@nokia.com> [080916 14:59]:
>> > > > CPU version was reported incorrectly (e.g. ES3.0 instead of 
>> > > > ES2.1.) Also added a piece of optimization for CPU 
>type check (omap_type()).
>> > > > 
>> > > > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> > > > ---
>> > > >  arch/arm/mach-omap2/id.c |    7 +++++--
>> > > >  1 files changed, 5 insertions(+), 2 deletions(-)
>> > > > 
>> > > > diff --git a/arch/arm/mach-omap2/id.c 
>b/arch/arm/mach-omap2/id.c 
>> > > > index ab7a6e9..4e2b449 100644
>> > > > --- a/arch/arm/mach-omap2/id.c
>> > > > +++ b/arch/arm/mach-omap2/id.c
>> > > > @@ -37,7 +37,10 @@ EXPORT_SYMBOL(omap_chip_is);
>> > > >  
>> > > >  int omap_type(void)
>> > > >  {
>> > > > -	u32 val = 0;
>> > > > +	static u32 val;
>> > > > +
>> > > > +	if (val != 0)
>> > > > +		return val;
>> > > 
>> > > Hmm I guess this would return a random val? :)
>> > 
>> > it would return 0, look that val is static.
>> 
>> Ah, sorry I did not see the static. So this is to cache the 
>result to 
>> optimize it? I'd assume this function is only needed during 
>some init 
>> code hopefully where performance does not matter..
>
>Yeah, it's not like we're gonna check the revision after the 
>board is botted all up I guess.

PM code will need to either cache the type information or call this
check every time when entering off-mode. Some things work differently in
secure chips. Could probably just cache this inside PM code.

-Tero
