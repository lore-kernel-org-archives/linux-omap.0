From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 0/2] OMAP3: GPIO off-mode fixes
Date: Wed, 11 Mar 2009 11:04:34 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A20378951294@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1236339986-29506-1-git-send-email-tero.kristo@nokia.com>
 <87mybuy1ky.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46105 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZCKKFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 06:05:15 -0400
In-Reply-To: <87mybuy1ky.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

The first patch in this set contains a small bug, missing kfree() for one of the dynamically reserved arrays during init in error path. Sending a fixed patch now.

-Tero 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 09 March, 2009 20:48
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 0/2] OMAP3: GPIO off-mode fixes
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> These two patches add fixes to GPIO off-mode handling. First 
>patch is 
>> more important as it fixes a HW bug, second one just optimizes 
>> off-mode code a bit by removing a couple of unnecessary 
>registers from the context save.
>
>Thanks, pushing both patches to PM branch.
>
>Kevin
>