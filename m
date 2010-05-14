From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 12/22] OMAP3: PM: Minimizing the passing around of sr id in smartreflex.c
Date: Fri, 14 May 2010 10:14:23 -0700
Message-ID: <87wrv6l828.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<87pr1kius7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322D7D370@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62282 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab0ENRO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 13:14:28 -0400
Received: by gyg13 with SMTP id 13so1340932gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 10:14:27 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D370@dbde02.ent.ti.com> (Thara Gopinath's message of "Thu\, 13 May 2010 12\:43\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch ensures that sr id is passed as a parameter only to
>>>> public APIs in smartreflex.c and other APIs in smartreflex.c
>>>> uses the omap_sr strucutres.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>Good change, but...
>>>

[...]

>>>
>>>... the class3 layer is still taking SR ID as a parameter and it
>>>should also just take an sr_info ptr.
>
> sr_info is an internal structure for smartreflex driver. The
> intention behind this patch is all external API's pass the srid and
> internally the driver static APIs take sr_info as parameter. 

OK, that makes sense.  I though I saw the usage of _sr_lookup() inside
the class driver which made me think it should just take sr_info.  But
looking again now, I see it's only using the id.

> I did not realize this point till now when I was doing the actual
> changes and hence the late reply :-)

no worries, thanks for clarifying.

Kevin
