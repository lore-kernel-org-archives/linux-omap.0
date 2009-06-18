From: Tony Lindgren <tony@atomide.com>
Subject: Re: L-O master branch broken ?
Date: Thu, 18 Jun 2009 13:22:39 +0300
Message-ID: <20090618102237.GI8482@atomide.com>
References: <00eb01c9eff8$13dba760$LocalHost@wipultra793> <20090618075257.GF8482@atomide.com> <011e01c9f000$fc86f8e0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62535 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbZFRMWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 08:22:45 -0400
Content-Disposition: inline
In-Reply-To: <011e01c9f000$fc86f8e0$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [090618 13:39]:
> ----- Original Message ----- From: "Tony Lindgren" <tony@atomide.com>
>
>
>>> I get the below error while compiling 3430SDP. I see below commit  as the
>>> latest one.
>
>>
>> Thanks, pushing a fix right now with the missing brace missing from  
>> Kevin's
>> sram.c patch. Also moved around the defines so sram.c build for omap1.
>>
>
> Booting still seems to have problems. Its hung after start kernel
>
>
> Bytes transferred = 2480664 (25da18 hex)
> ## Booting image at 80000000 ...
>   Image Name:   Linux-2.6.30-omap1-06022-g6f4712
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    2480600 Bytes =  2.4 MB
>   Load Address: 80008000
>   Entry Point:  80008000
>   Verifying Checksum ... OK
> OK
>
> Starting kernel ... 
>

Can you see what happens with DEBUG_LL enabled?

Tony
