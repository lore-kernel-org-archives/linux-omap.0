From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Thu, 23 Sep 2010 12:30:21 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D99B@dbde02.ent.ti.com>
References: <1285201816-26516-1-git-send-email-hemahk@ti.com>
 <4C9A6A62.5000100@ti.com> <20100923062317.GD2563@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab0IWHA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 03:00:27 -0400
In-Reply-To: <20100923062317.GD2563@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

Hi, 

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Thursday, September 23, 2010 11:53 AM
>To: Cousson, Benoit
>Cc: Kalliguddi, Hema; linux-omap@vger.kernel.org; 
>linux-usb@vger.kernel.org; Basak, Partha; Balbi, Felipe; Tony 
>Lindgren; Kevin Hilman; Paul Walmsley
>Subject: Re: [PATCH 7/9 v3] OMAP: Hwmod api changes
>
>On Wed, Sep 22, 2010 at 03:43:14PM -0500, Cousson, Benoit wrote:
>>Hi Hema,
>>
>>On 9/23/2010 2:30 AM, Kalliguddi, Hema wrote:
>>> OMAP USBOTG modules has a requirement to set the auto idle 
>bit only after
>>> setting smart idle bit. Modified the _sys_enable api to set 
>the smart idle
>>> first and then the autoidle bit. Setting this will not have 
>any impact on the
>>> other modules.
>>
>>I think you should change the subject, because it does not reflect
>>accurately the patch.
>>
>>Just a little bit of nitpicking...
>>For me, an API change is a change in the signature of the API, not a
>>change inside an API. Otherwise, since 99% of the code is inside a
>>function, we can call most patches like that...
>>Moreover I don't think _sysc_enable can be considered as an 
>API since it
>>is a pure static helper function not exported to the outside.
>>
>>Something like that seems more accurate for my point of view:
>>
>>OMAP: hwmod: Set autoidle after smartidle during _sysc_enable
>
>+1
>
I Agree. I will do the changes accordingly and post the patch.
>-- 
>balbi
>