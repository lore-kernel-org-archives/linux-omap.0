From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/8] OMAP3/4: Misc fixes and clean-up
Date: Sat, 24 Sep 2011 13:16:35 +0530
Message-ID: <4E7D8ADB.1080109@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com> <4E7D72BF.8060009@ti.com> <alpine.DEB.2.00.1109240031280.22872@utopia.booyaka.com> <4E7D7A28.3070005@ti.com> <alpine.DEB.2.00.1109240120240.22872@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34097 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab1IXHqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 03:46:42 -0400
Received: by gwm11 with SMTP id 11so3222007gwm.2
        for <linux-omap@vger.kernel.org>; Sat, 24 Sep 2011 00:46:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109240120240.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 24 September 2011 01:06 PM, Paul Walmsley wrote:
> Hi
>=20
> On Sat, 24 Sep 2011, Santosh Shilimkar wrote:
>=20
>> On Saturday 24 September 2011 12:01 PM, Paul Walmsley wrote:
>>> Hi Santosh
>>>
>>> On Sat, 24 Sep 2011, Santosh Shilimkar wrote:
>>>
>>>> On Thursday 08 September 2011 10:51 AM, Santosh Shilimkar wrote:
>>>>>
>>>> I need your ack on below two patches so that I can re-base them an=
d
>>>> send a pull request to Tony.
>>>>
>>>> OMAP4: clock: Add CPU local timer clock node.
>>>> OMAP: Fix sparse warnings in l3 error handler.
>>>
>>> Are you targeting these for 3.1-rc ?
>>>
>> Nope. It's for 3.2 merge window.
>> As such, the series doesn't have any major regression
>> fixes which should make it before 3.2
>=20
> In that case, patches 1 and 7 should go in through me.  The rest shou=
ld go=20
> via Tony.  So you can just drop 1 and 7 from your branch, I'll pull t=
hose=20
> off the list.=20
>=20
Will do.

> Some comments though:  Looks like you need to repost patch 1 due to=20
> comments from Beno=EEt?  Also, have the autogeneration scripts been u=
pdated=20
> for patch 7?
>=20
Ok. Will post updated patch1.
=46or the patch 7, I will align with Benoit on the autogen script. It h=
as
some differences with mainline OMAP4 clock data file.

> ...
>=20
> As far as patch 5 goes, you don't need my ack on that one, since I'm =
not=20
> the maintainer or original author of that code.  But feel free to add=
 a=20
> Reviewed-by:.  I also tested the two L3 files with sparse and they ar=
e=20
> clean now.  Thanks very much for taking the initiative on this; I=20
> personally appreciate it quite a bit, and I think having clean code=20
> increases our credibility with upstream maintainers.=20
>=20
Actually I wanted you to have a look to ensure that we addressed the
all sparce warnings. Will add your reviewed by on that patch.

Couldn't agree more on the clean code remark.

Regards
Santosh



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
