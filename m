From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Tue, 7 Sep 2010 17:01:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087031162D3EF@dbde02.ent.ti.com>
References: <1282826618-24584-1-git-send-email-archit@ti.com>
	 <1282826618-24584-2-git-send-email-archit@ti.com>
 <1283854985.2363.47.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0IGLbX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:31:23 -0400
In-Reply-To: <1283854985.2363.47.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Thu, 2010-08-26 at 14:43 +0200, ext Archit Taneja wrote:
>> Add dss_features.c and dss_features.h for the dss_features framework
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
> 
> Would a more static approach be cleaner? I mean something like this (pseudo
> code): 
> 
> static struct omap_dss_features omap3_dss_features = {
> 	/* array of register definitions */
> 	.registers = {
> 		{
> 			.register = FIRHINC,
> 			.high = 12,
> 			.low = 0,
> 		},
> 		{
> 			.register = FIRVINC,
> 			.high = 28,
> 			.low = 16,
> 		},
> 		...
> 	},
> 
> 	/* array of feature ids */
> 	.features = {
> 		GLOBAL_ALPHA,
> 		GLOBAL_ALPHA_VIDEO1,
> 		...
> 	},
> };
> 
> And then the code would select the omapX_dss_features struct
> to use depending on the omap version.

It looks way cleaner out here , not sure though what it would look
like once the whole file is filled up :)

One issue with having separate omapX_dss_features is something which might may
come later on : If there is a feature/value which is same in omap2 and omap3
but different in omap4, we will sill need to fill up all the structs completely.

We can get around this by filling one single struct on runtime :

all omap2 specific features filled up here
{
...
...
}

all common between omap2 and omap3 filled up here
{
...
...
}

all omap3 specific filled up here
{
...
...
}

And so on..

This will save up space, but won't give a very clean look ..

I think by the time all omap4(and 3630) features are added and remaining
omap2,3 checks are removed we will have atleast 20 or so register fields
and a dozen features. Initializing them statically for all omaps(including
the ES_REV's) will really stretch up the file. But it will still look clean :)

What's your call on this?

Archit

> 
> Also, the feature/register defines should have some prefix,
> and perhaps they could be inside an enum?

Yes we can do this, I'll see while reworking what looks better(enum vs defines)

Archit
> 
>  Tomi