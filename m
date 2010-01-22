From: <mika.kukkonen@nokia.com>
Subject: RE: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Fri, 22 Jan 2010 07:00:33 +0100
Message-ID: <20D73E2631F7914F868646E119DEC1CE21024B2780@NOK-EUMSG-02.mgdnok.nokia.com>
References: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
	 <5ec8ebd51001210801h3eb8c337l2cd0d4e501ed724f@mail.gmail.com>
 <1264091588.3544.12.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63525 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0AVGAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 01:00:53 -0500
In-Reply-To: <1264091588.3544.12.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ameya.palande@nokia.com, andy.shevchenko@gmail.com
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

>-----Original Message-----
>From: Palande Ameya (Nokia-D/Helsinki) 
>Sent: 21 January, 2010 18:33
>To: ext Andy Shevchenko
>Cc: linux-omap@vger.kernel.org; omar.ramirez@ti.com; 
>nm@ti.com; deepak.chitriki@ti.com; Kukkonen Mika (Nokia-D/Helsinki)
>Subject: Re: [PATCH] DSPBRIDGE: Various compile warning fixes
>
>On Thu, 2010-01-21 at 17:01 +0100, ext Andy Shevchenko wrote:
>> On Thu, Jan 21, 2010 at 3:40 PM, Ameya Palande 
><ameya.palande@nokia.com> wrote:
>> > --- a/drivers/dsp/bridge/wmd/io_sm.c
>> > +++ b/drivers/dsp/bridge/wmd/io_sm.c
>> > @@ -1210,7 +1210,7 @@ static void InputChnl(struct IO_MGR 
>*pIOMgr, struct CHNL_OBJECT *pChnl,
>> >                            pChnlMgr->uWordSize;
>> >        chnlId = IO_GetValue(pIOMgr->hWmdContext, struct 
>SHM, sm, inputId);
>> >        dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, 
>sm, arg);
>> > -       if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
>> > +       if (chnlId >= CHNL_MAXCHANNELS) {
>> Could chnlld be less than zero? Anyway better to test:
>> (chnlId >= CHNL_MAXCHANNELS || chnlld < 0)
>> 
>
>chnlId is defined as u32 ;)

Yeah, this is the ages old discussion about whether it makes
sense to test if unsigned is smaller than zero.

a) compiler complain (with extra flags), since it is NOP
b) from casual reader viewpoint, it is nice annotation
   (you know the range of the value without needing to
    check the type)
c) on the other hand, it may mislead somebody to think that
   the variable is signed
d) use of unsigned should always be a design decision, and
   things get pretty dangerous when there are lot of layers
   (I think over the years I have at least twice seen a driver
   that returned on lower levels -ERRNO that got assigned to
   unsigned at higher levels)

Summary: Linus likes the check, compiler (and I) don't.
Choose your side :-)

--MiKu