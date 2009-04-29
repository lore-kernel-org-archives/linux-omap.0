From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: Issues with PM Branch
Date: Wed, 29 Apr 2009 01:45:48 -0500
Message-ID: <cb8016980904282345m31a1b041jacaf70338c80467d@mail.gmail.com>
References: <cb8016980904280917r453eee32tb582a212a6f529e5@mail.gmail.com>
	 <8763gopdrp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43711 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZD2Gpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 02:45:49 -0400
Received: by yx-out-2324.google.com with SMTP id 3so598054yxj.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 23:45:48 -0700 (PDT)
In-Reply-To: <8763gopdrp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> The non-USB related hang looks like the problem when using smartrefle=
x
> without SRF. =A0If you disable smartreflex, or use smartreflex with S=
RF
> you should boot past that hang.
>
> For MUSB, it has not yet been validated on the PM branch.

Thanks Kevin... I have disabled SmartReflex, it is booting now but
after some time of interaction, console will become unresponsive,
commands won't be executed

 # ps -aux
 ^C

Is there any setting I should set up before in menuconfig? sysfs?

Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
