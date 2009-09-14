From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: dspbridge rfc: get rid of services/list.c (v3)
Date: Mon, 14 Sep 2009 18:55:34 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A6121F1B@dlee06.ent.ti.com>
References: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519AbZINXzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 19:55:37 -0400
In-Reply-To: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>


Hi, 

	Sorry for the delay. Thanks for the patch please see my comments on the patches.

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Tuesday, September 08, 2009 7:12 AM
>To: linux-omap@vger.kernel.org
>Cc: hiroshi.doyu@nokia.com
>Subject: dspbridge rfc: get rid of services/list.c (v3)
>
>
>Hello.
>
>Here are a few patches which change driver's own circular linked list
>implementation to native one in linux kernel. The initial idea was come
>from
>Hiroshi Doyu.

Yea we are agree, we should move to the linux kernel linked list implementation, in future patches we would like to get rid of the wrappers also.

>
>This version includes corrections which I got from Imre, Artem and Felipe.
>
>All patches are rebased against android-bridge-2.6.29 kernel branch of the
>kernel-dspbridge repository.
>
>Please, review them. Thank you.
>
>--
>With Best Regards,
>Andy Shevchenko
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Fernando.

