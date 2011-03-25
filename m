From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 01/19] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Fri, 25 Mar 2011 07:24:53 -0700
Message-ID: <87lj03wa4q.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-2-git-send-email-khilman@ti.com>
	<AANLkTikSxR5P8b-TQFoCgUvuvs8sGdYbTXvZxP0_etpx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59784 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752595Ab1CYOY6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 10:24:58 -0400
Received: by mail-gy0-f176.google.com with SMTP id 6so236432gya.35
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 07:24:56 -0700 (PDT)
In-Reply-To: <AANLkTikSxR5P8b-TQFoCgUvuvs8sGdYbTXvZxP0_etpx@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 09:58:34 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
>> The voltage domain pointer currently in struct omap_hwmod is not use=
d
>> and does not belong here. =C2=A0Instead, voltage domains will be ass=
ociated
>
> Extra space
>

heh.  My english teachers always taught me to put two spaces after a
period. ;)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
