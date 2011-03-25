From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 08/19] OMAP2+: powerdomain: add voltagedomain to struct powerdomain
Date: Fri, 25 Mar 2011 08:49:58 -0700
Message-ID: <871v1vurmh.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-9-git-send-email-khilman@ti.com>
	<AANLkTinc=oQv1uuv_=HZHTdrKiaGzTG0nk-Bimjet2_2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48266 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984Ab1CYPuC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:50:02 -0400
Received: by pwj4 with SMTP id 4so185263pwj.30
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:50:01 -0700 (PDT)
In-Reply-To: <AANLkTinc=oQv1uuv_=HZHTdrKiaGzTG0nk-Bimjet2_2@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 10:05:28 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Each powerdomain is associated with a powerdomain. =C2=A0Add an entr=
y to
>
> Do you mean '... with a voltage domain'?
>

yup, thanks.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
