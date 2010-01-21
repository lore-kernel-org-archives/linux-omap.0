From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Thu, 21 Jan 2010 18:33:08 +0200
Message-ID: <1264091588.3544.12.camel@sanganak>
References: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
	 <5ec8ebd51001210801h3eb8c337l2cd0d4e501ed724f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32891 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0AUQdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 11:33:55 -0500
In-Reply-To: <5ec8ebd51001210801h3eb8c337l2cd0d4e501ed724f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "omar.ramirez@ti.com" <omar.ramirez@ti.com>, "nm@ti.com" <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, "Kukkonen Mika (Nokia-D/Helsinki)" <mika.kukkonen@nokia.com>

On Thu, 2010-01-21 at 17:01 +0100, ext Andy Shevchenko wrote:
> On Thu, Jan 21, 2010 at 3:40 PM, Ameya Palande <ameya.palande@nokia.com> wrote:
> > --- a/drivers/dsp/bridge/wmd/io_sm.c
> > +++ b/drivers/dsp/bridge/wmd/io_sm.c
> > @@ -1210,7 +1210,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
> >                            pChnlMgr->uWordSize;
> >        chnlId = IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputId);
> >        dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, sm, arg);
> > -       if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
> > +       if (chnlId >= CHNL_MAXCHANNELS) {
> Could chnlld be less than zero? Anyway better to test:
> (chnlId >= CHNL_MAXCHANNELS || chnlld < 0)
> 

chnlId is defined as u32 ;)

Cheers,
Ameya.

