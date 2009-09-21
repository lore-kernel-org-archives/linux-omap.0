From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: linux omap on sdp broken?
Date: Tue, 22 Sep 2009 00:16:04 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9DAF7DF@dbde02.ent.ti.com>
References: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>,<94a0d4530909211138g25d2cf9dxaf445032e350a45a@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbZIUSqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 14:46:06 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Gadiyar, Anand
>Sent: Monday, September 21, 2009 1:43 PM
>To: Felipe Contreras; Nishanth Menon
>Cc: linux-omap
>Subject: RE: linux omap on sdp broken?
>
>> Hi Folks,
>> > Has Anyone tried booting latest kernel from tmlind master tree recently?
>> > Ref: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>> >
>> > Starting kernel ...
>> > Uncompressing
>Linux................................................................................................
>.................................................................
>> > done, booting the kernel.
>> >
>> > Gets stuck there..
>>
>> Same on beagleboard. Something got broken from 2.6.30 to 2.6.31.
>>
>> --
>> Felipe Contreras
>>
>
>It seems to work okay for me on SDP, so maybe it's related to the bootloader?
>
>Felipe, Nishant,
>What was the last known working version for you?

Maybe it's the new bootloader: 
the new support for SDP on upstream u-boot that Nishant Menon added last week.

>
>- Anand
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

