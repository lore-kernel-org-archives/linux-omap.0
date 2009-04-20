From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] [DSPBRIDGE] Various compile warning fixes
Date: Mon, 20 Apr 2009 07:59:28 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E239D2D7B@dlee03.ent.ti.com>
References: <1239960602-32309-1-git-send-email-ameya.palande@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A9985148@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E23958BAC@dlee03.ent.ti.com>
 <20D73E2631F7914F868646E119DEC1CE061E6923E9@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42838 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbZDTM7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 08:59:40 -0400
In-Reply-To: <20D73E2631F7914F868646E119DEC1CE061E6923E9@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "mika.kukkonen@nokia.com" <mika.kukkonen@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Miku,

> The field in question is declared in
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h in line 120 as
> u32, so checking for negative value makes no sense unless you
> modify struct SHM too.

-- You are right. I missed checking the declaration in _chnl_sm.h

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: mika.kukkonen@nokia.com [mailto:mika.kukkonen@nokia.com]
> Sent: Monday, April 20, 2009 12:23 AM
> To: Kanigeri, Hari; Gupta, Ramesh; ameya.palande@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] [DSPBRIDGE] Various compile warning fixes
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org
> >[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext
> >Kanigeri, Hari
> >Sent: 17 April, 2009 17:21
> >To: Gupta, Ramesh; Palande Ameya (Nokia-D/Helsinki);
> >linux-omap@vger.kernel.org
> >Subject: RE: [PATCH] [DSPBRIDGE] Various compile warning fixes
> >
> >Ameya,
> >
> >-	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
> >+	if (chnlId >= CHNL_MAXCHANNELS) {
> >
> >-- How about declaring chnlId as s32 so that the checks can be
> >extended to negative values too ?
> 
> The field in question is declared in
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h in line 120 as
> u32, so checking for negative value makes no sense unless you
> modify struct SHM too.
> 
> --MiKu

