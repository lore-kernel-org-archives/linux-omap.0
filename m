From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v4 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 7 Oct 2010 13:46:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94AE45@dbde02.ent.ti.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
	 <1284559794-4771-2-git-send-email-archit@ti.com>
	 <1286435365.28499.1012.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034B94ADFB@dbde02.ent.ti.com>
 <1286437331.28499.1020.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759436Ab0JGIRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 04:17:07 -0400
In-Reply-To: <1286437331.28499.1020.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> On Thu, 2010-10-07 at 09:37 +0200, ext Taneja, Archit wrote:
>> Hi,
> 
>>> I only now noticed that you had changed the feature list to a bit array.
>>> It was an array of ints previously. Are you sure 32 features is enough? It
>>> sounds a bit small to me. 
>>> 
>>>  Tomi
>> 
>> I was reworking our omap4 tree with the dss_features patch and was
>> able to reach to 11 features. 32 may be probably enough till omap4,
>> but yeah you are right, we will cross
>> 32 at some point in time. I didn't like the array way before, any idea
>> how we can extend the bit array method for more than 32 features?
> 
> Do you mean 32 will probably be enough for omap2,3 and 4? If
> so, I think we can go forward with this. It is a
> dss_features.c internal detail, and can be changed easily in
> the future to accomodate more features.
> 
>  Tomi

Yes, a rough count results in around 25-26 features till omap4. I think
we can go ahead with the bit array for now.

Regards,

Archit