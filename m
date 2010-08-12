From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 09:23:43 +0300
Message-ID: <20100812062343.GD23362@nokia.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
 <AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
 <AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
 <AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
 <AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
 <AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:22903 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066Ab0HLGXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 02:23:16 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Kamoolkar, Mugdha" <mugdha@ti.com>
Cc: Hari Kanigeri <hari.kanigeri@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

Hi,

On Thu, Aug 12, 2010 at 08:16:23AM +0200, ext Kamoolkar, Mugdha wrote:
>One thing I would like to mention is that the DMM feature does require 
>the slave DSP to have an MMU. The OMAPL1xx devices do not have MMU for 
>the DSP. DMM cannot be implemented without the DSP having an MMU. 
>Hence, even if you ported DSPBridge to OMAPL1xx devices, you could not 
>make use of the DMM feature.

your lines are still too wide. Tell your mailer to break them on 80 
characters.

-- 
balbi

DefectiveByDesign.org
