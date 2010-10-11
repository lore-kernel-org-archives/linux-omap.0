From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 17/17] dmtimer: remove OCP config code from plat-omap
Date: Mon, 11 Oct 2010 17:00:47 +0200
Message-ID: <4CB3269F.8060708@ti.com>
References: <1285059404-26718-1-git-send-email-tarun.kanti@ti.com> <4CA9E41C.7000504@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E970AC8@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E970AD7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36829 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab0JKPAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 11:00:52 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035E970AD7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On 10/11/2010 11:41 AM, DebBarma, Tarun Kanti wrote:

<...>

>> In summary, I will make following updates:
>> .clockact = 0x2
>> SYSC_HAS_CLOCKACTIVITY flag should be included.
> After going through the code I realized that this flag is already there.
> I am not sure where you observed this flag missing?

You're right, it was missing from the patch, but in fact already there 
in the code.
Sorry on that one.

Benoit
