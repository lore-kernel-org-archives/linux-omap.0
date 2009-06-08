From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Mon, 8 Jun 2009 06:54:10 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115B7A127@dlee02.ent.ti.com>
References: <1244121977-24927-1-git-send-email-ameya.palande@nokia.com>
	<27F9C60D11D683428E133F85D2BB4A53040F3FCD75@dlee03.ent.ti.com>
 <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbZFHLyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 07:54:18 -0400
In-Reply-To: <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Monday, June 08, 2009 6:34 AM
> To: Ramirez Luna, Omar
> Cc: ameya.palande@nokia.com; linux-omap@vger.kernel.org;
> felipe.contreras@gmail.com
> Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
> 	http://marc.info/?l=linux-omap&m=124201773423892&w=2
> 
> for the second one about 128 byte alignment. let me know your
> thought/plan on it.

How about enabling this[1] under a configurable option? Though this is a strong check, currently components such as ti-openmax IL does a padded allocation to ignore overwrite of buffer region which might be at risk.

The check is desirable, but should have an option to disable it, if so desired.

Regards,
Nishanth Menon
Ref:
[1] http://marc.info/?l=linux-omap&m=124201773423892&w=2
