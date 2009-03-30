From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: Query about DSP_Close() function
Date: Mon, 30 Mar 2009 13:55:02 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2357EFA4@dlee03.ent.ti.com>
References: <49D0F8DA.4060900@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2357EF0E@dlee03.ent.ti.com>
 <94a0d4530903301144i38928c13wd9f802550ef8aa9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43422 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247AbZC3SzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 14:55:14 -0400
In-Reply-To: <94a0d4530903301144i38928c13wd9f802550ef8aa9b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, Doyu Hiroshi <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe,

> 
> Why? Wouldn't it make more sense to cleanup at close, exactly when the
> file descriptor is closed?
>

-- Yes, I agree with you that it does make more sense and looks cleaner to cleanup the resources at closeup and this is in our TODO list. This change requires some modification to the existing resource cleanup design though.

Thank you,
Best regards,
Hari
