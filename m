From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 3/3] OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
Date: Tue, 8 Mar 2011 20:41:03 -0500
Message-ID: <AANLkTikKGKqonAiMTDQk+9mvx6bU3EzYrEy6wzP+cgoq@mail.gmail.com>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
 <20110308021551.31946.19903.stgit@twilight.localdomain> <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
 <alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42045 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755227Ab1CIBlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 20:41:45 -0500
Received: by mail-fx0-f41.google.com with SMTP id 5so58643fxm.0
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 17:41:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 8, 2011 at 13:10, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 8 Mar 2011, Varadarajan, Charulatha wrote:
>
>> Do you really want to return 1 in case of invalid powerdomain pointe=
r?
>
> Sure, that's why I wrote it that way. =A0It seems less risky than ret=
urning
> 0. =A0Do you have a proposal that makes more sense, given that this i=
s going
> to be called immediately after a omap_{device,hwmod}_get_pwrdm() ?

Well. This means that it is the caller's responsibility to verify the
powerdomain pointer before calling this function. Otherwise, this
function assumes that the powerdomain looses context.

I thought that it would be appropriate to return an int value, with
which, the func would return an error in case of pwrdm ptr error,
return a zero if the powerdomain can ever loose context and a
non-zero value otherwise. What do you think?

-V Charulatha

>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
