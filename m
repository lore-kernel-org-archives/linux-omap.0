From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP3: GPIO off-mode fixes
Date: Wed, 11 Mar 2009 15:11:52 -0700
Message-ID: <87wsavogk7.fsf@deeprootsystems.com>
References: <1236339986-29506-1-git-send-email-tero.kristo@nokia.com>
	<87mybuy1ky.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A20378951294@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:62547 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZCKWL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 18:11:57 -0400
Received: by wf-out-1314.google.com with SMTP id 28so247059wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 15:11:55 -0700 (PDT)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A20378951294@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Wed\, 11 Mar 2009 11\:04\:34 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

<Tero.Kristo@nokia.com> writes:

> The first patch in this set contains a small bug, missing kfree() for one of the dynamically reserved arrays during init in error path. Sending a fixed patch now.
>

Thanks Tero.  I will undo the first version and re-push with this version.

Kevin

>
>>-----Original Message-----
>>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>Sent: 09 March, 2009 20:48
>>To: Kristo Tero (Nokia-D/Tampere)
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH 0/2] OMAP3: GPIO off-mode fixes
>>
>>Tero Kristo <tero.kristo@nokia.com> writes:
>>
>>> These two patches add fixes to GPIO off-mode handling. First 
>>patch is 
>>> more important as it fixes a HW bug, second one just optimizes 
>>> off-mode code a bit by removing a couple of unnecessary 
>>registers from the context save.
>>
>>Thanks, pushing both patches to PM branch.
>>
>>Kevin
>>
