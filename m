From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code
 cleanup
Date: Fri, 17 Apr 2009 14:31:26 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E239D2906@dlee03.ent.ti.com>
References: <49E89649.9050103@yandex.ru>
 <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
 <49E8A50D.2010602@yandex.ru>
 <27F9C60D11D683428E133F85D2BB4A530404A089E0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbZDQTbl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 15:31:41 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530404A089E0@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>, Artem Bityutskiy <dedekind@yandex.ru>, Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Artem Bityutskiy wrote:
> >
> >I'm sorry. Authors of the code may delete this e-mail.
> >More flame and suggestions.
> >
> 
> Thanks for your suggestions; it is true that bridge code has been out for
> a while, almost a year I think, and we are still trying to enhance it and
> clean it up along the way, although it may seem we have stalled on the
> task.
> 
> Please friendly flame about other parts of bridge code too ;) as we can
> take very good points of your's/everyone's comments and try to put in
> better shape the driver to be pushed into mainline (as this has been the
> goal all the time). Thanks for the time reviewing the code.
> 
-- Good point, Omar. Artem, please continue sending your comments so that we can continue to improve this code. Progressing from the stage where the Bridge code used to be delivered in the form of tarballs a year ago to delivering it on GIT tree where the patches can be applied was only possible because of comments/suggestions/flames that were received on this mailing list.  

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ramirez Luna, Omar
> Sent: Friday, April 17, 2009 12:45 PM
> To: Artem Bityutskiy; Ameya Palande
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code
> cleanup
> 
> Hi,
> 
> Artem Bityutskiy wrote:
> >
> >I'm sorry. Authors of the code may delete this e-mail.
> >More flame and suggestions.
> >
> 
> Thanks for your suggestions; it is true that bridge code has been out for
> a while, almost a year I think, and we are still trying to enhance it and
> clean it up along the way, although it may seem we have stalled on the
> task.
> 
> Please friendly flame about other parts of bridge code too ;) as we can
> take very good points of your's/everyone's comments and try to put in
> better shape the driver to be pushed into mainline (as this has been the
> goal all the time). Thanks for the time reviewing the code.
> 
> - omar ramirez
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

