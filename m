From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH] omap: zoom2/3: fix build caused by wl1271 support
Date: Wed, 6 Oct 2010 19:31:39 +0530
Message-ID: <AANLkTinHA+JS1MObanawFF8ktW6OEMGr7CnJhakUetPz@mail.gmail.com>
References: <1285965206-17777-1-git-send-email-gadiyar@ti.com>
 <20101001231026.GH3117@atomide.com> <1286279588.15401.28.camel@chilepepper>
 <1286280426.15401.29.camel@chilepepper> <1286284790.15401.53.camel@chilepepper>
 <1286311187.2793.7.camel@powerslave> <20101006135221.GE2472@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45524 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756693Ab0JFOCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 10:02:03 -0400
In-Reply-To: <20101006135221.GE2472@tuxdriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Luciano Coelho <luciano.coelho@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>

>> Hmmm... We got a problem here. =A0This patch breaks builds when we *=
don't*
>> have "omap: mmc extended to pass host capabilities from board file".=
 =A0We
>> don't have that on wireless-next yet, so builds with zoom boards
>> selected are broken.
>>
>> Any ideas on how to solve this dilemma? I guess the proper way to ha=
ndle
>> this would be to make the changes proposed in this patch when mergin=
g
>> instead of having a normal commit for it, wouldn't it?
>
> Just cherry-pick that change into the branch of your tree that I do
> _not_ pull from. =A0I presume that it is already available in linux-n=
ext?
>

Yup - both patches are in linux-next; that's where we noticed the build=
 break.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
