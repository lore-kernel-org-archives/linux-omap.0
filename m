From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH 05/12] staging:tidspbridge - set5 remove hungarian from structs
Date: Thu, 23 Dec 2010 16:40:57 -0600
Message-ID: <AANLkTinsSAfNxNkcv6QK0VKbs2JXVtRLO0Yxqyx5-NPd__34506.8610310138$1293144092$gmane$org@mail.gmail.com>
References: <1292358798-25875-1-git-send-email-rene.sapiens@ti.com>
	<1292358798-25875-2-git-send-email-rene.sapiens@ti.com>
	<1292358798-25875-3-git-send-email-rene.sapiens@ti.com>
	<1292358798-25875-4-git-send-email-rene.sapiens@ti.com>
	<1292358798-25875-5-git-send-email-rene.sapiens@ti.com>
	<1292358798-25875-6-git-send-email-rene.sapiens@ti.com>
	<20101215085305.GC1639@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38862 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193Ab0LWWk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 17:40:58 -0500
In-Reply-To: <20101215085305.GC1639@bicker>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Rene Sapiens <rene.sapiens@ti.com>, omar.ramirez@ti.com, nm@ti.com, ohad@wizery.com, ionut.nicu@mindbit.ro, devel@driverdev.osuosl.org, ivan.gomez@t

Hi Dan,

On Wed, Dec 15, 2010 at 2:53 AM, Dan Carpenter <error27@gmail.com> wrot=
e:
> On Tue, Dec 14, 2010 at 02:33:11PM -0600, Rene Sapiens wrote:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pf=
n_unload(pnode->nldr_node_obj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lo=
ad(pnode->nldr_node_obj,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0NLDR_EXECUTE);
>
> Unload got swapped with load here.
>
> This might have been easier to with Coccinelle instead of by hand...
>

I'm sorry for the delay, i did use some scripts to identify/replace
the words, this last one should be because of my lasts coding style
fixes after changes, i will fix it and send the patch again. Indeed
Coccinelle is a very good option too.

--=20
Regards,
Rene Sapiens
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
