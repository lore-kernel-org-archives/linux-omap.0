From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 0/4] RX51: SDRAM settings changes
Date: Tue, 27 Oct 2009 13:48:29 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236CEA822A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
 <871vkqc7mv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19504 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbZJ0Msy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 08:48:54 -0400
In-Reply-To: <871vkqc7mv.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 26 October, 2009 20:50
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 0/4] RX51: SDRAM settings changes
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Following patch set fixes a few issues with current RX51 
>board SDRAM settings.
>> Applies on top of PM branch.
>>
>
>Tero,
>
>Can you resend this series against the master branch?  There 
>is no reason
>this should be carried in the PM branch anymore.
>
>You'll have to add to your series the patch to add the
>board-rx51-sdram.c file, which I currently carry in the PM branch.
>
>Then, for the PM branch, we just need a small patch to add the various
>rate tables in the call to init_common_hw until DVFS stuff is
>upstream.

Ok, I have now done this. I also combined the series into one patch as it will generate a new file and I don't see any need to clutter git-log with several patches to currently non-existent file. Sending out now.

-Tero
