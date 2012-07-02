From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH] remoteproc: block premature rproc booting
Date: Mon, 2 Jul 2012 17:15:13 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C10579232F86BE4C@EXDCVYMBSTM005.EQ1STM.local>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
 <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:57330 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082Ab2GBPPl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 11:15:41 -0400
In-Reply-To: <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic BARRE <ludovic.barre@stericsson.com>, Loic PALLARDY <loic.pallardy@stericsson.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ohad,

> Sjur, Ludovic, Loic - what remoteproc API are you using today?
> 
> We'd like to get rid of the existing get/put interface and instead
> have everyone use the boot/shutdown one, just like rpmsg is doing
> today.
> 
> Are you ok with this change?

Yes, I'm ok with this,
but I cannot answer for Loic and Ludovic.

Regards,
Sjur
