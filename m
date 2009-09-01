From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [DSPBRIDGE RFC] Combining Reserve and Map into a new IOCTL
Date: Tue, 01 Sep 2009 18:13:19 +0300
Message-ID: <4A9D3A0F.4060608@gmail.com>
References: <4A9D2313.4040408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30974 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbZIAPN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 11:13:57 -0400
In-Reply-To: <4A9D2313.4040408@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Doyu Hiroshi <hiroshi.doyu@nokia.com>, Contreras Felipe <felipe.contreras@nokia.com>, Tereshonkov Roman Sergeevitch <roman.tereshonkov@nokia.com>

On 09/01/2009 04:35 PM, Ameya Palande wrote:
> Current approach has following problems:
0. It is brain-dead.
> 1. Caller has to perform 4 system calls in order to map and unmap a b=
uffer.
> 2. Kernel has no idea about the type of buffer (input/output). So dep=
ending
>     on buffer type caller has to explicitly call DSPProcessor_FlushMe=
mory() or
>     DSPProcessor_InvalidateMemory().
>
> Proposed approach:
> Introduce 2 new IOCTLs which combine (reserve, map) and (unmap, unres=
erve).
> Caller should also specify buffer type (input/output) attribute as a
> parameter to new mapping IOCTL.
>
> Benefits of new approach:
> 1. Saves 2 system calls per map and unmap pair.
> 2. By implementing lazy unreserve we can introduce cache of reserved
>     mappings, which can skip reserve, unreserve operations.
> 3. Kernel can take care of flushing/invalidating cache depending on b=
uffer
>     type, which saves system call overhead and removed explicit cache=
 control
>     from user space.
>
> These IOCTLs can be added to the current set of API which doesn't bre=
ak
> compatibility with old applications.
>
> Waiting for comments!
>
> Ideas proposed in this document are from:
> 1. Hiroshi Doyu<hiroshi.doyu@nokia.com>
> 2. Felipe Contreras<felipe.contreras@nokia.com>

Sounds good for an non-expert.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
