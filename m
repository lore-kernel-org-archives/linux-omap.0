From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Wed, 24 Nov 2010 22:19:28 -0800
Message-ID: <AANLkTin6Sp1k-1sYYrRLc4T7z8gv9MgUOc7Yp8S3B53x@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<87lj4i2nb2.fsf@deeprootsystems.com>
	<AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52404 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0KYGT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 01:19:29 -0500
Received: by iwn34 with SMTP id 34so536159iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 22:19:29 -0800 (PST)
In-Reply-To: <AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

Hi Charu,

[...]

>>
>> Please be sure your board file changes are updated for the board fil=
e
>> changes in the devel-board branch.
>
> Okay. But if it is different, should I send only the board files chan=
ges on
> devel-board =A0branch as a separate patch mentioning the dependencies=
 on
> my patch series?
>

My pm-core includes the devel-board branch since it's part of Tony's
for-next, so that shouldn't be necessary.

However, if you find it's easier to break it into separate series feel
free, as long as the dependencies are mentioned.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
