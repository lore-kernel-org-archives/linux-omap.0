From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 6/6] omap: iommu: code reorganization and cleanup
Date: Sun, 7 Nov 2010 10:29:05 -0600
Message-ID: <AANLkTi=oWi7Dgh8L-hFfJ8B4rEiD+xUbtgX21+-q63d-@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
	<AANLkTikhTmmy0fcOMfA0tUE=wuj03X1KajmB4A-ygxPz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53900 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753582Ab0KGQ3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 11:29:06 -0500
Received: by iwn3 with SMTP id 3so5366641iwn.12
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:29:05 -0800 (PST)
In-Reply-To: <AANLkTikhTmmy0fcOMfA0tUE=wuj03X1KajmB4A-ygxPz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 6, 2010 at 3:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 6, 2010 at 3:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Since omap-iommu is now using hwmod, there are structures and
>> arrays that can be cleaned up to increase the readability of
>> the code.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> NAK.

Mostly agree, no need to discuss as this is going to change, will keep
CONFIG_MPU_BRIDGE_IOMMU.

Regards,

Omar
