From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Tue, 7 Sep 2010 17:36:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087031162D425@dbde02.ent.ti.com>
References: <1282826618-24584-1-git-send-email-archit@ti.com>
	 <1282826618-24584-2-git-send-email-archit@ti.com>
	 <1283854985.2363.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087031162D3EF@dbde02.ent.ti.com>
 <1283860777.2363.83.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36606 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab0IGMHG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 08:07:06 -0400
In-Reply-To: <1283860777.2363.83.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> On Tue, 2010-09-07 at 13:31 +0200, ext Taneja, Archit wrote:
>> Hi,
>> 
>> Tomi Valkeinen wrote:
>>> Hi,
>>> 
>>> On Thu, 2010-08-26 at 14:43 +0200, ext Archit Taneja wrote:
>>>> Add dss_features.c and dss_features.h for the dss_features framework
>>>> 
>>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>> 
>>> Would a more static approach be cleaner? I mean something like this (pseudo
>>> code):
>>> 
>>> static struct omap_dss_features omap3_dss_features = {
>>> 	/* array of register definitions */
>>> 	.registers = {
>>> 		{
>>> 			.register = FIRHINC,
>>> 			.high = 12,
>>> 			.low = 0,
>>> 		},
>>> 		{
>>> 			.register = FIRVINC,
>>> 			.high = 28,
>>> 			.low = 16,
>>> 		},
>>> 		...
>>> 	},
>>> 
>>> 	/* array of feature ids */
>>> 	.features = {
>>> 		GLOBAL_ALPHA,
>>> 		GLOBAL_ALPHA_VIDEO1,
>>> 		...
>>> 	},
>>> };
>>> 
>>> And then the code would select the omapX_dss_features struct to use
>>> depending on the omap version.
>> 
>> It looks way cleaner out here , not sure though what it would look
>> like once the whole file is filled up :)
>> 
>> One issue with having separate omapX_dss_features is something which
>> might may come later on : If there is a feature/value which is same in
>> omap2 and omap3 but different in omap4, we will sill need
> to fill up all the structs completely.
>> 
>> We can get around this by filling one single struct on runtime :
>> 
>> all omap2 specific features filled up here { ...
>> ...
>> }
>> 
>> all common between omap2 and omap3 filled up here { ... ...
>> }
>> 
>> all omap3 specific filled up here
>> {
>> ...
>> ...
>> }
>> 
>> And so on..
>> 
>> This will save up space, but won't give a very clean look ..
>> 
>> I think by the time all omap4(and 3630) features are added and remaining
>> omap2,3 checks are removed we will have atleast 20 or so register
>> fields and a dozen features. Initializing them statically for all
>> omaps(including the ES_REV's) will really stretch up the file. But it will
>> still look clean :) 
>> 
>> What's your call on this?
> 
> I'd try with static structs. I agree that if there are lots
> of features/registers which are the same on multiple omaps,
> there's redundant code needed. But it just needs to be
> written once, and having lots of if(omap_xxxx()) lines will
> be a nightmare to maintain.
> 
> Or if things get really long, we could use multiple files,
> one for each omap.
> 
> Also, we can make the definitions a bit shorter by using
> macros where suitable. For example the registers could be
> defined with something like FEAT_REG(FIRHINC, 12, 0), which
> will will the fields properly.

Okay, I will try this out.

Archit

> Or there could be a define for feature IDs, which could be appended. Like:
> 
> #define FEAT_ID_OMAP2 AAA,\
> 	BBB,\
> 	CCC
> 
> #define FEAT_ID_OMAP3 FEAT_ID_OMAP2,\
> 	DDD,\
> 	EEE,\
> 
> But... That's getting a bit nasty, I wouldn't do things like
> that if not absolutely needed =).
> 
>  Tomi