From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] [DSPBRIDGE] Various compile warning fixes
Date: Fri, 17 Apr 2009 09:20:30 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23958BAC@dlee03.ent.ti.com>
References: <1239960602-32309-1-git-send-email-ameya.palande@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A9985148@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758060AbZDQOUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 10:20:41 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A9985148@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya,

-	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
+	if (chnlId >= CHNL_MAXCHANNELS) {

-- How about declaring chnlId as s32 so that the checks can be extended to negative values too ? 

Thank you,
Best regards,
Hari
