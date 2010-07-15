From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 06:48:50 +0200
Message-ID: <201007150648.50521.marek.vasut@gmail.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com> <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab0GOEtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 00:49:09 -0400
Received: by bwz1 with SMTP id 1so325689bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Jul 2010 21:48:54 -0700 (PDT)
In-Reply-To: <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, Yoshiya.Hirase@nokia.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, teerth@ti.com, linux-pm@lists.linux-foundation.org

Dne St 30. =C4=8Dervna 2010 16:28:01 Hiroshi DOYU napsal(a):
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>=20
> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>=20
> Based on the original work from Romit and Raghu at TI. The original
> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>=20
> *1: https://patchwork.kernel.org/patch/96442/
>=20
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Hey, can this also run on pre-v7 arms ? Or is there something I missed =
that'd=20
make that impossible?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
