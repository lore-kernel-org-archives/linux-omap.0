From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: git tree
Date: Thu, 25 Jun 2009 19:38:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F546277D@dbde02.ent.ti.com>
References: <376636be0906240234n2b9f9e77g12c8a6494bbd245e@mail.gmail.com>
 <20090624111024.GO7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34240 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbZFYOIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 10:08:34 -0400
In-Reply-To: <20090624111024.GO7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ryan <ryanphilips19@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.k=
ernel.org] On Behalf Of Tony
>
>Hi,
>
>* Ryan <ryanphilips19@googlemail.com> [090624 12:42]:
>> Hi,
>> =A0 Looking at the linux-omap tree using the gitweb interface. Apart
>> from the "master" branch and tags.
>> =A0 why do we have lots of branches? How and when do they intertact =
with
>> each other.
>>
>> Can anyone explain what exactly goes into each of them?
>> Some are straight forward like pm, usb, tidspbridge, gateway. not su=
re
>> about for-next-2.6.30, omap-fixes.
>
>More or less the various branches are topic branches of patches
>going to the mainline kernel. For example, omap-fixes contains fixes t=
o
>be sent during the -rc cycle, omap-upstream contains omap common patch=
es
>for the next merge window, omap1-upstream omap1 specific patches for
>the next merge window and so on.
>
>The master branch is more or less merge of all the topic branches.
>Currently missing from it are the pm branch and the dss2 branch.
>
>> Trying to understand things/mode of development in here.
>
>Hope this helps. In general, your should now be able to do almost
>all the patches against Linus' mainline kernel. Of course until
>we get pm and dss2 into the mainline kernel, those patches need to
>be done against pm and dss2 branches.
>
>So everybody, where possible, please base all the patches against
>Linus' kernel stable something or -rc someting, that way they are
>easy to merge in.

Are you recommending that future patches posted to l-o list should be b=
ased of kernel.org=20
and not master of l-o?

>
>Regards,
>
>Tony
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
