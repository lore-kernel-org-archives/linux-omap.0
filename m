From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: How to checkout v2.6.31-rc3 using git
Date: Wed, 15 Jul 2009 02:56:47 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5679BEA@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
 <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49744 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbZGNV1B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 17:27:01 -0400
In-Reply-To: <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>Sent: Tuesday, July 14, 2009 3:08 PM
>To: Pandita, Vikram
>Cc: Linux OMAP Users
>Subject: Re: How to checkout v2.6.31-rc3 using git
>
>Hi Vikram,
>
>On Jul 15, 2009, at 12:03 AM, Pandita, Vikram wrote:
>
>>
>> If your requirement is a good PM, then the best place is kevin's pm
>> branch I guess.
>>
>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
>> head: pm
>
>I want to also incorporate tomi's DSS2 patches, so what I was thinking
>was continuing off the linux-omap-2.6 master branch, starting with
>rc1, and then pull the delta patches off Kevin and Tomi's git
>repositories, and incorporating them as delta patches into my
>openembedded recipe for the overo.
>
>This way, I can maintain the same structure that the overo recipe
>uses, and pull off the latest delta patches for DSS2 and PM.
>
>What do you think?

All this is already available and integrated on android public git tree.
This had DSS2 and PM.

http://android.git.kernel.org/?p=kernel/omap.git;a=summary
Head: android-omap-2.6.29
Validated on Zoom2.

>
>Best regards,
>
>Elvis
>

