From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 08/17] omap: mailbox: only compile for configured archs
Date: Sat, 15 May 2010 01:24:15 +0300
Message-ID: <AANLkTilPh72HNFBx5ZkOVOFUf0tiR8CL7-7Abjgxbx0G@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	 <1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46663 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0ENWYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 18:24:17 -0400
Received: by fxm6 with SMTP id 6so1995046fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 15:24:16 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On Sat, May 15, 2010 at 12:27 AM, Kanigeri, Hari <h-kanigeri2@ti.com> w=
rote:
>>
>> - =C2=A0 =C2=A0 if (cpu_is_omap3430()) {
>> + =C2=A0 =C2=A0 if (false);
>
> -- Is this statement needed ?

Yeah, so:

if (false);
#if 0
else if (foo) {
}
#endif
else {
  return -1;
}

Works.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
