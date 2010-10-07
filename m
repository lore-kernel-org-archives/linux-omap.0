From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v4 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 7 Oct 2010 13:07:18 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94ADFB@dbde02.ent.ti.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
	 <1284559794-4771-2-git-send-email-archit@ti.com>
 <1286435365.28499.1012.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44335 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab0JGHh1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 03:37:27 -0400
In-Reply-To: <1286435365.28499.1012.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Wed, 2010-09-15 at 16:09 +0200, ext archit@ti.com wrote:
>> From: Archit Taneja <archit@ti.com>
>> 
>> Add dss_features.c and dss_features.h for the dss_features framework
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
> 
> <snip>
> 
>> +struct omap_dss_features {
>> +	const struct dss_reg_field *reg_fields;
>> +	const int num_reg_fields;
>> +
>> +	const u32 has_feature;
> 
> I only now noticed that you had changed the feature list to a bit array.
> It was an array of ints previously. Are you sure 32 features is enough?
> It sounds a bit small to me.
> 
>  Tomi

I was reworking our omap4 tree with the dss_features patch and was able to reach to 11
features. 32 may be probably enough till omap4, but yeah you are right, we will cross
32 at some point in time. I didn't like the array way before, any idea how we can extend
the bit array method for more than 32 features?

Thanks,

Archit